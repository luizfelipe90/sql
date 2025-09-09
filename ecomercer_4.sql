create table pedidos(
 id int auto_increment primary key,
 pedido_id 	int, 
 data_pedido  datetime default current_timestamp, 
 sitacao varchaR (50) default 'pendentes', 
 total decimal(10,2)
); 