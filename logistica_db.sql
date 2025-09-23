CREATE DATABASE logistica_db;
USE logistica_db;

-- Criação das tabelas com tipos corretos e chaves estrangeiras

CREATE TABLE Clientes (
    CNPJ VARCHAR(18) PRIMARY KEY,
    nome VARCHAR(100),
    contato VARCHAR(100),
    status_pagamento ENUM('adimplente', 'inadimplente')
) ENGINE=InnoDB;

CREATE TABLE Motoristas (
    CNH VARCHAR(15) PRIMARY KEY,
    nome VARCHAR(100),
    telefone VARCHAR(20),
    situacao ENUM('ativo', 'inativo'),
    tipo_motorista ENUM('empresa', 'terceirizado')
) ENGINE=InnoDB;

CREATE TABLE Veiculos (
    placa VARCHAR(10) PRIMARY KEY,
    modelo VARCHAR(50),
    ano INT,
    capacidade DECIMAL(10,2),
    status ENUM('disponivel', 'manutencao', 'em_servico')
) ENGINE=InnoDB;

CREATE TABLE Rotas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    origem VARCHAR(100),
    destino VARCHAR(100),
    distancia DECIMAL(10,2),
    prazo INT
) ENGINE=InnoDB;

CREATE TABLE Entregas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente VARCHAR(18),
    motorista VARCHAR(15),
    veiculo VARCHAR(10),
    rota INT,
    data_saida DATE,
    previsao DATE,
    entrega_real DATE,
    status ENUM('em_andamento', 'concluida', 'atrasada', 'cancelada'),
    FOREIGN KEY (cliente) REFERENCES Clientes(CNPJ),
    FOREIGN KEY (motorista) REFERENCES Motoristas(CNH),
    FOREIGN KEY (veiculo) REFERENCES Veiculos(placa),
    FOREIGN KEY (rota) REFERENCES Rotas(id)
) ENGINE=InnoDB;

CREATE TABLE Ocorrencias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    entrega INT,
    tipo ENUM('acidente', 'roubo', 'problema_mecanico', 'outros'),
    descricao TEXT,
    data DATE,
    FOREIGN KEY (entrega) REFERENCES Entregas(id)
) ENGINE=InnoDB;

CREATE TABLE Pagamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente VARCHAR(18),
    entrega INT,
    valor DECIMAL(10,2),
    forma ENUM('boleto', 'pix', 'cartao', 'transferencia'),
    status ENUM('pago', 'pendente', 'cancelado'),
    FOREIGN KEY (cliente) REFERENCES Clientes(CNPJ),
    FOREIGN KEY (entrega) REFERENCES Entregas(id)
) ENGINE=InnoDB;

CREATE TABLE Funcionarios (
    matricula INT PRIMARY KEY,
    nome VARCHAR(100),
    setor VARCHAR(50),
    contato VARCHAR(100)
) ENGINE=InnoDB;

-- Índices
CREATE INDEX idx_placa ON Veiculos (placa);
CREATE INDEX idx_cnh ON Motoristas (CNH);
CREATE INDEX idx_cnpj ON Clientes (CNPJ);

-- Procedures adaptados

DELIMITER //

CREATE PROCEDURE RegistrarEntrega (
    IN p_cliente VARCHAR(18),
    IN p_motorista VARCHAR(15),
    IN p_veiculo VARCHAR(10),
    IN p_rota INT,
    IN p_saida DATE,
    IN p_previsao DATE
)
BEGIN
    INSERT INTO Entregas (cliente, motorista, veiculo, rota, data_saida, previsao, status)
    VALUES (p_cliente, p_motorista, p_veiculo, p_rota, p_saida, p_previsao, 'em_andamento');
END;
//

CREATE PROCEDURE AtualizarStatusEntrega (
    IN p_entrega_id INT,
    IN p_entrega_real DATE
)
BEGIN
    DECLARE data_prevista DATE;

    SELECT previsao INTO data_prevista FROM Entregas WHERE id = p_entrega_id;

    IF p_entrega_real <= data_prevista THEN
        UPDATE Entregas SET entrega_real = p_entrega_real, status = 'concluida' WHERE id = p_entrega_id;
    ELSE
        UPDATE Entregas SET entrega_real = p_entrega_real, status = 'atrasada' WHERE id = p_entrega_id;
    END IF;
END;
//

CREATE PROCEDURE RegistrarPagamento (
    IN p_cliente VARCHAR(18),
    IN p_entrega INT,
    IN p_valor DECIMAL(10,2),
    IN p_forma VARCHAR(20)
)
BEGIN
    START TRANSACTION;
        INSERT INTO Pagamentos (cliente, entrega, valor, forma, status)
        VALUES (p_cliente, p_entrega, p_valor, p_forma, 'pago');

        UPDATE Clientes 
          SET status_pagamento = 'adimplente' 
          WHERE CNPJ = p_cliente;
    COMMIT;
END;
//

DELIMITER ;

-- Inserções de dados simulados (exemplos para algumas tabelas, você pode completar para 50)

INSERT INTO Clientes (CNPJ, nome, contato, status_pagamento) VALUES
('12345678000199', 'Ambev', 'contato@ambev.com.br', 'adimplente'),
('98765432000199', 'Natura', 'contato@natura.com.br', 'inadimplente'),
('11111111000100', 'Magazine Luiza', 'contato@magazineluiza.com.br', 'adimplente');

INSERT INTO Motoristas (CNH, nome, telefone, situacao, tipo_motorista) VALUES
('12345678901','Carlos Silva','11999990000','ativo','empresa'),
('10987654321','Fernanda Souza','21988887777','ativo','terceirizado'),
('22233344455','João Pedro','31977776666','ativo','empresa');

INSERT INTO Veiculos (placa, modelo, ano, capacidade, status) VALUES
('ABC1A23','Volvo FH','2015',25000.00,'disponivel'),
('XYZ2B56','Mercedes Actros','2018',30000.00,'em_servico'),
('DEF3C67','Scania P310','2017',27000.00,'manutencao');

INSERT INTO Rotas (origem, destino, distancia, prazo) value
('São Paulo','Rio de Janeiro',430.0,2),
('Belo Horizonte','Brasília',740.0,3),
('Curitiba','Porto Alegre',710.0,3);

INSERT INTO Entregas (cliente, motorista, veiculo, rota, data_saida, previsao, entrega_real, status) VALUES
('12345678000199','12345678901','ABC1A23',1,'2025-09-01','2025-09-03',NULL,'em_andamento'),
('98765432000199','10987654321','XYZ2B56',2,'2025-08-28','2025-08-31','2025-08-30','concluida'),
('11111111000100','22233344455','DEF3C67',3,'2025-09-02','2025-09-05','2025-09-06','atrasada');

INSERT INTO Ocorrencias (entrega, tipo, descricao, data) VALUES
(2,'acidente','Acidente envolvendo veículo pequeno','2025-08-30'),
(3,'problema_mecanico','Pane no motor','2025-09-06');

INSERT INTO Pagamentos (cliente, entrega, valor, forma, status) VALUES
('98765432000199',2, 3500.00, 'pix', 'pago'),
('12345678000199',1, 2800.50, 'boleto', 'pendente');

INSERT INTO Funcionarios (matricula, nome, setor, contato) VALUES
(1,'Paulo Silva','Operações','paulo.silva@empresa.com.br'),
(2,'Marina Costa','Financeiro','marina.costa@empresa.com.br');

-- Consultas de exemplo (algumas das 20)

-- 1) Entregas em andamento com motorista, veículo e rota
SELECT e.id, m.nome AS motorista, v.modelo AS veiculo, r.origem, r.destino
FROM Entregas e
JOIN Motoristas m ON e.motorista = m.CNH
JOIN Veiculos v ON e.veiculo = v.placa
JOIN Rotas r ON e.rota = r.id
WHERE e.status = 'em_andamento';

-- 2) Ranking dos clientes que mais contrataram fretes
SELECT c.CNPJ, c.nome, COUNT(*) AS total_entregas
FROM Entregas e
JOIN Clientes c ON e.cliente = c.CNPJ
GROUP BY c.CNPJ, c.nome
ORDER BY total_entregas DESC
LIMIT 10;

-- 3) Motoristas com o maior índice de atrasos
SELECT m.CNH, m.nome, COUNT(*) AS atrasos
FROM Entregas e
JOIN Motoristas m ON e.motorista = m.CNH
WHERE e.entrega_real IS NOT NULL AND e.entrega_real > e.previsao
GROUP BY m.CNH, m.nome
ORDER BY atrasos DESC;

-- 4) Rotas com o maior número de ocorrências
SELECT r.id, r.origem, r.destino, COUNT(o.id) AS total_ocorrencias
FROM Ocorrencias o
JOIN Entregas e ON o.entrega = e.id
JOIN Rotas r ON e.rota = r.id
GROUP BY r.id, r.origem, r.destino
ORDER BY total_ocorrencias DESC;


