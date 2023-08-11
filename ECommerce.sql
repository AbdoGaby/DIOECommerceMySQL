create database ECommerce;
use ECommerce;
CREATE TABLE Cliente (
    cliente_id INT PRIMARY KEY,
    nome VARCHAR(255),
    tipo_cliente VARCHAR(2)
);

CREATE TABLE Pagamento (
    pagamento_id INT PRIMARY KEY,
    cliente_id INT,
    forma_pagamento VARCHAR(50),
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);

CREATE TABLE Entrega (
    entrega_id INT PRIMARY KEY,
    pedido_id INT,
    status_entrega VARCHAR(50),
    codigo_rastreio VARCHAR(20),
    FOREIGN KEY (pedido_id) REFERENCES Pedido(pedido_id)
);

CREATE TABLE Pedido (
    pedido_id INT PRIMARY KEY,
    cliente_id INT,
    vendedor_id INT,
    data_pedido DATE,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id),
    FOREIGN KEY (vendedor_id) REFERENCES Vendedor(vendedor_id)
);

CREATE TABLE Produto (
    produto_id INT PRIMARY KEY,
    nome_produto VARCHAR(255)
);

CREATE TABLE Fornecedor (
    fornecedor_id INT PRIMARY KEY,
    nome_fornecedor VARCHAR(255)
);

CREATE TABLE Estoque (
    estoque_id INT PRIMARY KEY,
    produto_id INT,
    fornecedor_id INT,
    quantidade INT,
    FOREIGN KEY (produto_id) REFERENCES Produto(produto_id),
    FOREIGN KEY (fornecedor_id) REFERENCES Fornecedor(fornecedor_id)
);
-- Quantos pedidos foram feitos por cada cliente?
SELECT c.nome, COUNT(p.pedido_id) AS total_pedidos
FROM Cliente c
JOIN Pedido p ON c.cliente_id = p.cliente_id
GROUP BY c.nome;

-- Algum vendedor também é fornecedor?
SELECT DISTINCT v.nome_vendedor
FROM Vendedor v
JOIN Fornecedor f ON v.nome_vendedor = f.nome_fornecedor;

-- Relação de produtos fornecedores e estoques:
SELECT p.nome_produto, f.nome_fornecedor, e.quantidade
FROM Produto p
JOIN Estoque e ON p.produto_id = e.produto_id
JOIN Fornecedor f ON e.fornecedor_id = f.fornecedor_id;

-- Relação de nomes dos fornecedores e nomes dos produtos:
SELECT f.nome_fornecedor, p.nome_produto
FROM Fornecedor f
JOIN Estoque e ON f.fornecedor_id = e.fornecedor_id
JOIN Produto p ON e.produto_id = p.produto_id;

