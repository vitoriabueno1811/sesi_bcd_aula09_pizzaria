# Banco de Dados - Pizzaria 

--- 

## Desafio 1

# queries.sql

Este contém os scripts consultas do banco de dados da pizzaria. focado na Realização contagem e verificação das tabelas, executa consultas (INNER JOIN), calcula o total de itens vendidos, filtra informações de pedidos e gerencia o andamento de novos clientes e pizzas.

 - Foi criado um relatório que mostra todos os pedidos, itens, nome dos clientes e das pizzas.
 - Foi Acrescentado uma coluna de subtotal 
 - Foi agrupado os pedidos e o cálculo total junto com a contação de pizzas cada pedido possui

---

## Desafio 2 

# views.sql

É responsável pela criação de tabelas (VIEWs), verificando consultas complexas para facilitar a geração de relatórios e simplifica linhas de código, como relatório de pedidos com os nomes dos clientes, a soma total de itens das pizzas pedidas com seus valores, permitindo que sejam acessados com um comando de SELECT.


 - Foi acrescentada a Pizza 'Moda do Chef' no Cardápio

 ---

 ## Desafio 3 

 - Foi criado a implementação de alterações de pizzas
---

## Códigos 

### views.sql
```sql
-- Relatório que mostra todos os pedidos
SELECT * FROM pedidos;
SELECT p.*, c.nome  FROM pedidos p INNER JOIN clientes c
ON p.cliente_id = c.cliente_id;

CREATE VIEW vw_total_itens_pedido AS
SELECT pedido_id, SUM(quantidade) AS total_pizzas 
FROM itens_pedido 
GROUP BY pedido_id;

-- Salvar a consulta como uma VIEW
CREATE VIEW vw_pedidos1 AS
SELECT p.*, c.nome  FROM pedidos p INNER JOIN clientes c
ON p.cliente_id = c.cliente_id;

CREATE VIEW vw_clientes_pedidos AS
SELECT p.pedido_id, c.nome AS nome_cliente 
FROM clientes c 
INNER JOIN pedidos p ON c.cliente_id = p.cliente_id;

-- Para ver o resultado
SELECT * FROM vw_pedidos1;

CREATE VIEW vw_detalhes_itens AS
SELECT i.pedido_id, p.nome AS nome_pizza, i.quantidade, i.valor AS preco_pago
FROM itens_pedido i 
JOIN pizzas p ON i.pizza_id = p.pizza_id;

```

### queries.sql
```sql
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
INSERT INTO pizzas(nome, descricao, valor) VALUES ('A moda do chef', 'Molho de tomate, palmito macio em rodelas, coberto com catupiry, frango desfiado, ovos, carne seca, oregano e azeitonas', 41.90);

INSERT INTO pedidos (cliente_id) 
SELECT cliente_id FROM clientes WHERE nome = 'Gaspar Oliveira' ORDER BY cliente_id DESC LIMIT 1;

INSERT INTO itens_pedido (pedido_id, pizza_id, quantidade, valor) 
SELECT p.pedido_id, pi.pizza_id, 1, pi.valor FROM pedidos p JOIN clientes c ON p.cliente_id = c.cliente_id JOIN pizzas pi ON pi.nome = 'Margherita' WHERE c.nome = 'Gaspar Oliveira' ORDER BY p.pedido_id DESC LIMIT 1;

INSERT INTO itens_pedido (pedido_id, pizza_id, quantidade, valor) 
SELECT p.pedido_id, pi.pizza_id, 2, pi.valor FROM pedidos p JOIN clientes c ON p.cliente_id = c.cliente_id JOIN pizzas pi ON pi.nome = 'Napolitana' WHERE c.nome = 'Gaspar Oliveira' ORDER BY p.pedido_id DESC LIMIT 1;

INSERT INTO pedidos (cliente_id)
SELECT cliente_id FROM clientes WHERE nome = 'Gaspar Oliveira' ORDER BY cliente_id DESC LIMIT 1;

INSERT INTO itens_pedido (pedido_id, pizza_id, quantidade, valor)
SELECT p.pedido_id, pi.pizza_id, 2, pi.valor FROM pedidos p JOIN clientes c ON p.cliente_id = c.cliente_id JOIN pizzas pi ON pi.nome = 'A moda do chef' WHERE c.nome = 'Gaspar Oliveira' ORDER BY p.pedido_id DESC LIMIT 1;

UPDATE itens_pedido SET quantidade = 3 WHERE pedido_id = 
( SELECT pedido_id FROM ( SELECT p.pedido_id FROM pedidos p JOIN clientes c ON p.cliente_id = c.cliente_id ORDER BY p.pedido_id DESC LIMIT 1 ) AS ultimo_pedido ) AND pizza_id = ( SELECT pizza_id FROM pizzas WHERE nome = 'A moda do chef' LIMIT 1);

INSERT INTO itens_pedido (pedido_id, pizza_id, quantidade, valor)
SELECT p.pedido_id, pi.pizza_id, 1, pi.valor FROM pedidos p JOIN clientes c ON p.cliente_id = c.cliente_id JOIN pizzas pi ON pi.nome = 'Margherita' WHERE c.nome = 'Gaspar Oliveira' ORDER BY p.pedido_id DESC LIMIT 1;

```