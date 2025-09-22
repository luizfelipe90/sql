-- Indices para otimizar buscas e junções
CREATE INDEX idx_enderecos_cliente_id ON enderecos (cliente_id);
CREATE INDEX idx_produtos_categoria_id ON produtos (categoria_id);
CREATE INDEX idx_pedidos_cliente_id ON pedidos (cliente_id);
CREATE INDEX idx_itens_pedido_pedido_id ON itens_pedido (pedido_id);
CREATE INDEX idx_itens_pedido_produto_id ON itens_pedido (produto_id); 

-- Chaves Estrangeiras para garantir a integridade referencial
ALTER TABLE enderecos
ADD CONSTRAINT fk_enderecos_cliente_id FOREIGN KEY (cliente_id) REFERENCES usuarios(id);
ALTER TABLE produtos
ADD CONSTRAINT fk_produtos_categoria_id FOREIGN KEY (categoria_id) REFERENCES categorias(id);
ALTER TABLE pedidosADD CONSTRAINT fk_pedidos_cliente_id FOREIGN KEY (cliente_id) REFERENCES usuarios
ALTER TABLE itens_pedido
ADD CONSTRAINT fk_itens_pedido_pedido_id FOREIGN KEY (pedido_id) REFERENCES pedidos (id);
ALTER TABLE itens_pedido
ADD CONSTRAINT fk_itens_pedido_produto_id FOREIGN KEY (produto_id) REFERENCES produtos (id);