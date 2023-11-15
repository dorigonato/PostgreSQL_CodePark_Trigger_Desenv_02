CREATE TABLE Produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    preco DECIMAL(10, 2),
    quantidade_estoque INT
);

CREATE TABLE Registro_Log (
    id SERIAL PRIMARY KEY,
    evento VARCHAR(50),
    descricao TEXT,
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION registrar_insercao_produto()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO Registro_Log (evento, descricao)
    VALUES ('Inserção de Produto', 'Novo produto adicionado: ' || NEW.nome);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insercao_produto_trigger
AFTER INSERT ON Produtos
FOR EACH ROW
EXECUTE FUNCTION registrar_insercao_produto();


insert into Produtos (nome, preco, quantidade_estoque) values ('Prod A', 234.56, 432),
('Prod B', 1234.56, 42),
('Prod C', 22254.60, 432);
insert into Produtos (nome, preco, quantidade_estoque) values ('Prod d', 26734.56, 4);

SELECT * FROM Registro_Log;