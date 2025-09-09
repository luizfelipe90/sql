create database ecommerce; 

use ecommerce;

/*tabela clientes*/

create table clientes(
id int auto_increment primary key,
nome varchar(108) not null,
email varchar(180) unique not null,
senha varchar(12) not null,
telefone varchar(20),
criado_em datetime default current_timestamp
);

/*Tabela Enderecos */

Create table enderecos (
id int auto_increment primary key,
cliente_id int,
rua varchar(100),
numero varchar(10),
complemento varchar(100),
bairro varchar(58),
cidade varchar(50),
estado char (2)
);
/*Tabela Categorias*/ 

Create table categorias(
id int auto_increment primary key,
nome varchar(188) not null,
descricao text
);

/*Tabela Produtos*/

create table produtos (
id int auto_increment primary key,
cliente_id int,
data_pedido datetime default current_timestamp,
status varchar(50) default 'Pendente',
total decimal(19,2)
); 

   /*Tabela itens pedido*/
create table itens_pedido(

id int auto_increment primary key,
pedido_id int,
produto_id int,
quantidade int not null,
preco_unitario decimal(10,2) not null
);  

show tables; 
describe clientes;


