import sqlite3
import random
from faker import Faker
from datetime import datetime, timedelta

# --------------------------
# CONFIGURAÇÃO INICIAL
# --------------------------

# Nome do arquivo do banco de dados
DB_NAME = "ecommerce.db"

# Inicializa o gerador de dados Faker
faker = Faker('pt_BR')
Faker.seed(42)
random.seed(42)

# --------------------------
# CONEXÃO COM O BANCO
# --------------------------

conn = sqlite3.connect(DB_NAME)
cursor = conn.cursor()

# --------------------------
# GERAÇÃO DE DADOS
# --------------------------

# Categorias pré-definidas
categorias = [
    "Eletrônicos", "Livros", "Roupas", "Acessórios", "Casa e Cozinha"
]

# Inserindo categorias
cursor.executemany("INSERT INTO categorias (nome) VALUES (?)", [(c,) for c in categorias])

# Gerando produtos
produtos = []
for _ in range(100):  # 100 produtos
    nome_produto = faker.word().capitalize() + " " + faker.word().capitalize()
    preco = round(random.uniform(20, 1500), 2)
    id_categoria = random.randint(1, len(categorias))
    produtos.append((nome_produto, preco, id_categoria))

cursor.executemany(
    "INSERT INTO produtos (nome, preco, id_categoria) VALUES (?, ?, ?)",
    produtos
)

# Gerando clientes
clientes = []
for _ in range(200):  # 200 clientes
    nome = faker.name()
    email = faker.unique.email()
    telefone = faker.phone_number()
    endereco = faker.street_address()
    cidade = faker.city()
    estado = faker.estado_sigla()
    data_cadastro = faker.date_between(start_date="-3y", end_date="today")
    clientes.append((nome, email, telefone, endereco, cidade, estado, data_cadastro))

cursor.executemany(
    """INSERT INTO clientes (nome, email, telefone, endereco, cidade, estado, data_cadastro)
       VALUES (?, ?, ?, ?, ?, ?, ?)""",
    clientes
)

# Gerando pedidos e itens
pedidos = []
itens_pedido = []

for id_cliente in range(1, 201):  # cada cliente pode ter 1 a 10 pedidos
    for _ in range(random.randint(1, 10)):
        data_pedido = faker.date_between(start_date="-2y", end_date="today")
        total = 0
        cursor.execute(
            "INSERT INTO pedidos (id_cliente, data_pedido, total) VALUES (?, ?, ?)",
            (id_cliente, data_pedido, total)
        )
        id_pedido = cursor.lastrowid

        # Cada pedido tem de 1 a 5 itens
        for _ in range(random.randint(1, 5)):
            id_produto = random.randint(1, 100)
            quantidade = random.randint(1, 5)
            preco_unitario = produtos[id_produto - 1][1]
            subtotal = quantidade * preco_unitario
            total += subtotal
            itens_pedido.append((id_pedido, id_produto, quantidade, preco_unitario))

        # Atualiza o total do pedido
        cursor.execute(
            "UPDATE pedidos SET total = ? WHERE id_pedido = ?",
            (round(total, 2), id_pedido)
        )

# Inserindo os itens de pedido
cursor.executemany(
    """INSERT INTO itens_pedido (id_pedido, id_produto, quantidade, preco_unitario)
       VALUES (?, ?, ?, ?)""",
    itens_pedido
)

# --------------------------
# FINALIZAÇÃO
# --------------------------

conn.commit()
conn.close()

print("🎉 Banco de dados populado com sucesso!")
