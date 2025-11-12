-- Calcular o valor total gasto por cada cliente

SELECT  t1.id_cliente,
        t1.nome,
        SUM(t3.quantidade * t3.preco_unitario) AS total_gasto
FROM clientes as t1
JOIN pedidos as t2
ON t1.id_cliente = t2.id_cliente
JOIN itens_pedido as t3
ON t2.id_pedido = t3.id_pedido
GROUP BY t1.id_cliente, t1.nome
ORDER BY t1.nome 