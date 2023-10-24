create table Pedidos (
    IDPedido INT auto_increment primary key,
    DataPedido DATETIME,
    NomeCliente varchar(100)
);

insert into Pedidos(DataPedido, NomeCliente) values
                                                (NOW(), 'Cliente 1'),
                                                (NOW(), 'Cliente 2'),
                                                (NOW(), 'Cliente 3');

DELIMITER $
create trigger RegistroDataCriacaoPedido
before insert on Pedidos
for EACH ROW
begin
    set NEW.DataPedido = NOW();
end;
$
DELIMITER ;

insert into Pedidos(NomeCliente) values ('novo cliente');

select *
from Pedidos;