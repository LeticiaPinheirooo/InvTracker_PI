-- Criar o Banco de Dados
CREATE DATABASE grupo1;

-- Utilizar o banco de dados
USE grupo1;

-- Criar a tabela cadastro
CREATE TABLE cadastro (
	id_cadastro INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    razao VARCHAR(70),
    cnpj CHAR(14) UNIQUE NOT NULL, -- Considerar apenas os números do CNPJ
    email VARCHAR(70) UNIQUE NOT NULL
		CONSTRAINT chkEmail CHECK (email LIKE '%@%'),
    telefone VARCHAR(15) NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    dtCadastro DATETIME DEFAULT current_timestamp
);

-- Criar a tabela produto
CREATE TABLE produto (
	id_produto INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(50),
    marca VARCHAR(50),
    categoria VARCHAR(50),
    tamanho INT -- em centímetros
);

-- Criar a tabela sensor
CREATE TABLE sensor (
	id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    nSerie VARCHAR(40),
    status_sensor VARCHAR(15)
		CONSTRAINT chkStatus CHECK (status_sensor IN ('Ativo', 'Inativo', 'Manutenção'))
);

-- Criar a tabela registro
CREATE TABLE registro (
	id_registro INT PRIMARY KEY AUTO_INCREMENT,
    distancia DECIMAL(3,2), 
    status_alerta VARCHAR(8)
		CONSTRAINT chkAlerta CHECK (status_alerta IN ('Alto', 'Moderado', 'Baixo')),
    dtRegistro DATETIME DEFAULT current_timestamp
);

-- Criar a tabela estoque
CREATE TABLE estoque (
	id_estoque INT PRIMARY KEY AUTO_INCREMENT,
    tamanho DECIMAL(3,2),
    setor VARCHAR(40), -- Referente ao nome do setor (exemplo: Setor AZ)
    categoria VARCHAR(40) -- Referente ao tipo de produto (exemplo: Sabão em pó)
);

-- Criar tabela lote
CREATE TABLE lote (
	id_lote INT PRIMARY KEY AUTO_INCREMENT,
    numLote INT,
    dtValidade DATE,
    dtFabricacao DATE,
    dtEntrada DATETIME DEFAULT current_timestamp,
    dtSaida DATETIME DEFAULT current_timestamp
);

-- Criar tabela cliente
CREATE TABLE cliente (
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    status_cliente VARCHAR(8)
		CONSTRAINT chkCliente CHECK (status_cliente IN('Ativo', 'Inativo'))
);

-- Criar tabela pagamento
CREATE TABLE pagamento (
	id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
	moeda VARCHAR(30) DEFAULT 'BRL',
    preco DECIMAL(10,2),
    metodo VARCHAR(30)
		CONSTRAINT chkMetodo CHECK(metodo IN ('Pix', 'Boleto', 'Débito', 'Crédito')),
	quantidadeParcela INT DEFAULT 1,
    dtContratacao DATETIME DEFAULT current_timestamp, -- Data de registro de quando o serviço foi contratado.
	dtPagamento DATE,
	dtVencimento DATE,
    status_pagamento VARCHAR(25) DEFAULT 'Pendente'
		CONSTRAINT chkPagamento CHECK( status_pagamento IN ('Inadimplente', 'Pago', 'Cancelado', 'Pendente'))
);


-- Inserir os dados na tabela cadastro
INSERT INTO cadastro (nome, razao, cnpj, email, telefone, senha_hash)
VALUES
('Supermercado Sol Nascente', 'Sol Nascente Atacadista LTDA', '78393422235045', 'contato@solnascente.com', '(01)0000-0001', 's[LA@vS8n^AP'),
('Mercado Alegria Fliz', 'Alegria Feliz Atacadista SA', '97546169564125', 'contato@alegriafeliz.com', '(02)0000-0002', 'q.Qz}HK8O$2e'),
('Hiper Estrela da Alegria', 'Hiper Estrela da Alegria SA', '85295968178980', 'contato@estrelafeliz.com', '(01)0000-0003', '3Fd(rbp68V3J'),
('Super Nova Atacado', 'Super Nova Atacadista LTDA', '35693153583303', 'contato@supernovaatacado.com', '(02)0000-0004', 'OLDd;20}1i(y'),
('Mercadão Horizonte do Universo', 'Horizonte Universo Atacadista LTDA', '29249842902523', 'contato@horizonteuniverso.com', '(02)0000-0005', 'K,tO)GyU2Ibh'),
('Super Sol Nascente', 'Super Sol Nascente Comércio de Produtos LTDA', '21557173447325', 'contato@solnascentemercado.com', '(01)0000-0006', '2%SAbK;0[6%c'),
('Rede Tranquilidade da Paz', 'Rede Tranquilidade Distribuição SA', '63007332834213', 'contato@tranquilidadedapaz.com', '(02)0000-0007', 'dim2Y0RE(Z]%'),
('Mercado do Mundo Lua', 'Mundo da Lua Comércio e Serviços LTDA', '32121610869535', 'contato@mundolua.com', '(01)0000-0008', '.kclk33@MaOx');

-- Inserir os dados na tabela sensor
INSERT INTO sensor (nSerie, status_sensor)
VALUES
('1000000001', 'Ativo'),
('1000000002', 'Inativo'),
('1000000003', 'Manutenção'),
('1000000004', 'Ativo'),
('1000000005', 'Ativo'),
('1000000006', 'Inativo'),
('1000000007', 'Manutenção'),
('1000000008', 'Ativo');

-- Inserir os dados na tabela produto
INSERT INTO produto (nome, marca, categoria, tamanho)
VALUES
('Arroz Tipo 1 5kg', 'Tio João', 'Alimentos', 30),
('Feijão Carioca 1kg', 'Camil', 'Alimentos', 20),
('Leite Integral 1L', 'Itambé', 'Bebidas', 22),
('Detergente Líquido 500ml', 'Ypê', 'Limpeza', 18),
('Sabonete 90g', 'Dove', 'Higiene', 10),
('Refrigerante Cola 2L', 'Coca-Cola', 'Bebidas', 32),
('Pão de Forma Integral 500g', 'Wickbold', 'Alimentos', 28),
('Fralda Descartável M 40un', 'Pampers', 'Infantil', 40);

-- Inserir os dados na tabela estoque
INSERT INTO estoque (tamanho, setor, categoria)
VALUES
(1.20, 'Setor A1', 'Alimentos Secos'),
(0.80, 'Setor A2', 'Grãos e Cereais'),
(1.50, 'Setor B1', 'Bebidas'),
(0.60, 'Setor C1', 'Limpeza'),
(0.40, 'Setor C2', 'Higiene Pessoal'),
(1.70, 'Setor B2', 'Refrigerados'),
(1.10, 'Setor A3', 'Padaria e Pães'),
(1.90, 'Setor D1', 'Infantil');


-- Inserir os dados na tabela registro 
INSERT INTO registro (distancia, status_alerta)
VALUES
(0.35, 'Alto'),
(0.80, 'Alto'),
(1.50, 'Moderado'),
(2.20, 'Moderado'),
(3.10, 'Baixo'),
(3.85, 'Baixo'),
(1.90, 'Moderado'),
(0.55, 'Alto');

-- Inserir os dados na tabela lote
INSERT INTO lote (numLote, dtValidade, dtFabricacao, dtEntrada, dtSaida)
VALUES
(101, '2025-12-15', '2025-06-15', '2025-06-20 09:30:00', '2025-08-10 14:00:00'),
(102, '2025-11-30', '2025-05-01', '2025-05-05 10:15:00', '2025-08-25 16:20:00'),
(103, '2026-01-10', '2025-07-01', '2025-07-05 11:45:00', '2025-09-01 15:40:00'),
(104, '2025-09-25', '2025-03-15', '2025-03-20 08:50:00', '2025-06-30 10:10:00'),
(105, '2026-02-05', '2025-08-01', '2025-08-03 13:00:00', '2025-08-28 09:25:00'),
(106, '2025-10-12', '2025-04-01', '2025-04-05 09:10:00', '2025-07-15 12:30:00'),
(107, '2025-12-01', '2025-06-10', '2025-06-12 14:40:00', '2025-08-18 11:50:00'),
(108, '2026-03-20', '2025-09-01', '2025-09-05 10:20:00', '2025-09-29 17:30:00');


-- Inserir os dados na tabela cliente
INSERT INTO cliente (status_cliente)
VALUES
('Ativo'),
('Inativo'),
('Ativo'),
('Ativo'),
('Ativo'),
('Inativo'),
('Ativo'),
('Ativo');

-- Inserir os dados na tabela pagamento
INSERT INTO pagamento (preco, metodo, quantidadeParcela, dtPagamento, dtVencimento, status_pagamento)
VALUES
(120.50, 'Pix', 1, '2025-08-05', '2025-08-05', 'Pago'),
(89.90, 'Boleto', 1, NULL, '2025-09-10', 'Pendente'),
(250.00, 'Crédito', 3, '2025-08-15', '2025-08-15', 'Pago'),
(45.00, 'Débito', 1, '2025-08-18', '2025-08-18', 'Pago'),
(600.00, 'Crédito', 6, NULL, '2025-09-20', 'Pendente'),
(75.00, 'Pix', 1, '2025-08-22', '2025-08-22', 'Pago'),
(300.00, 'Boleto', 1, NULL, '2025-09-25', 'Inadimplente'),
(150.00, 'Crédito', 2, NULL, '2025-09-30', 'Cancelado');



-- Ocupação e necessidade de reposição do estoque
SELECT CONCAT('Espaço livre: ', distancia, 'm') AS 'Ocupação',
	CASE
		WHEN status_alerta = 'Baixo' THEN 'Repor estoque.'
		ELSE 'Acompanhamento.'
	END AS Planejamento
FROM registro;


-- Exibir o nome e a categoria do produto onde a marca seja Dove
SELECT nome, categoria FROM produto WHERE marca = 'Dove';


--  Mostrar apenas os sensores em manutenção
SELECT id_sensor, nSerie, status_sensor
FROM sensor
WHERE status_sensor = 'Manutenção';


-- Nível de estoque e data do registro
SELECT dtRegistro AS Dia, status_alerta AS 'Nível de Estoque' FROM registro;





