🧭 Projeto: Banco de Dados de E-commerce — Consultas SQL
📘 Introdução

Este projeto tem como objetivo demonstrar habilidades práticas em SQL (Structured Query Language) aplicadas a um cenário de e-commerce.

O banco de dados foi criado e populado com dados fictícios utilizando SQLite, Python e a biblioteca Faker, simulando uma operação real de loja virtual.

O dataset contém as seguintes tabelas principais:

clientes → informações cadastrais dos clientes (nome, email, cidade, estado)

categorias → categorias de produtos

produtos → dados dos produtos vendidos, com vínculo às categorias

pedidos → informações dos pedidos realizados (cliente, data, total)

itens_pedido → itens pertencentes a cada pedido (produto, quantidade, preço unitário)

O objetivo foi aplicar consultas SQL progressivamente mais complexas, cobrindo desde seleções simples até análises agregadas e relacionamentos entre múltiplas tabelas.

💡 Sessão 1 – Consultas de fundamentos

Consultas básicas que utilizam SELECT, WHERE, ORDER BY e COUNT, fundamentais para a exploração inicial dos dados.

🧩 Mostrar clientes do estado de “SP”
SELECT nome, estado
FROM clientes
WHERE estado = 'SP';

🧩 Contar quantos clientes existem no banco
SELECT COUNT(id_cliente) AS total_clientes
FROM clientes;

🧩 Ordenar produtos por preço (do mais caro para o mais barato)
SELECT *
FROM produtos
ORDER BY preco DESC;

🧩 Listar todos os produtos e seus preços
SELECT id_produto, nome, preco
FROM produtos;

💡 Sessão 2 – Consultas intermediárias

Consultas que envolvem JOINs para cruzar informações entre tabelas e identificar relações entre clientes, pedidos, produtos e categorias.

🧩 Listar nomes dos clientes junto com as datas dos seus pedidos
SELECT t1.nome,
       t2.data_pedido
FROM clientes AS t1
LEFT JOIN pedidos AS t2
ON t1.id_cliente = t2.id_cliente
WHERE data_pedido IS NOT NULL;

🧩 Mostrar o nome do produto e o nome da categoria correspondente
SELECT t1.nome AS nome_produto,
       t2.nome AS categoria
FROM produtos AS t1
LEFT JOIN categorias AS t2
ON t1.id_categoria = t2.id_categoria;

🧩 Ver todos os itens de pedido (produto, quantidade e total do item)
SELECT t3.nome AS produto,
       t2.quantidade,
       t1.total
FROM pedidos AS t1
LEFT JOIN itens_pedido AS t2
ON t1.id_pedido = t2.id_pedido
LEFT JOIN produtos AS t3
ON t2.id_produto = t3.id_produto;

🧩 Encontrar todos os pedidos de um cliente específico (exemplo: “Ana Silva”)
SELECT COUNT(t1.id_pedido) AS numero_pedidos,
       t2.nome
FROM pedidos AS t1
LEFT JOIN clientes AS t2
ON t1.id_cliente = t2.id_cliente
WHERE t2.nome LIKE '%Ana%'
GROUP BY t2.nome;

💡 Sessão 3 – Consultas analíticas

Consultas com funções de agregação (SUM, AVG) e agrupamentos (GROUP BY), utilizadas para gerar indicadores de negócio.

🧩 Somar o total de vendas por categoria
SELECT t4.nome AS categoria,
       SUM(t2.quantidade * t2.preco_unitario) AS total_vendas
FROM pedidos AS t1
LEFT JOIN itens_pedido AS t2
ON t1.id_pedido = t2.id_pedido
LEFT JOIN produtos AS t3
ON t2.id_produto = t3.id_produto
LEFT JOIN categorias AS t4
ON t3.id_categoria = t4.id_categoria
WHERE t4.nome IS NOT NULL
GROUP BY categoria
ORDER BY total_vendas DESC;

🧩 Calcular o valor total gasto por cada cliente
SELECT t1.id_cliente, 
       t1.nome,
       SUM(t3.quantidade * t3.preco_unitario) AS total_gasto
FROM clientes AS t1
JOIN pedidos AS t2
ON t1.id_cliente = t2.id_cliente
JOIN itens_pedido AS t3
ON t2.id_pedido = t3.id_pedido
GROUP BY t1.id_cliente, t1.nome
ORDER BY total_gasto DESC;

🧩 Encontrar o produto mais vendido (em quantidade)
SELECT t2.id_produto,
       t2.nome AS nome_produto,
       SUM(t1.quantidade) AS total_vendido
FROM itens_pedido AS t1
JOIN produtos AS t2
ON t1.id_produto = t2.id_produto
GROUP BY t2.id_produto, t2.nome
ORDER BY total_vendido DESC
LIMIT 1;

🧩 Calcular o ticket médio dos pedidos
SELECT 
    AVG(total_por_pedido) AS ticket_medio
FROM (
    SELECT 
        t1.id_pedido,
        SUM(t2.quantidade * t2.preco_unitario) AS total_por_pedido
    FROM pedidos AS t1
    JOIN itens_pedido AS t2
    ON t1.id_pedido = t2.id_pedido
    GROUP BY t1.id_pedido
);

🧩 Faturamento mensal (com strftime() no SQLite)
SELECT 
    strftime('%Y-%m', t1.data_pedido) AS mes_ano,
    SUM(t2.quantidade * t2.preco_unitario) AS total_vendas
FROM pedidos AS t1
JOIN itens_pedido AS t2
ON t1.id_pedido = t2.id_pedido
GROUP BY mes_ano
ORDER BY mes_ano;

🧾 Considerações finais

Este projeto demonstrou o uso de SQL em um contexto realista de e-commerce, abrangendo:

Criação e relacionamento de tabelas com chaves primárias e estrangeiras;

Consultas simples e intermediárias com JOIN;

Agregações com GROUP BY, SUM, AVG;

Uso de funções nativas do SQLite, como strftime();

Organização e clareza nas consultas, com boas práticas de legibilidade e alias (AS).

📂 Ferramentas utilizadas:

Banco de dados: SQLite

IDE: Visual Studio Code (extensão SQLite)

Geração de dados: Python + Faker
