CREATE DATABASE aula04; #(DDL)
USE aula04; #Se não especificar o banco para ser usado pode ocorrer problemas de gravar dados em um banco aberto anteriormente

# Criando tabelas
CREATE TABLE tipos_produto (
codigo INT NOT NULL AUTO_INCREMENT, 
descricao VARCHAR(30) NOT NULL, 
PRIMARY KEY(codigo)
);

CREATE TABLE produtos (
codigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
descricao VARCHAR (30) NOT NULL, 
preco DECIMAL(8,2) NOT NULL, 
codigo_tipo INT NOT NULL, 
FOREIGN KEY (codigo_tipo) REFERENCES tipos_produto (codigo)
);

# Populando as colunas da tabela (DML)
INSERT INTO tipos_produto (descricao) VALUES ('Computadores');
INSERT INTO tipos_produto (descricao) VALUES ('Impressoras');

INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Desktop', 1200, 1);
INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Laptop', 1800, 1);
INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Deskjet', 800, 2);
INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Laser', 500, 2);

# DQL (SELECT)

SELECT * FROM tipos_produto; #Retorna todos os dados nesta tabela
SELECT codigo, descricao FROM tipos_produto; # Mesmo resultado que acima, pois só temos duas colunas que já são todos os dados da tabela
SELECT descricao, codigo FROM tipos_produto; # Resultado igual, mas invertido
SELECT p.codigo AS Código, p.descricao AS Descrição, p.preco AS Preço, p.codigo_tipo AS ctp FROM produtos AS p; # Dando "alias" (apelidos) as colunas e a tabela
SELECT p.codigo AS 'COD', p.descricao AS 'DESC', p.preco AS 'PREC', p.codigo_tipo AS 'CTP' FROM produtos AS p WHERE p.preco > 500; #Mostra a tabela apenas com preços acima de 500

# DML (INSERT TO, UPDATE, DELETE)

INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Notebook', 1350, 1);
INSERT INTO produtos VALUES (NULL, 'Macbook Pro', 3500, 1); # Neste caso, mesmo sem informar as colunas funciona pois, os values se igualam com a quantidade de colunas e o NULL inicial é para que a PK seja auto incrementada neste espaço.
INSERT INTO tipos_produto (descricao, codigo) VALUES ('Apple', 3);

UPDATE produtos SET codigo_tipo = 3 WHERE codigo = 6; # Atualizar / modificar registros da tabela produtos, muda o codigo_tipo de 1 para 3 do Macbook, encontrando onde está o Macbook pelo valor 6, que é o codigo dele na tabela produtos
SELECT * FROM produtos; #Mostrar a tabela como ficou
UPDATE produtos SET descricao = 'Impressora Laser', preco = 350 WHERE codigo = 4; # Uma atualização para dois campos ao mesmo tempo, a virgula é utilizada nesta forma
#OBS: Se não filtrar o ponto desejado com WHERE, toda a tabela sera atualizada para os valores escolhidos

DELETE FROM produtos WHERE codigo = 4; # Deletando um registro a partir de sua linha (codigo ou PK)
SELECT * FROM produtos; #Vai mostrar a tabela sem o registro da linha 4

# DDL [CREATE (DATABASE ou TABLE), ALTER, DROP]

CREATE TABLE pessoas (                        # Criando a tabela pessoas
id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
idade INT NOT NULL,
cargo VARCHAR(30)
);

ALTER TABLE pessoas ADD ano_nascimento INT;       # Alterando a tabela 'pessoas' adicionando um campo chamado 'ano_nascimento', se não colocar NOT NULL ele será nulo
INSERT INTO pessoas (nome, idade, cargo) VALUES ('André', 29, 'técnico em Ti');
UPDATE pessoas SET nome = 'João', idade = 28, cargo = 'Analista', ano_nascimento = 1992 WHERE id = 1;

SELECT * FROM pessoas;

DROP TABLE pessoas;   # Apagar a tabela pessoas inteira, também serve para apagar um banco de dados (como aula04)
DROP DATABASE aula04;  # Apaga o banco de dados em questão

# DCL

# Nesta seção modificamos os privilegios do usuario quanto o banco de dados.
# Na aba administration no quadro esquerdo, na opção USERS AND PRIVILEGERS, com o usuarios princial (root) é possível modificar
# os privilegios e restrições dos demais usuários. Acessando a aba Schema privileges e em seguida 'select schema' é possível
# dar acesso a determinado usuário ao banco de dado específico. Vai ser mostrada varias opções para marcar do que este usuário 
# pode ou não fazer. Assim se tem um maior controle do banco de dados e das tabelas
# Sempre usar FLUSH PRIVILEGES para recarregar as tabelas e os privilegios quando mudar.

# DTL (TRANSACTION, COMMIT, ROLLBACK)

# Qualquer comando que é utilizando no client (como o MySQL workbench) e o banco de dados

START TRANSACTION;
INSERT INTO tipos_produto (descricao) VALUES ('Acessórios');
COMMIT;   # A transação inicia, os dados são gravados na tabela e o COMMIT faz que eles sejam salvos
	      # Caso não devam ser salvos, o comando ROLLBACK irá desfaz-los
SELECT * FROM tipos_produto;
 
START TRANSACTION;
INSERT INTO tipos_produto (descricao) VALUES ('Alimentos');
SELECT * FROM tipos_produto; 
ROLLBACK;    #Os dados entram na tabela, mas apos o ROLLBACK eles são apagados
       
# A transação é boa para controlar a adição de dados, assim podendo cancelar a inserção de dados errados
# ou que por algum motivo não deveria ser gravado, como uma transação errada numa transferencia bancaria em que
# o usuario pode cancelar ou errar uma conta digitada. O processo assim precisa ser desfeito e os dados restaurados
# para o modo anterior.

# Caso os dados sejam inseridos e não sejam salvos por commit e recebam um ROLLBACK, o proximo dado a ser inserido vai
# ter uma ID não sequencial, pois o programa considera os ids descartados pelo ROLLBACK. Isso só não
# ocorre se o COMMIT for usado após o ROLLBACK.

CREATE DATABASE aula05;
USE aula05;

CREATE TABLE tipos_produto (
codigo INT NOT NULL AUTO_INCREMENT, 
descricao VARCHAR(30) NOT NULL, 
PRIMARY KEY(codigo)
);

CREATE TABLE produtos (
codigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
descricao VARCHAR (30) NOT NULL, 
preco DECIMAL(8,2) NOT NULL, 
codigo_tipo INT NOT NULL, 
FOREIGN KEY (codigo_tipo) REFERENCES tipos_produto (codigo)
);

INSERT INTO tipos_produto (descricao) VALUES ('Computadores');
INSERT INTO tipos_produto (descricao) VALUES ('Impressoras');

INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Desktop', 1200, 1);
INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Laptop', 1800, 1);
INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Deskjet', 800, 2);
INSERT INTO produtos (descricao, preco, codigo_tipo) VALUES ('Laser', 500, 2);

# Filtrar consultas com WHERE

SELECT * FROM produtos WHERE codigo_tipo = 2; # Me MOSTRA TODOS OS DADOS DA TABELA PRODUTOS ONDE O codigo do tipo é igual a 2
SELECT * FROM produtos WHERE codigo_tipo = 2 AND preco > 510; #C oncatenar com AND especifica agora todos os produtos de codigo 2 e com preço acima de 510

# Consulta em multiplas tabelas (para tabelas que tem relacioamentos)

SELECT * FROM tipos_produto; # Consultas em tabelas separadas
SELECT * FROM produto;

SELECT p.codigo, p.descricao, p.preco, tp.descricao AS 'Tipo do produto' FROM produtos AS p, tipos_produto AS tp WHERE p.codigo_tipo = tp.codigo;
# No comando acima terei uma tabela com o a descrição do tipo de produto no lugar do código do tipo, sendo mais informativa
# Se o filtro WHERE não for usado, a tabela que irá retornar irá preencher cada produto multiplas vezes com cada um dos tipos existentes

# Junção de Tabelas
CREATE DATABASE juncao;
USE juncao;

CREATE TABLE profissoes (
id INT NOT NULL AUTO_INCREMENT,
cargo VARCHAR(50) not null,
PRIMARY KEY (id)
);

CREATE TABLE clientes (
id INT NOT NULL AUTO_INCREMENT,
nome VARCHAR(60) NOT NULL,
data_nascimento DATE NOT NULL,
telefone VARCHAR(50) NOT NULL,
id_profissao INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (id_profissao) REFERENCES profissoes(id)
);

CREATE TABLE consumidor (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(50) NOT NULL,
contato VARCHAR(50) NOT NULL,
endereco VARCHAR(60) NOT NULL,
cidade VARCHAR(50) NOT NULL,
cep VARCHAR(50) NOT NULL,
pais VARCHAR(15) NOT NULL
);

INSERT INTO profissoes (cargo) VALUES ('Programador');
INSERT INTO profissoes (cargo) VALUES ('Analista');
INSERT INTO profissoes (cargo) VALUES ('Suporte');
INSERT INTO profissoes (cargo) VALUES ('Gerente');

INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('João Pereira', '1981-06-15', '1234-5600', 1);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('Ricrado', '1984-02-10', '5634-5789', 2);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('Lucio', '1985-01-25', '1784-5120', 3);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('Janaina', '1989-08-05', '8909-5650', 1);

INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais) VALUES ('Alfredo Nunes', 'Maria Nunes', 'Rua da Paz', 'São Paulo', '53010-017', 'Brasil');
INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais) VALUES ('Ana Trujila', 'Marcos Pontes', 'Segunda Travessaz', 'Goiana', '53222-012', 'Brasil');
INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais) VALUES ('Ricardo Felicio', 'Nando Boura', 'Sapucai', 'São Paulo', '45610-114','Brasil');

#Junção de produto cartesiano (com esta podemos criar qualquer tipo de junção das demais variações)
SELECT c.id, c.nome, c.data_nascimento, c.telefone, p.cargo FROM clientes AS c, profissoes AS p WHERE c.id_profissao = p.id;

-- Inner Join
SELECT c.id, c.nome, c.data_nascimento, c.telefone, p.cargo FROM clientes AS c INNER JOIN profissoes AS p ON c.id_profissao = p.id;

-- Left/Right Outer Join (A tabela mais a esquerda é clientes, caso algu lciente n tivesse cargo, o cargo teria valor nulo mas todos os clientes apareceriam. No caso do RIGHT vemos a profissão gerente sem valores de cliente)
SELECT * FROM clientes LEFT OUTER JOIN profissoes ON clientes.id_profissao = profissoes.id;
SELECT * FROM clientes RIGHT OUTER JOIN profissoes ON clientes.id_profissao = profissoes.id;

-- FULL outer Join (Não funciona no Mysql, podemos fazer o right e left ao mesmo tempo intercalados por UNION)
SELECT * FROM clientes LEFT OUTER JOIN profissoes ON clientes.id_profissao = profissoes.id
UNION
SELECT * FROM clientes RIGHT OUTER JOIN profissoes ON clientes.id_profissao = profissoes.id;

-- Cross Join
SELECT c.id, c.nome, c.data_nascimento, c.telefone, p.cargo FROM clientes AS c CROSS JOIN profissoes AS p; # pARA CADA PROFISSÃO, cada cliente tem aquela profissão)

-- Self Join (Uma join na mesma tabela)
SELECT a.nome AS Consumidro1, b.nome AS Consumidor2, a.cidade
FROM consumidor AS a
INNER JOIN consumidor AS b
ON a.id <> b.id # sinal relacional de diferença
AND a.cidade = b.cidade
ORDER BY a.cidade;

# Funções de agregação
CREATE DATABASE agregacao;
USE agregacao;

CREATE TABLE categoria (
codigo INT NOT NULL AUTO_INCREMENT, 
descricao VARCHAR(30) NOT NULL, 
PRIMARY KEY(codigo)
);

CREATE TABLE produtos (
codigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
descricao VARCHAR (30) NOT NULL, 
preco_venda DECIMAL(8,2) NOT NULL, 
preco_custo DECIMAL(8,2) NOT NULL,
codigo_categoria INT NOT NULL, 
FOREIGN KEY (codigo_categoria) REFERENCES categoria (codigo)
);

# Populando as colunas da tabela (DML)
INSERT INTO categoria (descricao) VALUES ('Material Escolar');
INSERT INTO categoria (descricao) VALUES ('Informática');
INSERT INTO categoria (descricao) VALUES ('Escritório');
INSERT INTO categoria (descricao) VALUES ('Game');

INSERT INTO produtos (descricao, preco_venda, preco_custo, codigo_categoria) VALUES ('Caderno', '5.45', '2.30', 1);
INSERT INTO produtos (descricao, preco_venda, preco_custo, codigo_categoria) VALUES ('Caneta', '1.20', '0.45', 1);
INSERT INTO produtos (descricao, preco_venda, preco_custo, codigo_categoria) VALUES ('Pendrive', '120', '32.55', 2);
INSERT INTO produtos (descricao, preco_venda, preco_custo, codigo_categoria) VALUES ('Mouse', '17.00', '4.30', 2);

-- Max / Min / AVG
SELECT MAX(preco_venda) FROM produtos; # Maior preco de venda de produtos
SELECT MIN(preco_venda) FROM produtos; # mENOR preco de venda
SELECT AVG(preco_venda) FROM produtos; # Media do preço de venda de produtos

-- ROUND
SELECT ROUND(AVG(preco_venda), 2) FROM produtos; # Arredondar decimas largas (NESTE CASO, DUAS CASAS DEICMAIS)

-- COUNT
SELECT COUNT(preco_venda) AS 'Quantidade' FROM produtos WHERE codigo_categoria = 1;

-- GROUP BY (AGRUPAR)
SELECT codigo, MAX(preco_venda) FROM produtos GROUP BY codigo_categoria; # Maior preço para cada categoria

-- HAVING
SELECT codigo, MAX(preco_venda) FROM produtos GROUP BY codigo_categoria HAVING MAX(preco_venda) > 10; #Maior preço de cada categoria que seja maior que 10

# Funções de agrupamento e ordenação

CREATE DATABASE agrupamento;
USE agrupamento;

CREATE TABLE categoria (
codigo INT NOT NULL AUTO_INCREMENT, 
descricao VARCHAR(30) NOT NULL, 
PRIMARY KEY(codigo)
);

CREATE TABLE fabricantes (
id INT NOT NULL AUTO_INCREMENT,
nome VARCHAR(50) not null,
PRIMARY KEY (id)
);

CREATE TABLE produtos (
codigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
nome VARCHAR (30) NOT NULL, 
id_fabricante INT NOT NULL, 
quantidade INT NOT NULL,
codigo_categoria INT NOT NULL, 
FOREIGN KEY (codigo_categoria) REFERENCES categoria (codigo),
FOREIGN KEY (id_fabricante) REFERENCES fabricantes (id)
);

# Populando as colunas da tabela (DML)
INSERT INTO categoria (descricao) VALUES ('Console');
INSERT INTO categoria (descricao) VALUES ('notebook');
INSERT INTO categoria (descricao) VALUES ('Celular');
INSERT INTO categoria (descricao) VALUES ('Sofá');

INSERT INTO fabricantes (nome) VALUES ('Sony');
INSERT INTO fabricantes (nome) VALUES ('Dell');
INSERT INTO fabricantes (nome) VALUES ('Microsoft');
INSERT INTO fabricantes (nome) VALUES ('Zafira');

INSERT INTO produtos (nome, id_fabricante, quantidade, codigo_categoria) VALUES ('Palystation 3', '1', '100', 1);
INSERT INTO produtos (nome, id_fabricante, quantidade, codigo_categoria) VALUES ('Core 2 Duo', '2', '200', 2);
INSERT INTO produtos (nome, id_fabricante, quantidade, codigo_categoria) VALUES ('X Box 360', '3', '350', 1);
INSERT INTO produtos (nome, id_fabricante, quantidade, codigo_categoria) VALUES ('Iphone 4', '3', '50', 3);
INSERT INTO produtos (nome, id_fabricante, quantidade, codigo_categoria) VALUES ('Sofa estofado ', '4', '200', 4);
INSERT INTO produtos (nome, id_fabricante, quantidade, codigo_categoria) VALUES ('WII', '1', '250', 1);

-- GROUP BY e HAVING SUM
SELECT c.descricao AS Tipo, f.nome AS Fabricante, SUM(p.quantidade) AS 'Quantidade em estoque'
FROM categoria AS c, fabricantes AS f, produtos AS p WHERE c.codigo = p.codigo AND f.id = p.id_fabricante
GROUP BY c.descricao, f.nome;

SELECT c.descricao AS Tipo, f.nome AS Fabricante, SUM(p.quantidade) AS 'Quantidade em estoque'
FROM categoria AS c, fabricantes AS f, produtos AS p WHERE c.codigo = p.codigo AND f.id = p.id_fabricante
GROUP BY c.descricao, f.nome
HAVING SUM(P.QUANTIDADE) > 200;

-- ORDER BY ASC ou DESC (Ordernar pela ordem ascendente ou descendente)
SELECT codigo, nome, codigo_categoria, id_fabricante, quantidade FROM produtos ORDER BY codigo_categoria ASC;
SELECT codigo, nome, codigo_categoria, id_fabricante, quantidade FROM produtos ORDER BY codigo_categoria DESC;

# FUNÇÕES DE DATA E HORA

SELECT CURDATE() AS 'Data Atual';
SELECT DATE_ADD(CURDATE(),INTERVAL 3 DAY) AS 'Data de vencimento'; # aDICIONA UM INTERVALO DE 3 DIAS a data atual
SELECT DATE_SUB(CURDATE(),INTERVAL 10 DAY) AS 'Data de matrícula'; # Subtrai 10 dias do CURTIME()
SELECT DATE_FORMAT(CURTIME(), '%d - %m - %Y') AS 'Data atual'; # o hífen pode ser substituido por outro caractere

#SUBCONSULTAS

CREATE DATABASE Subconsultas;
USE Subconsultas;

CREATE TABLE profissoes (
id INT NOT NULL AUTO_INCREMENT,
cargo VARCHAR(50) not null,
PRIMARY KEY (id)
);

CREATE TABLE clientes (
id INT NOT NULL AUTO_INCREMENT,
nome VARCHAR(60) NOT NULL,
data_nascimento DATE NOT NULL,
telefone VARCHAR(50) NOT NULL,
id_profissao INT NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (id_profissao) REFERENCES profissoes(id)
);

CREATE TABLE consumidor (
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(50) NOT NULL,
contato VARCHAR(50) NOT NULL,
endereco VARCHAR(60) NOT NULL,
cidade VARCHAR(50) NOT NULL,
cep VARCHAR(50) NOT NULL,
pais VARCHAR(15) NOT NULL
);

INSERT INTO profissoes (cargo) VALUES ('Programador');
INSERT INTO profissoes (cargo) VALUES ('Analista');
INSERT INTO profissoes (cargo) VALUES ('Suporte');
INSERT INTO profissoes (cargo) VALUES ('Gerente');

INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('João Pereira', '1981-06-15', '1234-5600', 1);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('Ricrado', '1984-02-10', '5634-5789', 2);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('Lucio', '1985-01-25', '1784-5120', 3);
INSERT INTO clientes (nome, data_nascimento, telefone, id_profissao) VALUES ('Janaina', '1989-08-05', '8909-5650', 1);

INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais) VALUES ('Alfredo Nunes', 'Maria Nunes', 'Rua da Paz', 'São Paulo', '53010-017', 'Brasil');
INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais) VALUES ('Ana Trujila', 'Marcos Pontes', 'Segunda Travessaz', 'Goiana', '53222-012', 'Brasil');
INSERT INTO consumidor (nome, contato, endereco, cidade, cep, pais) VALUES ('Ricardo Felicio', 'Nando Boura', 'Sapucai', 'São Paulo', '45610-114','Brasil');

SELECT nome FROM clientes WHERE id_profissao IN (SELECT id FROM profissoes WHERE cargo = 'Programador'); # Estou consultando o NOME dos CLIENTES ond sua profissão (id_profissao) consta na consulta interna entre parenteses que retornara apenas 'programadores'
SELECT nome FROM clientes, profissoes AS p WHERE id_profissao = p.id AND cargo = 'Programador'; # Mesmo caso acima,  Estou consultando o NOME dos CLIENTES ond sua profissão (id_profissao) consta na consulta interna entre parenteses que retornara apenas 'programadores'