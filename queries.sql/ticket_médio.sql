WITH total_por_pedido AS (
    SELECT 
        id_pedido,
        SUM(quantidade * preco_unitario) AS total_pedido
    FROM itens_pedido
    GROUP BY id_pedido
)
SELECT 
    ROUND(AVG(total_pedido), 2) AS ticket_medio
FROM total_por_pedido;


-- ticket medio cliente
WITH total_por_pedido AS (
    SELECT id_pedido,
           id_cliente,
           SUM(quantidade * preco_unitario) AS total_pedido
    FROM itens_pedido
    JOIN pedidos USING (id_pedido)
    GROUP BY id_pedido, id_cliente
)
SELECT id_cliente,
       ROUND(AVG(total_pedido), 2) AS ticket_medio_cliente
FROM total_por_pedido
GROUP BY id_cliente
ORDER BY ticket_medio_cliente DESC;
