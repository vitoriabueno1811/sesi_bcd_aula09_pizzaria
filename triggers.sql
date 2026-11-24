
USE Pizzaria;

DELIMITER $$

DROP TRIGGER IF EXISTS tr_atualiza_valor_pedido $$

CREATE TRIGGER tr_atualiza_valor_pedido
AFTER INSERT ON Itens_Pedido
FOR EACH ROW
BEGIN
    UPDATE Pedidos 
    SET valor = (
        SELECT SUM(valor) 
        FROM Itens_Pedido 
        WHERE pedido_id = NEW.pedido_id
    )
    WHERE pedido_id = NEW.pedido_id;
END $$

DELIMITER ;

INSERT INTO Pedidos (cliente_id, data, hora, valor) 
VALUES ((SELECT Cliente_id FROM Clientes WHERE nome = 'Claudiane Mendes Trigueiro Silva'), CURDATE(), CURTIME(), 0);

SET @id_pedido1 = LAST_INSERT_ID();

INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor) VALUES 
(@id_pedido1, (SELECT pizza_id FROM Pizzas WHERE nome = 'Aliche'), 2, (SELECT valor * 2 FROM Pizzas WHERE nome = 'Aliche')),
(@id_pedido1, (SELECT pizza_id FROM Pizzas WHERE nome = 'Firense'), 1, (SELECT valor * 1 FROM Pizzas WHERE nome = 'Firense'));


INSERT INTO Pedidos (cliente_id, data, hora, valor) 
VALUES ((SELECT Cliente_id FROM Clientes WHERE nome = 'Diogo Matos da Silva'), CURDATE(), CURTIME(), 0);

SET @id_pedido2 = LAST_INSERT_ID();

INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor) VALUES 
(@id_pedido2, (SELECT pizza_id FROM Pizzas WHERE nome = 'Toscana'), 2, (SELECT valor * 2 FROM Pizzas WHERE nome = 'Toscana')),
(@id_pedido2, (SELECT pizza_id FROM Pizzas WHERE nome = 'Grega'), 1, (SELECT valor * 1 FROM Pizzas WHERE nome = 'Grega'));

INSERT INTO Pedidos (cliente_id, data, hora, valor) 
VALUES ((SELECT Cliente_id FROM Clientes WHERE nome = 'Eder Almeida Batista de Oliveira'), CURDATE(), CURTIME(), 0);

SET @id_pedido3 = LAST_INSERT_ID();

INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor) VALUES 
(@id_pedido3, (SELECT pizza_id FROM Pizzas WHERE nome = 'Canadense'), 1, (SELECT valor * 1 FROM Pizzas WHERE nome = 'Canadense')),
(@id_pedido3, (SELECT pizza_id FROM Pizzas WHERE nome = 'Margherita'), 2, (SELECT valor * 2 FROM Pizzas WHERE nome = 'Margherita'));

SELECT 
    p.pedido_id,
    c.nome AS cliente,
    GROUP_CONCAT(CONCAT(ip.quantidade, 'x ', pz.nome) SEPARATOR ' + ') AS itens_do_pedido,
    p.valor AS valor_calculado_pela_trigger
FROM Pedidos p
JOIN Clientes c ON p.cliente_id = c.Cliente_id
JOIN Itens_Pedido ip ON p.pedido_id = ip.pedido_id
JOIN Pizzas pz ON ip.pizza_id = pz.pizza_id
WHERE p.pedido_id IN (@id_pedido1, @id_pedido2, @id_pedido3)
GROUP BY p.pedido_id;
