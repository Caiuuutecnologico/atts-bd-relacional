INSERT INTO loja (nome, cidade) VALUES 
('Game Center SP', 'São Paulo'),
('Games World RJ', 'Rio de Janeiro'),
('Manaus Games', 'Manaus');

INSERT INTO cliente (nome, email, cidade) VALUES 
('Lucas Pereira', 'lucas.pereira@email.com', 'São Paulo'),
('Mariana Souza', 'mariana.souza@email.com', 'Rio de Janeiro'),
('Carlos Silva', 'carlos.silva@email.com', 'Manaus');

INSERT INTO jogo (titulo, ano_lancamento, genero) VALUES 
('The Last of Us', 2013, 'Ação/Aventura'),
('God of War', 2018, 'Ação'),
('FIFA 22', 2021, 'Esporte');

INSERT INTO compra (data_compra, id_cliente, id_loja) VALUES 
('2025-09-01', 1, 1);

INSERT INTO compra (data_compra, id_cliente, id_loja) VALUES 
('2025-09-03', 2, 2);

INSERT INTO compra_jogo (id_compra, id_jogo, quantidade) VALUES 
(1, 1, 1),
(1, 3, 2);

INSERT INTO compra_jogo (id_compra, id_jogo, quantidade) VALUES 
(2, 2, 1),
(2, 3, 1);