# Banco de Dados - Pizzaria 

--- 

## Desafio 1

 - Foi criado um relatório que mostra todos os pedidos, itens, nome dos clientes e das pizzas.
 - Foi Acrescentado uma coluna de subtotal 
 - Foi agrupado os pedidos e o cálculo total junto com a contação de pizzas cada pedido possui

---

## Desafio 2 

 - Foi acrescentada a Pizza 'Moda do Chef' no Cardápio

 ---

 ## Desafio 3 

 - Foi criado a implementação de alterações de pizzas
---

## Códigos 

 - queries.sql 

   ```slq
USE pizzaria_db;

-- A) 
SELECT COUNT(*) AS total_tabelas FROM information_schema.tables WHERE table_schema = 'pizzaria_db';

-- B)
SELECT COUNT(*) AS total_clientes FROM clientes;

-- C)
SELECT COUNT(*) AS total_pizzas FROM pizzas;

-- D)
SELECT SUM(quantidade) AS total_pizzas FROM itens_pedido WHERE pedido_id = 3;

-- E)
SELECT c.nome FROM clientes c INNER JOIN pedidos p ON c.cliente_id = p.cliente_id WHERE p.pedido_id = 3;

-- F) 
SELECT * FROM itens_pedido WHERE pedido_id = 3;
SELECT pi.nome FROM itens_pedido i JOIN pizzas p ON i.pizza_id = p.pizza_id WHERE pedido_id = 3;

-- G)
INSERT INTO clientes (nome, logradouro, numero, bairro, referencia) VALUES ('Gaspar Oliveira', 'Rua Lizandro Silva', 21, 'São Dimas', 'Ao lado da igrejinha');

-- H)
INSERT INTO pizzas(nome, descricao, preco) VALUES ('A moda do chef', 'Molho de tomate, palmito macio em rodelas, coberto com catupiry, frango desfiado, ovos, carne seca, oregano e azeitonas', 41.90);
INSERT INTO pedidos (cliente_id) SELECT cliente_id FROM clientes WHERE nome = 'Gaspar Oliveira' ORDER BY cliente_id DESC LIMIT 1;

INSERT INTO itens_pedido (pedido_id, pizza_id, quantidade, preco_unitario) 
SELECT p.pedido_id, pi.pizza_id, 1, pi.preco FROM pedidos p JOIN clientes c ON p.cliente_id = c.cliente_id JOIN pizzas pi ON pi.nome = 'Margherita' WHERE c.nome = 'Gaspar Oliveira' ORDER BY p.pedido_id DESC LIMIT 1;

INSERT INTO itens_pedido (pedido_id, pizza_id, quantidade, preco_unitario) 
SELECT p.pedido_id, pi.pizza_id, 2, pi.preco FROM pedidos p JOIN clientes c ON p.cliente_id = c.cliente_id JOIN pizzas pi ON pi.nome = 'Napolitana' WHERE c.nome = 'Gaspar Oliveira' ORDER BY p.pedido_id DESC LIMIT 1;

INSERT INTO pedidos (cliente_id)
SELECT cliente_id FROM clientes WHERE nome = 'Gaspar Oliveira' ORDER BY cliente_id DESC LIMIT 1;

INSERT INTO itens_pedido (pedido_id, pizza_id, quantidade, preco_unitario)
SELECT p.pedido_id, pi.pizza_id, 2, pi.preco FROM pedidos p JOIN clientes c ON p.cliente_id = c.cliente_id JOIN pizzas pi ON pi.nome = 'A moda do chef' WHERE c.nome = 'Gaspar Oliveira' ORDER BY p.pedido_id DESC LIMIT 1;


UPDATE itens_pedido SET quantidade = 3 WHERE pedido_id = 
( SELECT pedido_id FROM ( SELECT p.pedido_id FROM pedidos p JOIN clientes c ON p.cliente_id = c.cliente_id ORDER BY p.pedido_id DESC LIMIT 1 ) AS ultimo_pedido ) AND pizza_id = ( SELECT pizza_id FROM pizzas WHERE nome = 'A moda do chef');

INSERT INTO itens_pedido (pedido_id, pizza_id, quantidade, preco_unitario)
SELECT p.pedido_id, pi.pizza_id, 1, pi.preco FROM pedidos p JOIN clientes c ON p.cliente_id = c.cliente_id JOIN pizzas pi ON pi.nome = 'Margherita' WHERE c.nome = 'Gaspar Oliveira' ORDER BY p.pedido_id DESC LIMIT 1;
   ``` 
   ---
