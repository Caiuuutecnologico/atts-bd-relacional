DROP TABLE IF EXISTS serie_temporal CASCADE;
DROP TABLE IF EXISTS parametro CASCADE;
DROP TABLE IF EXISTS reservatorio CASCADE;

CREATE TABLE reservatorio (
    id_reservatorio SERIAL PRIMARY KEY,
    nome VARCHAR(200) NOT NULL
);

CREATE TABLE parametro (
    id_parametro SERIAL PRIMARY KEY,
    nome_parametro VARCHAR(150) NOT NULL
);


CREATE TABLE serie_temporal (
    id_serie SERIAL PRIMARY KEY,
    id_reservatorio INT NOT NULL REFERENCES reservatorio(id_reservatorio),
    id_parametro INT NOT NULL REFERENCES parametro(id_parametro),
    valor NUMERIC(12,4) NOT NULL,
    data_hora TIMESTAMP NOT NULL
);




INSERT INTO reservatorio (nome) VALUES
('Jaguari'),
('Paraibuna'),
('Cachoeira do França'),
('Santa Branca');

INSERT INTO parametro (nome_parametro) VALUES
('pH'),
('Oxigênio Dissolvido'),
('Temperatura');


INSERT INTO serie_temporal (id_reservatorio, id_parametro, valor, data_hora)
VALUES
(
  (SELECT id_reservatorio FROM reservatorio WHERE nome = 'Jaguari'),
  (SELECT id_parametro FROM parametro WHERE nome_parametro = 'Oxigênio Dissolvido'),
  6.80,
  '2025-01-10 09:00:00'
),
(
  (SELECT id_reservatorio FROM reservatorio WHERE nome = 'Jaguari'),
  (SELECT id_parametro FROM parametro WHERE nome_parametro = 'pH'),
  7.20,
  '2025-01-10 09:05:00'
);

INSERT INTO serie_temporal (id_reservatorio, id_parametro, valor, data_hora)
VALUES
(
  (SELECT id_reservatorio FROM reservatorio WHERE nome = 'Paraibuna'),
  (SELECT id_parametro FROM parametro WHERE nome_parametro = 'pH'),
  6.90,
  '2025-02-20 10:00:00'
);


INSERT INTO serie_temporal (id_reservatorio, id_parametro, valor, data_hora)
VALUES
(
  (SELECT id_reservatorio FROM reservatorio WHERE nome = 'Cachoeira do França'),
  (SELECT id_parametro FROM parametro WHERE nome_parametro = 'pH'),
  7.60,
  '2025-03-15 11:00:00'
);

INSERT INTO serie_temporal (id_reservatorio, id_parametro, valor, data_hora)
VALUES
(
  (SELECT id_reservatorio FROM reservatorio WHERE nome = 'Santa Branca'),
  (SELECT id_parametro FROM parametro WHERE nome_parametro = 'Oxigênio Dissolvido'),
  7.00,
  '2025-04-01 08:00:00'
);

SELECT * FROM parametro;

SELECT DISTINCT s.id_reservatorio
FROM serie_temporal AS s
INNER JOIN parametro AS p ON s.id_parametro = p.id_parametro
WHERE p.nome_parametro = 'Oxigênio Dissolvido'
ORDER BY s.id_reservatorio;

SELECT
    r.nome AS reservatorio
FROM reservatorio AS r
WHERE r.id_reservatorio IN (
    SELECT DISTINCT s.id_reservatorio
    FROM serie_temporal AS s
    INNER JOIN parametro AS p ON s.id_parametro = p.id_parametro
    WHERE p.nome_parametro = 'Oxigênio Dissolvido'
)
ORDER BY r.nome;

SELECT
    r.nome AS reservatorio
FROM reservatorio AS r
WHERE EXISTS (
    SELECT 1
    FROM serie_temporal AS s
    INNER JOIN parametro AS p ON s.id_parametro = p.id_parametro
    WHERE s.id_reservatorio = r.id_reservatorio
      AND p.nome_parametro = 'Oxigênio Dissolvido'
)
ORDER BY r.nome;

EXPLAIN ANALYZE
SELECT r.nome
FROM reservatorio AS r
WHERE r.id_reservatorio IN (
    SELECT DISTINCT s.id_reservatorio
    FROM serie_temporal AS s
    INNER JOIN parametro AS p ON s.id_parametro = p.id_parametro
    WHERE p.nome_parametro = 'Oxigênio Dissolvido'
);

EXPLAIN ANALYZE
SELECT r.nome
FROM reservatorio AS r
WHERE EXISTS (
    SELECT 1
    FROM serie_temporal AS s
    INNER JOIN parametro AS p ON s.id_parametro = p.id_parametro
    WHERE s.id_reservatorio = r.id_reservatorio
      AND p.nome_parametro = 'Oxigênio Dissolvido'
);
