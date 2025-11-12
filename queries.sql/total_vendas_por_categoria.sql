-- Somar o total de vendas (SUM) por categoria

SELECT  t4.nome as categoria,
        SUM(t2.quantidade * t2.preco_unitario) AS total_vendas
FROM pedidos as t1
JOIN itens_pedido as t2
ON t1.id_pedido = t2.id_pedido
JOIN produtos as t3
ON t2.id_produto = t3.id_produto
JOIN categorias as t4
ON t3.id_categoria = t4.id_categoria
WHERE t4.nome IS NOT NULL
GROUP BY categoria
ORDER BY total_vendas DESC
