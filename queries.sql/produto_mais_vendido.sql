-- produto mais vendido
SELECT t2.id_produto,
        t2.nome as nome_produto,
        SUM(t1.quantidade) AS total_vendido
    
FROM itens_pedido as t1
JOIN produtos as t2
On t1.id_produto = t2.id_produto
GROUP BY t2.id_produto, t2.nome
ORDER BY total_vendido DESC
LIMIT 1;

-- top 5 produtos mais vendidos
SELECT t2.id_produto,
        t2.nome as nome_produto,
        SUM(t1.quantidade) AS total_vendido
    
FROM itens_pedido as t1
JOIN produtos as t2
On t1.id_produto = t2.id_produto
GROUP BY t2.id_produto, t2.nome
ORDER BY total_vendido DESC
LIMIT 5;
