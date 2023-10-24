create table Filmes(
    id int primary key auto_increment,
    titulo varchar(60),
    minutos int
);

delimiter $
create trigger chk_minutos before insert on Filmes
    for each row
    begin
        if new.minutos < 0 then
            set new.minutos = null;
        end if;
    end $
delimiter ;

create trigger chkn_minutos before insert on Filmes
    for each row
    begin
        if new.minutos < 0 then

            -- Lancar erro
            signal SQLSTATE '45000' -- excessao nao tratada
            set MESSAGE_TEXT = 'Valor invalido para minutos',
            MYSQL_ERRNO = 2022;
        end if;
    end;

create table Log_deletions (
    id int primary key auto_increment,
    titulo varchar(60),
    quando datetime,
    quem varchar(40)
);

delimiter $
create trigger Log_deletions after delete on Filmes
    for each row
    begin
        insert into Log_deletions values (null, old.titulo, sysdate(), user());
    end$
delimiter ;

delete from Filmes where id = 2;
delete from Filmes where id = 4;

select *
from Log_deletions;

insert into Filmes (titulo, minutos) values ('The Terrible trigger', 120);
insert into Filmes (titulo, minutos) values ('O alto da compadecida', 135);
insert into Filmes (titulo, minutos) values ('Faroeste caboclo', 240);
insert into Filmes (titulo, minutos) values ('The Matrix', 90);
insert into Filmes (titulo, minutos) values ('Blade runner', -88);
insert into Filmes (titulo, minutos) values ('O labirinto do fauno', 110);
insert into Filmes (titulo, minutos) values ('Metropole', 0);
insert into Filmes (titulo, minutos) values ('A lista', 120);