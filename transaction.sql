-- GARANTIR USO DA BASE DE DADOS
USE trabalho_ecommy;

-- CENÁRIO 1: VENDA POR LOTE
-- Descrição: Cria um pedido para múltiplos produtos. Se qualquer operação falhar, a transação é desfeita.

DELIMITER $$

DROP PROCEDURE IF EXISTS venda_por_lote $$

CREATE PROCEDURE venda_por_lote()
BEGIN
    DECLARE estoque1 INT DEFAULT 0;
    DECLARE estoque2 INT DEFAULT 0;

    -- Início da transação
    START TRANSACTION;

    -- Verificar estoque dos produtos (ex: produto 1 e 2)
    SELECT estoque INTO estoque1 FROM produtos WHERE id = 1;
    SELECT estoque INTO estoque2 FROM produtos WHERE id = 2;

    -- Verificação de disponibilidade
    IF estoque1 >= 2 AND estoque2 >= 1 THEN

        -- Cria o pedido para cliente ID 31
        INSERT INTO pedidos (cliente_id, criado_em, status, total)
        VALUES (31, NOW(), 'Pendente', 2059.79);

        -- Captura o ID do pedido recém-criado
        SET novo_pedido_id = LAST_INSERT_ID();

        -- Inserir itens do pedido
        INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario)
        VALUES 
            (novo_pedido_id, 1, 2, 29.90),
            (novo_pedido_id, 2, 1, 1999.99);

        -- Atualizar estoques
        UPDATE produtos SET estoque = estoque - 2 WHERE id = 1;
        UPDATE produtos SET estoque = estoque - 1 WHERE id = 2;

        COMMIT;
        SELECT '✅ Pedido criado com sucesso!' AS Resultado;

    ELSE
        ROLLBACK;
        SELECT '❌ Estoque insuficiente. Transação cancelada.' AS Resultado;
    END IF;
END 

DELIMITER ;

-- Executar cenário 1
CALL venda_por_lote();


-- CENÁRIO 2: AUDITORIA DE ESTOQUE
-- Descrição: Atualiza o estoque de um produto e registra a mudança na tabela de auditoria

-- Criar tabela de auditoria (se ainda não existir)
CREATE TABLE IF NOT EXISTS auditoria_estoque (
  id INT AUTO_INCREMENT PRIMARY KEY,
  produto_id INT NOT NULL,
  estoque_antigo INT,
  estoque_novo INT,
  alterado_em DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Início da transação
START TRANSACTION;

-- Ajustar o estoque do produto ID 3 para 50
SELECT estoque INTO @estoque_antigo FROM produtos WHERE id = 3;
UPDATE produtos SET estoque = 50 WHERE id = 3;
INSERT INTO auditoria_estoque (produto_id, estoque_antigo, estoque_novo)
VALUES (3, @estoque_antigo, 50);

-- Finalizar transação
COMMIT;
SELECT '✅ Estoque atualizado e auditado com sucesso.' AS Resultado;


-- CENÁRIO 3: PROMOÇÃO-RELÂMPAGO
-- Descrição: Aplica desconto de 20% em produtos da categoria ID 1 (roupas), mas reverte logo depois.

START TRANSACTION;

-- Aplicar desconto temporário
UPDATE produtos 
SET preco = preco * 0.8 
WHERE categoria_id = 1;

-- Verificar os preços alterados
SELECT id, nome, preco FROM produtos WHERE categoria_id = 1;

-- Reverter a promoção (teste)
ROLLBACK;

SELECT '✅ Desconto temporário revertido com sucesso (nenhuma alteração foi salva).' AS Resultado;
