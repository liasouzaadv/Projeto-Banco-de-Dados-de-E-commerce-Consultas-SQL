-- Mostrar o nome do produto e o nome da categoria correspondente

SELECT t1.nome as nome_produto,
        t2.nome as categoria
from produtos as t1
LEFT JOIN categorias as t2
ON t1.id_categoria = t2.id_categoria
ORDER BY t2.nome, t1.nome