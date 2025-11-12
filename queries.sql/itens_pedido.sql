-- Ver todos os itens de pedido (produto, quantidade e total do item)

SELECT t1.id_pedido,
        t3.nome as produto,
        t2.quantidade,
        t2.quantidade * t2.preco_unitario AS total_item
from pedidos as t1
LEFT JOIN itens_pedido as t2
ON t1.id_pedido = t2.id_pedido
LEFT JOIN produtos as t3
ON t2.id_produto = t3.id_produto
