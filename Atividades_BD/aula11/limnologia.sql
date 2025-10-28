DROP TABLE IF EXISTS serie_temporal CASCADE;
DROP TABLE IF EXISTS campanha CASCADE;
DROP TABLE IF EXISTS reservatorio CASCADE;

CREATE TABLE reservatorio (
    id_reservatorio SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL
);

CREATE TABLE campanha (
    id_campanha SERIAL PRIMARY KEY,
    id_reservatorio INT NOT NULL REFERENCES reservatorio(id_reservatorio),
    data_coleta DATE NOT NULL,
    instituicao VARCHAR(200) NOT NULL
);

CREATE TABLE serie_temporal (
    id_serie SERIAL PRIMARY KEY,
    id_campanha INT NOT NULL REFERENCES campanha(id_campanha),
    parametro VARCHAR(100) NOT NULL,
    valor NUMERIC(12,4) NOT NULL,
    data_hora TIMESTAMP NOT NULL
);

INSERT INTO reservatorio (nome) VALUES
('Represa São João'),
('Lago Azul'),
('Barragem das Flores');

INSERT INTO campanha (id_reservatorio, data_coleta, instituicao) VALUES
(1, '2025-01-10', 'Inst A'),
(1, '2025-02-15', 'Inst A'),
(1, '2025-03-20', 'Inst A'),
(1, '2025-04-25', 'Inst A'), 
(2, '2025-05-05', 'Inst B'),
(2, '2025-06-10', 'Inst B'),
(3, '2025-07-12', 'Inst C');

INSERT INTO serie_temporal (id_campanha, parametro, valor, data_hora) VALUES
(1, 'pH', 7.12, '2025-01-10 09:00:00'),
(1, 'Oxigênio Dissolvido', 6.25, '2025-01-10 09:05:00'),
(2, 'pH', 7.30, '2025-02-15 10:00:00'),
(2, 'Oxigênio Dissolvido', 5.90, '2025-02-15 10:05:00'),
(3, 'pH', 6.95, '2025-03-20 11:00:00'),
(3, 'Temperatura', 22.5, '2025-03-20 11:05:00'),
(4, 'pH', 7.05, '2025-04-25 12:00:00'),
(5, 'pH', 7.50, '2025-05-05 09:30:00'),
(5, 'Oxigênio Dissolvido', 6.80, '2025-05-05 09:35:00'),
(6, 'Temperatura', 23.1, '2025-06-10 10:20:00'),
(7, 'pH', 7.00, '2025-07-12 08:50:00');

SELECT
    r.nome AS reservatorio,
    COUNT(c.id_campanha) AS total_campanhas
FROM reservatorio AS r
INNER JOIN campanha AS c
    ON r.id_reservatorio = c.id_reservatorio
GROUP BY r.nome
ORDER BY total_campanhas DESC;

SELECT
    st.parametro,
    AVG(st.valor)::numeric(12,4) AS media_valor,
    COUNT(st.id_serie) AS n_medidas
FROM serie_temporal AS st
GROUP BY st.parametro
ORDER BY parametro;

SELECT
    c.instituicao,
    COUNT(c.id_campanha) AS total_campanhas
FROM campanha AS c
GROUP BY c.instituicao
HAVING COUNT(c.id_campanha) > 3
ORDER BY total_campanhas DESC;