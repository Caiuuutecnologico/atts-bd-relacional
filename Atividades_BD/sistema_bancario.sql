--criando as tabelas
CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    dataCadastro DATE NOT NULL
);

CREATE TABLE Conta (
    idConta INT PRIMARY KEY,
    idCliente INT NOT NULL,
    saldo DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Transacao (
    idTransacao INT PRIMARY KEY,
    idConta INT NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    valor DECIMAL(12,2) NOT NULL,
    data DATE NOT NULL,
    FOREIGN KEY (idConta) REFERENCES Conta(idConta)
);

--inserts
INSERT INTO Cliente (idCliente, nome, cpf, dataCadastro)
VALUES 
(1, 'Ana Souza', '111.111.111-11', '2024-01-10'),
(2, 'Bruno Lima', '222.222.222-22', '2024-02-15'),
(3, 'Carlos Silva', '333.333.333-33', '2024-03-05');

INSERT INTO Conta (idConta, idCliente, saldo)
VALUES
(101, 1, 2500.00),
(102, 2, 1800.00),
(103, 3, 500.00);

INSERT INTO Transacao (idTransacao, idConta, tipo, valor, data)
VALUES
(1001, 101, 'SAQUE', 200.00, '2024-03-01'),
(1002, 102, 'SAQUE', 150.00, '2024-03-02'),
(1003, 103, 'DEPOSITO', 300.00, '2024-03-03');

--selects
SELECT COUNT(*) AS total_clientes
FROM Cliente;

SELECT SUM(saldo) AS saldo_total
FROM Conta;

SELECT AVG(valor) AS media_saques
FROM Transacao
WHERE tipo = 'SAQUE';
