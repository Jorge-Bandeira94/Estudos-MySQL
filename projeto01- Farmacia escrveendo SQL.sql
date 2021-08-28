# DML INSERINDO DADOS DE TESTE
USE projeto01;

# OS DADOS DEVEM SER INICALMENTE INSERIDO NAS TABELAS QUE NÃO APRESENTEM CHAVES ESTRANGEIRAS

-- Tipos produtos
INSERT INTO tipos_produto (tipo) VALUES ('remédios');
INSERT INTO tipos_produto (tipo) VALUES ('cosméticos');
INSERT INTO tipos_produto (tipo) VALUES ('diversos');

-- Fabricantes
INSERT INTO fabricante (nome) VALUES ('AstraZeneca');
INSERT INTO fabricante (nome) VALUES ('Roque');
INSERT INTO fabricante (nome) VALUES ('PFizer');

-- Médicos
INSERT INTO medico (nome, crm) VALUES ('José Augusto', '23409');
INSERT INTO medico (nome, crm) VALUES ('Alfredo', '33401');
INSERT INTO medico (nome, crm) VALUES ('Ramos Silva', '24467');

-- Clientes
INSERT INTO clientes (nome, endereco, telefone, cep, cpf, localidade) VALUES ('André Gustavo', 'Palmares', '33410941', '51020-14', '104566098', 'Pernambuco');
INSERT INTO clientes (nome, endereco, telefone, cep, cpf, localidade) VALUES ('Rodrigo da Silva', 'Segunda Travessa', '99876752', '54360-20', '102334567', 'Pernambuco');
INSERT INTO clientes (nome, endereco, telefone, cep, cpf, localidade) VALUES ('Mario José', 'Ribeirão', '98776542', '22098-10', '45678943', 'Alagoas');

# Agoa podemos inserir dados de tabelas com chaves estrageiras das tabelas que ja populamos

-- Produtos
INSERT INTO produtos (nome, designacao, composicao, preco, id_fabricante, id_tipo) VALUES ('Dipirona', 'Dor de cabeça', 'Metilpropileno', '12.44', '1', '1');
INSERT INTO produtos (nome, designacao, composicao, preco, id_fabricante, id_tipo) VALUES ('Nivea Sabonete', 'Higiene corporal', 'Enxore 0.5', '5.50', '2', '2');
INSERT INTO produtos (nome, designacao, composicao, preco, id_fabricante, id_tipo) VALUES ('Barra de ceral Agulis', 'Nutrição', 'Banana com chocolate', '2.99', '3', '3');
INSERT INTO produtos (nome, designacao, composicao, preco, id_fabricante, id_tipo) VALUES ('Shampo Protex', 'Anticaspa', 'Isopropanol', '82.99', '1', '1');

-- Compras
INSERT INTO compra (idcompras, data, id_cliente) VALUES ('1', '2021/07/03', 1); # Esqueci de colcoar auto incremente no id desta tabela, tive de por manualmente aqui
INSERT INTO compra (idcompras, data, id_cliente) VALUES ('2', '2021/05/12', 2);
INSERT INTO compra (idcompras, data, id_cliente) VALUES ('3', '2021/06/17', 3);

-- Produtos compra
INSERT INTO produtos_compra (id_produto, id_compra, quantidade) VALUES ('1', '2', '3');
INSERT INTO produtos_compra (id_produto, id_compra, quantidade) VALUES ('4', '2', '1');
INSERT INTO produtos_compra (id_produto, id_compra, quantidade) VALUES ('2', '3', '5');
INSERT INTO produtos_compra (id_produto, id_compra, quantidade) VALUES ('3', '1', '4');

-- Receitas médicas
INSERT INTO receitas_medica (id_produtos_compra, id_medico, receitas_medica) VALUES ('1', '1', 'Receita 1.pdf');
INSERT INTO receitas_medica (id_produtos_compra, id_medico, receitas_medica) VALUES ('2', '3', 'Receita 2.pdf');


# Consultas simples

SELECT * FROM tipos_produto;
SELECT idtipos_produto, tipo FROM tipos_produto;
SELECT tipo, idtipos_produto FROM tipos_produto;
SELECT idtipos_produto, tipo FROM tipos_produto ORDER BY idtipos_produto DESC;
SELECT idtipos_produto, tipo FROM tipos_produto ORDER BY tipo ASC; #Aqui em ordem alfabética
SELECT * FROM compra;
SELECT * FROM produtos_compra;

# Consultas complexas

SELECT p.nome, c.id_compra, c.quantidade FROM produtos_compra AS c, produtos AS p WHERE p.idprodutos = c.idprodutos_compra AND quantidade > 3;


-- Descobrir valor total de uma compra
-- 1 Colocar nome dos clientes nas compras
SELECT c.idcompras , c.data, cl.nome 
FROM compra AS c, clientes AS cl 
WHERE c.idcompras = cl.idclientes;

-- 2 Produtos compra
SELECT p.id_produto AS 'Id', prod.nome AS 'Nome', p.quantidade 
FROM produtos_compra AS p, produtos AS prod 
WHERE p.id_produto = prod.idprodutos;

-- 3 calcular os preços individuais
SELECT c.idcompras , c.data, cl.nome, prod.nome AS 'Nome', p.quantidade, prod.preco AS 'Preço', (prod.preco * p.quantidade) AS 'Total'
FROM produtos_compra AS p, produtos AS prod, compra AS c, clientes AS cl 
WHERE c.idcompras = cl.idclientes AND p.id_produto = prod.idprodutos AND p.id_compra = c.idcompras 
ORDER BY cl.nome ASC;

-- 4 Calculo total para individuos que compraram mais de um produto (o Id da compra vai ser o memso para compras diferentes do mesmo cliente, usar ele)
SELECT c.idcompras , c.data, cl.nome AS 'Cliente', 
SUM(prod.preco * p.quantidade) AS total #Adicionado uma soma para mais de um produtos comprado para a multiplicação dos produtos (sem o group by o somatorio n funciona)
FROM produtos_compra AS p, produtos AS prod, compra AS c, clientes AS cl 
WHERE c.idcompras = cl.idclientes AND p.id_produto = prod.idprodutos AND p.id_compra = c.idcompras 
GROUP BY c.idcompras; # Aqui vai agrupar idcompras iguais fazendo a soma la em cima funcionar


# Atualizando dados (mudando um produto por outro, alterando preço e descrição)
UPDATE tipos_produto SET tipo = 'Suplemento' WHERE idtipos_produto = 3;
SELECT * FROM tipos_produto;

UPDATE produtos SET  preco = '124.16', nome = 'WheyProtein', composicao = 'creatina', designacao = 'Ganho de massa muscular' WHERE id_tipo = 3;
SELECT * FROM produtos;


# Exluindo dados DML
SELECT * FROM produtos_compra;
DELETE FROM produtos_compra WHERE idprodutos_compra = 3; # Deletou o registor no id 3
SELECT * FROM produtos_compra;
