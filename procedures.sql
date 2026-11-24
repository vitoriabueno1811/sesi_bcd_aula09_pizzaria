
USE Pizzaria;

DELIMITER $$

DROP PROCEDURE IF EXISTS pedidoDeUmItem $$

CREATE PROCEDURE pedidoDeUmItem(
    IN cli_id INT, 
    IN piz_id INT, 
    IN qtd INT
)
BEGIN
    DECLARE v_preco DECIMAL(8, 2);
    DECLARE v_total DECIMAL(8, 2);
    DECLARE v_pedido_id INT;

    SELECT valor INTO v_preco 
    FROM Pizzas 
    WHERE pizza_id = piz_id;

    SET v_total = v_preco * qtd;

    INSERT INTO Pedidos (cliente_id, data, hora, valor) 
    VALUES (cli_id, CURDATE(), CURTIME(), v_total);

    SET v_pedido_id = LAST_INSERT_ID();

    INSERT INTO Itens_Pedido (pedido_id, pizza_id, quantidade, valor) 
    VALUES (v_pedido_id, piz_id, qtd, v_total);
END $$

DELIMITER ;

CALL pedidoDeUmItem(
    (SELECT Cliente_id FROM Clientes WHERE logradouro LIKE '%Thamires de Campos Luz%' LIMIT 1),
    (SELECT pizza_id FROM Pizzas WHERE nome = 'Vienense' LIMIT 1),
    1
);

CALL pedidoDeUmItem(
    (SELECT Cliente_id FROM Clientes WHERE logradouro LIKE '%Everton Jose de Souza%' LIMIT 1),
    (SELECT pizza_id FROM Pizzas WHERE nome = 'Toscana' LIMIT 1),
    2
);

CALL pedidoDeUmItem(
    (SELECT Cliente_id FROM Clientes WHERE logradouro LIKE '%Silvia Roberta de Jesus Garcia%' LIMIT 1),
    (SELECT pizza_id FROM Pizzas WHERE nome = 'Canadense' LIMIT 1),
    1
);

CALL pedidoDeUmItem(
    (SELECT Cliente_id FROM Clientes WHERE logradouro LIKE '%Silvia Roberta de Jesus Garcia%' LIMIT 1),
    (SELECT pizza_id FROM Pizzas WHERE nome LIKE 'Cubana%' LIMIT 1),
    2
);

SELECT 
    p.pedido_id, c.nome AS cliente_cadastrado, c.logradouro AS endereco_referencia,  pz.nome AS pizza, ip.quantidade, pz.valor AS valor_unitario, p.valor AS total_pedido, p.data, p.hora FROM Pedidos p JOIN Clientes c ON p.cliente_id = c.Cliente_id JOIN Itens_Pedido ip ON p.pedido_id = ip.pedido_id JOIN Pizzas pz ON ip.pizza_id = pz.pizza_id;
