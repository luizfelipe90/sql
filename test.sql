create database test;   
use test; 


create table usuarios(
id int auto_increment primary key,
nome varchar(108) not null,
email varchar(180) unique not null,
senha varchar(12) not null,
celular varchar(20), 
cpf    varchar(20),
criado_em datetime default current_timestamp
);



Create table enderecos (
id int auto_increment primary key,
cliente_id int,
rua varchar(100),
numero varchar(10),
bairro varchar(58),
cidade varchar(50),
estado char (2), 
cep varchar (10)
);  


Create table categorias(
id int auto_increment primary key,
nome varchar(188) not null,
descricao text
);



create table produtos (
id int auto_increment primary key,
nome int,
descricao datetime default current_timestamp, 
preco varchar (5),
estoque varchar(3),
categoria_id varchar (100)
);  

create table pedidos (  
id int auto_increment primary key,
cliente_id varchar (100),
criado_em datetime default current_timestamp,
status varchar(50) default 'Pendente',
total decimal(19,2) 
);  

create table itens_pedido(
id int auto_increment primary key,
pedido_id int,
produto_id int,
quantidade int not null,
preco_unitario decimal(10,2) not null
);   


insert into usuarios (nome, email, senha, celular, cpf) values 
("joaninha", "jona123@hotmail.com","joana246", "9999-9999","123.345.452.23"),
("zullu", "zulu123@hotmail.com","zullu246", "8888-8888","023.045.052.03"), 
("kullu", "kullu123@hotmail.com","kullu276", "8800-7888","123.345.552.63"), 
("vozo", "vozo123@hotmail.com","vozo246", "8858-8688","023.000.052.03"), 
("cell", "cell123@hotmail.com","cell246", "8008-8008","055.675.882.93"),
("acua", "acua123@hotmail.com","acua246", "8888-8504","843.767.456.67"), 
("zizi", "zizi123@hotmail.com","zizi246", "8828-8538","023.098.623.41"), 
("toro", "toro123@hotmail.com","toro246", "8818-8188","023.045.052.43"),
("tia", "tia123@hotmail.com","tia246", "8658-8908","023.945.442.03"), 
("tokio", "tokio123@hotmail.com","tokio246", "8118-8228","023.888.052.03"),
("marina", "marina2025@hotmail.com", "marina123", "9123-4567", "123.456.789-00"),
("carlos", "carlos2025@gmail.com", "carlos456", "9234-5678", "234.567.890-11"),
("ana", "ana.silva@yahoo.com", "ana789", "9345-6789", "345.678.901-22"),
("bruno", "bruno123@gmail.com", "bruno321", "9456-7890", "456.789.012-33"),
("leticia", "leticia2025@hotmail.com", "leticia654", "9567-8901", "567.890.123-44"),
("pedro", "pedro.lima@gmail.com", "pedro987", "9678-9012", "678.901.234-55"),
("sara", "sara.oliveira@yahoo.com", "sara321", "9789-0123", "789.012.345-66"),
("rafael", "rafael2025@gmail.com", "rafael654", "9890-1234", "890.123.456-77"),
("julia", "julia.santos@hotmail.com", "julia987", "9901-2345", "901.234.567-88"),
("thiago", "thiago2025@gmail.com", "thiago123", "9012-3456", "012.345.678-99"),
("marcos", "marcos.junior@yahoo.com", "marcos456", "8123-4567", "123.987.654-00"),
("aline", "aline2025@gmail.com", "aline789", "8234-5678", "234.876.543-11"),
("felipe", "felipe.silva@hotmail.com", "felipe321", "8345-6789", "345.765.432-22"),
("carla", "carla2025@gmail.com", "carla654", "8456-7890", "456.654.321-33"),
("joao", "joao.souza@yahoo.com", "joao987", "8567-8901", "567.543.210-44"),
("vanessa", "vanessa2025@gmail.com", "vanessa321", "8678-9012", "678.432.109-55"),
("ricardo", "ricardo.oliveira@hotmail.com", "ricardo654", "8789-0123", "789.321.098-66"),
("luana", "luana2025@gmail.com", "luana987", "8890-1234", "890.210.987-77"),
("gustavo", "gustavo.santos@yahoo.com", "gustavo123", "8901-2345", "901.109.876-88"),
("beatriz", "beatriz2025@gmail.com", "beatriz456", "8012-3456", "012.098.765-99");
select * from usuarios; 

insert into enderecos (cliente_id, rua, numero, bairro, cidade, estado, cep) values 
(1, "jumento", "4", "telesena", "torneirinha","df", "1234567-90"),  
(1, "Rua das Flores", "100", "Jardim Primavera", "São Paulo", "SP", "01001-000"),
(2, "Avenida Central", "250", "Centro", "Rio de Janeiro", "RJ", "20010-050"),
(3, "Travessa do Sol", "32", "Vila Nova", "Belo Horizonte", "MG", "30120-030"),
(4, "Rua das Acácias", "78", "Parque das Árvores", "Curitiba", "PR", "80020-040"),
(5, "Alameda Santos", "150", "Jardins", "São Paulo", "SP", "01419-000"),
(6, "Rua do Comércio", "12", "Centro", "Fortaleza", "CE", "60020-060"),
(7, "Rua das Laranjeiras", "45", "Laranjeiras", "Rio de Janeiro", "RJ", "22240-040"),
(8, "Avenida Brasil", "999", "Centro", "Brasília", "DF", "70040-010"),
(9, "Rua dos Pinheiros", "300", "Pinheiros", "São Paulo", "SP", "05422-000"),
(10, "Travessa das Palmeiras", "88", "Palmeiras", "Manaus", "AM", "69020-020"),
(11, "Rua das Orquídeas", "77", "Orquídea", "Porto Alegre", "RS", "90040-030"),
(12, "Avenida das Nações", "50", "Nação", "Recife", "PE", "50030-040"),
(13, "Rua do Progresso", "123", "Progresso", "Salvador", "BA", "40010-050"),
(14, "Rua dos Girassóis", "22", "Girassol", "Campinas", "SP", "13020-060"),
(15, "Alameda dos Anjos", "14", "Anjos", "Florianópolis", "SC", "88010-070"),
(16, "Rua dos Jasmins", "56", "Jardim das Flores", "Goiânia", "GO", "74010-080"),
(17, "Rua do Carmo", "90", "Centro", "São Luís", "MA", "65010-090"),
(18, "Rua do Mar", "33", "Praia", "Niterói", "RJ", "24020-100"),
(19, "Rua das Hortênsias", "18", "Hortênsia", "Joinville", "SC", "89210-110"),
(20, "Rua da Paz", "77", "Paz", "Belém", "PA", "66010-120"),
(21, "Avenida Ipiranga", "500", "Centro", "Porto Alegre", "RS", "90020-130"),
(22, "Rua do Lago", "25", "Lagoa", "Rio de Janeiro", "RJ", "22440-140"),
(23, "Rua da Esperança", "61", "Esperança", "São Paulo", "SP", "01540-150"),
(24, "Rua das Magnólias", "45", "Magnólia", "Belo Horizonte", "MG", "30320-160"),
(25, "Rua do Sol", "99", "Sol Nascente", "Fortaleza", "CE", "60800-170"),
(26, "Rua das Palmeiras", "3", "Palmeiras", "Recife", "PE", "50040-180"),
(27, "Rua da Amizade", "110", "Amizade", "Curitiba", "PR", "80220-190"),
(28, "Avenida das Flores", "88", "Jardim das Flores", "Manaus", "AM", "69030-200"),
(29, "Rua do Pinheiro", "15", "Pinheiros", "São Paulo", "SP", "05430-210");
select * from enderecos;   

insert into categorias (nome, descricao) values
("roupas", 'categoria roupa'),  
("roupas", 'Categoria de roupas em geral'),
("eletrônicos", 'Aparelhos eletrônicos e gadgets'),
("calçados", 'Todos os tipos de calçados'),
("acessórios", 'Acessórios variados como bolsas, relógios e joias'),
("beleza", 'Produtos de beleza e cuidados pessoais'),
("móveis", 'Móveis para casa e escritório'),
("brinquedos", 'Brinquedos para todas as idades'),
("esportes", 'Equipamentos e roupas esportivas'),
("livros", 'Livros e materiais de leitura'),
("informática", 'Produtos de informática e tecnologia'),
("alimentos", 'Produtos alimentícios e bebidas'),
("automotivo", 'Peças e acessórios automotivos'),
("ferramentas", 'Ferramentas manuais e elétricas'),
("jardim", 'Produtos para jardinagem e áreas externas'),
("telefonia", 'Celulares, acessórios e telefonia'),
("infantil", 'Produtos para bebês e crianças'),
("saúde", 'Produtos de saúde e bem-estar'),
("papelaria", 'Material escolar e de escritório'),
("roupas íntimas", 'Lingerie e roupas íntimas'),
("eletrônicos de áudio", 'Equipamentos de som e áudio'),
("moda masculina", 'Roupas e acessórios masculinos'),
("moda feminina", 'Roupas e acessórios femininos'),
("decoração", 'Itens para decoração de ambientes'),
("pet shop", 'Produtos para animais de estimação'),
("bebidas", 'Bebidas alcoólicas e não alcoólicas'),
("informatica gamer", 'Produtos para jogos e gamers'),
("relógios", 'Relógios de pulso e acessórios'),
("jóias", 'Joias e bijuterias'),
("viagem", 'Produtos para viagem e turismo'),
("papelaria criativa", 'Material criativo e artesanal');
select * from categorias;  

insert into produtos (nome, descricao, preco, estoque, categoria_id) values 

("Camiseta Básica", "Camiseta 100% algodão, disponível em várias cores", 29.90, 150, 1),
("Smartphone XYZ", "Smartphone com tela de 6.5'', 128GB de armazenamento", 1999.99, 50, 2),
("Tênis Esportivo", "Tênis confortável para corrida e caminhada", 149.90, 75, 3),
("Relógio de Pulso", "Relógio analógico com pulseira de couro", 249.90, 40, 4),
("Kit Maquiagem", "Conjunto com base, pó e batom", 89.90, 60, 5),
("Sofá 3 Lugares", "Sofá retrátil e reclinável em couro sintético", 1599.00, 10, 6),
("Quebra-cabeça 1000 peças", "Quebra-cabeça educativo para todas as idades", 49.90, 120, 7),
("Bola de Futebol", "Bola oficial para jogos profissionais", 199.90, 30, 8),
("Livro: Aprendendo Python", "Livro para iniciantes em programação Python", 59.90, 80, 9),
("Mouse Gamer", "Mouse com alta precisão e iluminação RGB", 129.90, 90, 10),
("Cereal Matinal", "Cereal integral para um café da manhã saudável", 15.90, 200, 11),
("Óleo de Motor 5W-30", "Óleo sintético para motores modernos", 79.90, 50, 12),
("Furadeira Elétrica", "Furadeira com bateria recarregável e torque ajustável", 299.90, 25, 13),
("Conjunto de Jardinagem", "Ferramentas básicas para cuidar do jardim", 89.90, 40, 14),
("Capinha para Celular", "Capinha protetora para smartphone", 39.90, 150, 15),
("Carrinho de Bebê", "Carrinho leve e dobrável para bebês", 899.00, 15, 16),
("Suplemento Vitamínico", "Vitaminas para reforçar a imunidade", 79.90, 100, 17),
("Agenda 2025", "Agenda diária com espaço para anotações", 29.90, 120, 18),
("Cueca Boxer", "Cueca boxer confortável em algodão", 39.90, 130, 19),
("Fone de Ouvido Bluetooth", "Fone sem fio com cancelamento de ruído", 299.90, 60, 20),
("Camisa Social Masculina", "Camisa social manga longa, algodão premium", 129.90, 70, 21),
("Vestido Casual", "Vestido leve e confortável para o dia a dia", 149.90, 50, 22),
("Vaso Decorativo", "Vaso em cerâmica para decoração", 79.90, 80, 23),
("Ração para Cães", "Ração completa para cães adultos", 129.90, 90, 24),
("Vinho Tinto Seco", "Vinho importado com sabor encorpado", 89.90, 70, 25),
("Teclado Mecânico Gamer", "Teclado com switches mecânicos e iluminação RGB", 399.90, 40, 26),
("Relógio Digital", "Relógio esportivo com cronômetro e alarme", 149.90, 60, 27),
("Brinco de Prata", "Brinco delicado em prata 925", 79.90, 100, 28),
("Mochila de Viagem", "Mochila resistente com vários compartimentos", 199.90, 30, 29),
("Caderno Artesanal", "Caderno feito à mão para desenhos e anotações", 49.90, 110, 30);

select * from produtos; 

INSERT INTO pedidos (cliente_id, criado_em, status, total) VALUES
('1', '2025-09-01 10:00:00', 'Pendente', 250.75),
('2', '2025-09-02 11:15:00', 'Pago', 150.00),
('3', '2025-09-03 12:30:00', 'Cancelado', 320.50),
('4', '2025-09-04 13:45:00', 'Pendente', 89.90),
('5', '2025-09-05 14:00:00', 'Pago', 499.99),
('6', '2025-09-06 09:20:00', 'Pendente', 120.00),
('7', '2025-09-07 10:10:00', 'Pago', 75.25),
('8', '2025-09-08 11:00:00', 'Pendente', 180.40),
('9', '2025-09-09 12:00:00', 'Pago', 230.00),
('10', '2025-09-10 13:00:00', 'Cancelado', 99.90),
('11', '2025-09-11 14:00:00', 'Pendente', 350.60),
('12', '2025-09-12 15:00:00', 'Pago', 210.00),
('13', '2025-09-13 16:00:00', 'Pendente', 145.75),
('14', '2025-09-14 17:00:00', 'Pago', 300.00),
('15', '2025-09-15 18:00:00', 'Cancelado', 50.50),
('16', '2025-09-16 19:00:00', 'Pendente', 400.00),
('17', '2025-09-17 20:00:00', 'Pago', 275.20),
('18', '2025-09-18 21:00:00', 'Pendente', 110.10),
('19', '2025-09-19 22:00:00', 'Pago', 99.99),
('20', '2025-09-20 23:00:00', 'Pendente', 88.80),
('21', '2025-09-21 08:00:00', 'Pago', 199.90),
('22', '2025-09-22 09:00:00', 'Pendente', 130.00),
('23', '2025-09-23 10:00:00', 'Pago', 350.00),
('24', '2025-09-24 11:00:00', 'Cancelado', 45.00),
('25', '2025-09-25 12:00:00', 'Pendente', 180.25),
('26', '2025-09-26 13:00:00', 'Pago', 230.50),
('27', '2025-09-27 14:00:00', 'Pendente', 175.75),
('28', '2025-09-28 15:00:00', 'Pago', 90.00),
('29', '2025-09-29 16:00:00', 'Pendente', 210.10),
('30', '2025-09-30 17:00:00', 'Pago', 299.99);
select * from pedidos; 

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 5, 2, 89.90),
(1, 1, 3, 29.90),
(2, 2, 1, 1999.99),
(2, 10, 2, 129.90),
(3, 3, 1, 149.90),
(3, 7, 4, 49.90),
(4, 8, 1, 199.90),
(5, 6, 1, 1599.00),
(5, 4, 2, 249.90),
(6, 9, 3, 59.90),
(7, 11, 5, 15.90),
(8, 12, 2, 79.90),
(9, 13, 1, 299.90),
(10, 14, 1, 89.90),
(11, 15, 4, 39.90),
(12, 16, 1, 899.00),
(13, 17, 3, 79.90),
(14, 18, 2, 29.90),
(15, 19, 6, 39.90),
(16, 20, 1, 299.90),
(17, 21, 2, 129.90),
(18, 22, 1, 149.90),
(19, 23, 3, 79.90),
(20, 24, 2, 129.90),
(21, 25, 1, 89.90),
(22, 26, 1, 399.90),
(23, 27, 2, 149.90),
(24, 28, 5, 79.90),
(25, 29, 1, 199.90),
(26, 30, 2, 49.90);
select *from itens_pedidos;




 