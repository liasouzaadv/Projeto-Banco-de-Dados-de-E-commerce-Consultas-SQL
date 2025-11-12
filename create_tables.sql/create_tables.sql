-- Criação do banco de dados de e-commerce
-- Estrutura usada para simular um ambiente real de vendas online

-- Tabela de clientes
CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    telefone TEXT,
    endereco TEXT,
    cidade TEXT,
    estado TEXT,
    data_cadastro DATE
);

-- Tabela de categorias
CREATE TABLE categorias (
    id_categoria INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL
);

-- Tabela de produtos
CREATE TABLE produtos (
    id_produto INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    preco REAL NOT NULL,
    id_categoria INTEGER,
    FOREIGN KEY (id_categoria) REFERENCES categorias (id_categoria)
);

-- Tabela de pedidos
CREATE TABLE pedidos (
    id_pedido INTEGER PRIMARY KEY AUTOINCREMENT,
    id_cliente INTEGER,
    data_pedido DATE,
    total REAL,
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente)
);

-- Tabela de itens do pedido
CREATE TABLE itens_pedido (
    id_item INTEGER PRIMARY KEY AUTOINCREMENT,
    id_pedido INTEGER,
    id_produto INTEGER,
    quantidade INTEGER NOT NULL,
    preco_unitario REAL NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos (id_pedido),
    FOREIGN KEY (id_produto) REFERENCES produtos (id_produto)
);
