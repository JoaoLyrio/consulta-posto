CREATE DATABASE IF NOT EXISTS MonitoramentoVV; 
USE MonitoramentoVV; 
 
CREATE TABLE postos ( 
    id_posto INT AUTO_INCREMENT PRIMARY KEY, 
    nome_posto VARCHAR(100) NOT NULL, 
    logradouro VARCHAR(100), 
    numero VARCHAR(10), 
    bairro VARCHAR(50) NOT NULL 
); 
 
CREATE TABLE telefones_posto ( 
    id_telefone INT AUTO_INCREMENT PRIMARY KEY, 
    id_posto INT, 
    numero_telefone VARCHAR(20), 
    FOREIGN KEY (id_posto) REFERENCES postos(id_posto) ON DELETE CASCADE 
); 
 
CREATE TABLE tipos_combustivel ( 
    id_tipo INT AUTO_INCREMENT PRIMARY KEY, 
    nome_combustivel VARCHAR(30) NOT NULL 
); 
 
CREATE TABLE coletas ( 
    id_coleta INT AUTO_INCREMENT PRIMARY KEY, 
    id_posto INT, 
    id_tipo INT, 
    valor_combustivel DECIMAL(10, 2) NOT NULL, 
    data_coleta DATE NOT NULL, 
    FOREIGN KEY (id_posto) REFERENCES postos(id_posto), 
    FOREIGN KEY (id_tipo) REFERENCES tipos_combustivel(id_tipo) 
); 
 
INSERT INTO tipos_combustivel (nome_combustivel) VALUES  
('Gasolina'), ('Gasolina Aditivada'), ('Etanol'), ('Diesel'); 
 
INSERT INTO postos (nome_posto, logradouro, numero, bairro) VALUES  
('Posto Praia da Costa', 'Av. Gil Veloso', '500', 'Praia da Costa'), 
('Posto Itapuã Prime', 'Av. Jair de Andrade', '10', 'Itapuã'), 
('Posto Mar Azul', 'Rua Deolindo Perim', '200', 'Itapuã'), 
('Posto Farol', 'Rua Castelo Branco', '80', 'Praia da Costa'), 
('Posto Jockey', 'Rod. do Sol', '1200', 'Itapuã'), 
('Posto Sereia', 'Av. Estudante José Júlio', '30', 'Praia da Costa'); 
 
INSERT INTO coletas (id_posto, id_tipo, valor_combustivel, data_coleta) VALUES  
(1, 1, 5.89, '2026-01-01'), (1, 1, 5.95, '2026-01-02'), (1, 1, 5.85, '2026-01-02'), 
(1, 1, 6.05, '2026-01-03'), (1, 1, 5.99, '2026-01-02'), (1, 1, 5.92, '2026-02-02'); 
 
SELECT p.nome_posto, CONCAT(p.logradouro, ', ', p.numero) as endereco, p.bairro,  
t.nome_combustivel, c.valor_combustivel, c.data_coleta 
FROM coletas c 
JOIN postos p ON c.id_posto = p.id_posto 
JOIN tipos_combustivel t ON c.id_tipo = t.id_tipo 
WHERE c.valor_combustivel = (SELECT MIN(valor_combustivel) FROM coletas WHERE 
id_tipo = c.id_tipo) 
OR c.valor_combustivel = (SELECT MAX(valor_combustivel) FROM coletas WHERE 
id_tipo = c.id_tipo) 
ORDER BY t.nome_combustivel, c.valor_combustivel; 
SELECT p.nome_posto, p.bairro, t.nome_combustivel,  
ROUND(AVG(c.valor_combustivel), 2) AS preco_medio,  
COUNT(c.id_coleta) AS qtd_amostras 
FROM coletas c 
JOIN postos p ON c.id_posto = p.id_posto 
JOIN tipos_combustivel t ON c.id_tipo = t.id_tipo 
GROUP BY p.nome_posto, p.bairro, t.nome_combustivel; 
SELECT p.nome_posto, p.bairro, t.nome_combustivel, c.valor_combustivel, c.data_coleta 
FROM coletas c 
JOIN postos p ON c.id_posto = p.id_posto 
JOIN tipos_combustivel t ON c.id_tipo = t.id_tipo 
WHERE c.data_coleta = (SELECT MAX(data_coleta) FROM coletas WHERE id_posto = 
c.id_posto AND id_tipo = c.id_tipo) 
ORDER BY p.nome_posto; 
SELECT p.nome_posto, p.bairro, t.nome_combustivel, c.valor_combustivel, c.data_coleta 
FROM coletas c 
JOIN postos p ON c.id_posto = p.id_posto 
JOIN tipos_combustivel t ON c.id_tipo = t.id_tipo 
WHERE p.nome_posto = 'Posto Sereia' AND t.nome_combustivel = 'Gasolina' 
ORDER BY c.data_coleta ASC; 