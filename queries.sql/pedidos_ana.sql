--Encontrar todos os pedidos de um cliente específico (ex: “Ana Silva”)

SELECT COUNT(t1.id_pedido) as numero_pedidos,
        t2.nome
FROM pedidos as t1
LEFT JOIN clientes as t2
ON t1.id_cliente = t2.id_cliente
WHERE t2.nome LIKE '%Ana%'
GROUP BY t2.nome