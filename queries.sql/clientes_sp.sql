-- Mostrar apenas os clientes do estado de “SP”]

SELECT COUNT(*) as total_clientes_sp
FROM clientes
WHERE estado = 'SP'