CREATE TABLE Produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    preco DECIMAL(10,2),
    estoque INT,
    categoria_id INT
) ENGINE=InnoDB;

CREATE TABLE Pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATETIME
) ENGINE=InnoDB;

CREATE TABLE ItensPedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    FOREIGN KEY (pedido_id) REFERENCES Pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES Produtos(id)
) ENGINE=InnoDB;

CREATE TABLE AuditoriaEstoque (
    id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    alteracao INT,
    data_alteracao DATETIME,
    motivo VARCHAR(255),
    FOREIGN KEY (produto_id) REFERENCES Produtos(id)
) ENGINE=InnoDB;

-- Inserindo produtos fictícios

INSERT INTO Produtos (nome, preco, estoque, categoria_id) VALUES
('Notebook', 3000.00, 10, 1),
('Mouse', 100.00, 20, 1),
('Teclado', 150.00, 5, 1),
('Cadeira Gamer', 1200.00, 3, 2),
('Monitor', 800.00, 7, 2);

-- Sem necessidade de inserir pedidos ou auditoria agora

-- CENÁRIO 1: VENDA POR LOTE
START TRANSACTION;

-- Reduz estoque do Produto 1 (id = 1)
UPDATE Produtos
SET estoque = estoque - 2
WHERE id = 1 AND estoque >= 2;

SET @row_count1 = ROW_COUNT();

-- Reduz estoque do Produto 2 (id = 2)
UPDATE Produtos
SET estoque = estoque - 1
WHERE id = 2 AND estoque >= 1;

SET @row_count2 = ROW_COUNT();

-- Se ambos os updates funcionaram:
If @row_count1 > 0 AND @row_count2 > 0 THEN
    -- Cria pedido
    INSERT INTO Pedidos (data_pedido) VALUES (NOW());
    SET @pedido_id = LAST_INSERT_ID();

    -- Adiciona os itens
    INSERT INTO ItensPedido (pedido_id, produto_id, quantidade) VALUES
      (@pedido_id, 1, 2),
      (@pedido_id, 2, 1);

    COMMIT;
ELSE
    ROLLBACK;
END IF; 

-- CENÁRIO 2: AUDITORIA DE ESTOQUE
START TRANSACTION;

-- Atualiza o estoque (ex: adicionando 5 unidades ao produto id = 3)
UPDATE Produtos
SET estoque = estoque + 5
WHERE id = 3;

-- Registra na auditoria
INSERT INTO AuditoriaEstoque (produto_id, alteracao, data_alteracao, motivo)
VALUES (3, 5, NOW(), 'Reposição manual de estoque');

COMMIT;
-- CENÁRIO 3: PROMOÇÃO-RELÂMPAGO
START TRANSACTION;

-- Aplica 20% de desconto nos produtos da categoria 2
UPDATE Produtos
SET preco = preco * 0.8
WHERE categoria_id = 2;

-- Verifica os preços atualizados (opcional)
SELECT id, nome, preco FROM Produtos WHERE categoria_id = 2;

-- Reverte a promoção (nada será salvo)
ROLLBACK;



