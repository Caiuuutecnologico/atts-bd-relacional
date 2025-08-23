DROP TABLE IF EXISTS CategoriaUsuario;
DROP TABLE IF EXISTS Alerta;
DROP TABLE IF EXISTS Relato;
DROP TABLE IF EXISTS Evento;
DROP TABLE IF EXISTS Localizacao;
DROP TABLE IF EXISTS Estado;
DROP TABLE IF EXISTS Cidade;
DROP TABLE IF EXISTS Usuario;
DROP TABLE IF EXISTS TipoEvento;


CREATE TABLE IF NOT EXISTS TipoEvento (
idTipoEvento SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
descricao VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Cidade (
	sigla_cidade CHAR(4) PRIMARY KEY,
	nome_cidade VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Estado (
	sigla_estado CHAR(2) PRIMARY KEY,
	nome_estado VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Localizacao (
	idLocalizacao SERIAL PRIMARY KEY,
	latitude INT NOT NULL,
	longitude INT NOT NULL,
	sigla_cidade CHAR(4) REFERENCES Cidade (sigla_cidade),
	sigla_estado CHAR(2) REFERENCES Estado (sigla_estado)
);

CREATE TABLE IF NOT EXISTS Usuario (
idUsuario SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
email VARCHAR(255) UNIQUE NOT NULL,
senhaHash VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Evento (
idEvento SERIAL PRIMARY KEY,
titulo VARCHAR(100) NOT NULL,
descricao VARCHAR(255),
dataHora DATE NOT NULL,
status VARCHAR(20),
idTipoEvento INT REFERENCES TipoEvento (idTipoEvento),
idLocalizacao INT REFERENCES Localizacao (idLocalizacao)
);

CREATE TABLE IF NOT EXISTS Relato (
idRelato SERIAL PRIMARY KEY,
texto VARCHAR(500) NOT NULL,
dataHora DATE NOT NULL,
idEvento INT REFERENCES Evento (idEvento),
idUsuario INT REFERENCES Usuario (idUsuario)
);


CREATE TABLE IF NOT EXISTS Alerta (
idAlerta SERIAL PRIMARY KEY,
mensagem VARCHAR(255),
dataHora DATE NOT NULL,
nivel INT NOT NULL,
idEvento INT REFERENCES Evento (idEvento)
);

--Tabela auxiliar
CREATE TABLE IF NOT EXISTS CategoriaUsuario (
	id_categoria SERIAL PRIMARY KEY,
	idusuario INTEGER REFERENCES Usuario (idUsuario),
	categoria VARCHAR(100) NOT NULL
);

--Inserts
INSERT INTO TipoEvento (nome, descricao) VALUES
('Incêndio', 'Ocorrência de incêndio em área urbana ou florestal'),
('Alagamento', 'Enchente causada por chuvas fortes'),
('Acidente de Trânsito', 'Colisão entre veículos em via pública');

INSERT INTO Estado (sigla_estado, nome_estado) VALUES
('SP', 'São Paulo'),
('RJ', 'Rio de Janeiro'),
('MG', 'Minas Gerais');

INSERT INTO Cidade (sigla_cidade, nome_cidade) VALUES
('SPO', 'São Paulo'),
('RJO', 'Rio de Janeiro'),
('BHZ', 'Belo Horizonte');

INSERT INTO Localizacao (latitude, longitude, sigla_cidade, sigla_estado) VALUES
(-2355, -4650, 'SPO', 'SP'),   -- São Paulo
(-2245, -4330, 'RJO', 'RJ'),   -- Rio de Janeiro
(-1955, -4356, 'BHZ', 'MG');   -- Belo Horizonte

INSERT INTO Usuario (nome, email, senhaHash) VALUES
('João Silva', 'joao.silva@example.com', 'hashsenha123'),
('Maria Oliveira', 'maria.oliveira@example.com', 'hashsenha456'),
('Carlos Souza', 'carlos.souza@example.com', 'hashsenha789');

INSERT INTO Evento (titulo, descricao, dataHora, status, idTipoEvento, idLocalizacao) VALUES
('Incêndio no centro', 'Fogo em prédio comercial', '2025-08-20', 'Ativo', 1, 1),
('Enchente na zona norte', 'Alagamento em vias principais', '2025-08-21', 'Resolvido', 2, 2),
('Acidente grave', 'Colisão múltipla na rodovia', '2025-08-22', 'Em andamento', 3, 3);

INSERT INTO Relato (texto, dataHora, idEvento, idUsuario) VALUES
('Vi muita fumaça subindo do prédio na Av. Paulista.', '2025-08-20', 1, 1),
('Água chegou até a altura da cintura em várias ruas.', '2025-08-21', 2, 2),
('Trânsito totalmente parado, vários carros batidos.', '2025-08-22', 3, 3);

INSERT INTO Alerta (mensagem, dataHora, nivel, idEvento) VALUES
('Evitem a região central devido ao incêndio', '2025-08-20', 5, 1),
('Zona norte alagada, evitem sair de casa', '2025-08-21', 4, 2),
('Rodovia interditada devido ao acidente', '2025-08-22', 3, 3);

INSERT INTO CategoriaUsuario (idusuario, categoria) VALUES
(1, 'Morador'),
(2, 'Defesa Civil'),
(3, 'Motorista');


SELECT * FROM tipoEvento;
SELECT * FROM Estado;
SELECT * FROM Cidade;
SELECT * FROM Localizacao;
SELECT * FROM Usuario;
SELECT * FROM Evento;
SELECT * FROM Relato;
SELECT * FROM Alerta;
SELECT * FROM CategoriaUsuario;

SELECT * FROM Cidade
WHERE sigla_cidade = 'SPO';

SELECT * FROM Usuario
WHERE idUsuario > 1
ORDER BY idUsuario DESC;
