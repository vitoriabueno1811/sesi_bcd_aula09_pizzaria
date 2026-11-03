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
