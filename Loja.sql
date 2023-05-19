CREATE DATABASE bdLoja

USE bdLoja

CREATE TABLE tbFabricante(
	codFabricante INT PRIMARY KEY IDENTITY(1,1)
	,nomeFabricante VARCHAR(20)
)


SET IDENTITY_INSERT tbFabricante ON

INSERT INTO tbFabricante(codFabricante, nomeFabricante)
VALUES('1','Unilever'),('2','P&G'),('3','Bunge')



SET IDENTITY_INSERT tbFabricante OFF


CREATE TABLE tbFornecedor(
	codFornecedor INT PRIMARY KEY IDENTITY(1,1)
	,nomeFornecedor VARCHAR(20)
	,contatoFornecedor VARCHAR(20)
)

SET IDENTITY_INSERT tbFornecedor ON

INSERT INTO tbFornecedor( codFornecedor,nomeFornecedor,contatoFornecedor)
VALUES('1','Atacadão','Carlos Santos'),('2','Assai','Maria Stella'),('3','Roldão','Paulo César')



SET IDENTITY_INSERT tbFornecedor OFF


CREATE TABLE tbProduto(
	codProduto INT PRIMARY KEY IDENTITY(1,1)
	,descricaoProduto VARCHAR(50)
	,valorProduto MONEY
	,quantidadeProduto BIGINT
	,codFornecedor INT FOREIGN KEY REFERENCES tbFornecedor (codFornecedor)
	,codFabricante INT FOREIGN KEY REFERENCES tbFabricante (codFabricante)
)

SET IDENTITY_INSERT tbProduto ON

INSERT INTO tbProduto( codProduto,descricaoProduto,valorProduto,quantidadeProduto,codFabricante,codFornecedor)
VALUES('1','Amaciante Downy','5.76','1500','2','1')
	 ,('2','Amaciante Comfort','5.45','2300','1','1')
	 ,('3','Sabão em pó OMO','5.99','1280','1','2')
	 ,('4','Margarina Qually','4.76','2500','3','1')
	 ,('5','Salsicha Hot Dog Sadia','6.78','2900','3','2')
	 ,('6','Mortadela Perdigão','2.50','1200','3','3')
	 ,('7','Hamburger Sadia','9.89','1600','3','1')
	 ,('8','Fralda Pampers','36.00','340','2','3')
	 ,('9','Xampu Seda','5.89','800','1','2')
	 ,('10','Condicionador','6.50','700','1','3')
	 

SET IDENTITY_INSERT tbProduto OFF


CREATE TABLE tbCliente(
	codCliente INT PRIMARY KEY IDENTITY(1,1)
	,nomeCliente  VARCHAR(50)
	,cpfCliente CHAR(14)
	,emailCliente VARCHAR(50)
	,sexoCliente CHAR(1)
	,dataNascimentoCliente DATE
)

SET IDENTITY_INSERT tbCliente ON

INSERT INTO tbCliente( codCliente,nomeCliente,cpfCliente,emailCliente,sexoCliente,dataNascimentoCliente)
VALUES('1','Amando José Santana','12345678900','amandojsantana@outlook.com','m','1961-02-21')
	 ,('2','Sheila Carvalho Leal','45678909823','scarvalho@ig.com.br','f','1978-09-13')
	 ,('3','Carlos Henrique Souza','76598278299','chentique@ig.com.br','m','1981-09-08')
	 ,('4','Maria Aparecida Souza','87365309899','mapdasouza@outlook.com','f','1962-07-07')
	 ,('5','Adriana Nogueira Silva','76354309388','drica1977@ig.com.br','f','1977-04-09')
	 ,('6','Paulo hentique Silva','87390123111','phsilva80@hotmail.com','m','1987-02-02')




SET IDENTITY_INSERT tbCliente OFF


CREATE TABLE tbVenda(
	codVenda INT PRIMARY KEY IDENTITY(1,1)
	,dataVenda DATETIME
	,valorTotalVenda MONEY
	,codCliente INT FOREIGN KEY REFERENCES tbCliente (codCliente)
)

SET IDENTITY_INSERT tbVenda ON

INSERT INTO tbVenda( codVenda,dataVenda,valorTotalVenda,codCliente)
VALUES('1','01/02/2014','4500','1')
	 ,('2','03/02/2014','3400','1')
	 ,('3','10/02/2014','2100','2')
	 ,('4','15/02/2014','2700','3')
	 ,('5','17/03/2014','560','3')
	 ,('6','09/04/2014','1200','4')
	 ,('8','07/05/2014','3500','5')
	 ,('9','07/05/2014','3400','1')
	 ,('10','05/05/2014','4000','2')



SET IDENTITY_INSERT tbVenda OFF


CREATE TABLE tbItemVenda(
	codItemVenda INT PRIMARY KEY IDENTITY(1,1)
	,quantidadeItemVenda BIGINT
	,subTotalItemVenda MONEY
	,codVenda INT FOREIGN KEY REFERENCES tbVenda (codVenda)
	,codProduto INT FOREIGN KEY REFERENCES tbProduto (codProduto)
)

SET IDENTITY_INSERT tbItemVenda ON

INSERT INTO tbItemVenda( codItemVenda,quantidadeItemVenda,subTotalItemVenda,codVenda,codProduto)
VALUES('1','200','1500','1','1')
	 ,('2','300','3000','1','2')
	 ,('3','120','1400','2','4')
	 ,('4','200','1000','2','2')
	 ,('5','130','1000','2','3')
	 ,('6','200','2100','3','5')
	 ,('7','120','1000','4','4')
	 ,('8','450','700','4','5')
	 ,('9','200','560','5','5')
	 ,('10','200','600','6','7')
	 ,('11','300','600','6','6')
	 ,('12','300','2500','8','1')
	 ,('13','200','1000','8','5')
	 ,('14','250','1700','9','6')
	 ,('15','200','1700','9','5')
	 ,('16','1000','4000','10','4')



SET IDENTITY_INSERT tbItemVenda OFF






SELECT * FROM tbFabricante
SELECT * FROM tbFornecedor
SELECT * FROM tbProduto
SELECT * FROM tbCliente
SELECT * FROM tbVenda
SELECT * FROM tbItemVenda

--DROP DATABASE bdLoja



--Listar as descrições dos produtos ao lado do nome dos fabricantes:
SELECT p.descricaoProduto, f.nomeFabricante
FROM tbProduto p
JOIN tbFabricante f ON p.codFabricante = f.codFabricante;


--Listar as descrições dos produtos ao lado do nome dos fornecedores:
SELECT p.descricaoProduto, fo.nomeFornecedor
FROM tbProduto p
JOIN tbFornecedor fo ON p.codFornecedor = fo.codFornecedor;


--Listar preços dos produtos ao lado do fabricante:
SELECT p.valorProduto, f.nomeFabricante
FROM tbProduto p
JOIN tbFabricante f ON p.codFabricante = f.codFabricante;


--Listar todas as vendas de um cliente, apresentando o nome do cliente e o código da venda:
SELECT c.nomeCliente, v.codVenda
FROM tbCliente c
JOIN tbVenda v ON c.codCliente = v.codCliente;


--Listar todos os produtos de uma venda exibindo o nome do cliente, número da venda e os itens da venda:
SELECT c.nomeCliente, v.codVenda, p.descricaoProduto, iv.quantidadeItemVenda, iv.subTotalItemVenda
FROM tbVenda v
JOIN tbCliente c ON c.codCliente = v.codCliente
JOIN tbItemVenda iv ON iv.codVenda = v.codVenda
JOIN tbProduto p ON p.codProduto = iv.codProduto;