-- Listar os nomes dos clientes junto com as datas dos seus pedidos

SELECT t1.nome,
        t2.data_pedido
FROM clientes as t1
INNER JOIN pedidos as t2
ON t1.id_cliente = t2.id_cliente