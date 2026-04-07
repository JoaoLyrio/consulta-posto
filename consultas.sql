SELECT p.nome_posto, CONCAT(p.logradouro, ', ', p.numero) as endereco, p.bairro,  
t.nome_combustivel, c.valor_combustivel, c.data_coleta 
FROM coletas c 
JOIN postos p ON c.id_posto = p.id_posto 
JOIN tipos_combustivel t ON c.id_tipo = t.id_tipo 
WHERE c.valor_combustivel = (SELECT MIN(valor_combustivel) FROM coletas WHERE id_tipo = c.id_tipo) 
OR c.valor_combustivel = (SELECT MAX(valor_combustivel) FROM coletas WHERE id_tipo = c.id_tipo) 
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
WHERE c.data_coleta = (SELECT MAX(data_coleta) FROM coletas WHERE id_posto = c.id_posto AND id_tipo = c.id_tipo) 
ORDER BY p.nome_posto;

SELECT p.nome_posto, p.bairro, t.nome_combustivel, c.valor_combustivel, c.data_coleta 
FROM coletas c 
JOIN postos p ON c.id_posto = p.id_posto 
JOIN tipos_combustivel t ON c.id_tipo = t.id_tipo 
WHERE p.nome_posto = 'Posto Sereia' AND t.nome_combustivel = 'Gasolina' 
ORDER BY c.data_coleta ASC;