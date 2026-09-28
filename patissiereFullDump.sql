CREATE TABLE pessoa (
    idPessoa INT AUTO_INCREMENT PRIMARY KEY,    -- chave primaria com incremento automático
    nome VARCHAR(45) NOT NULL,                  -- nome, obrigatório
    cpf CHAR(11) NOT NULL UNIQUE               -- CPF único, obrigatório
);

-- Cliente (1:1 com pessoa)
CREATE TABLE cliente (
    idPessoa INT PRIMARY KEY,                   -- herda idPessoa
    FOREIGN KEY (idPessoa) REFERENCES pessoa(idPessoa)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Funcionário (1:1 com pessoa)
CREATE TABLE funcionario (
    idPessoa INT PRIMARY KEY,                   -- herda idPessoa
    dataAdmissao DATE,                          -- data de admissão
    FOREIGN KEY (idPessoa) REFERENCES pessoa(idPessoa)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Atendente (1:1 com funcionário)
CREATE TABLE atendente (
    idFuncionario INT PRIMARY KEY,             
    FOREIGN KEY (idFuncionario) REFERENCES funcionario(idPessoa)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Confeiteiro (1:1 com funcionário)
CREATE TABLE confeiteiro (
    idFuncionario INT PRIMARY KEY,
    FOREIGN KEY (idFuncionario) REFERENCES funcionario(idPessoa)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Pedido (1:N cliente, 1:N atendente)
CREATE TABLE pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    idAtendente INT NOT NULL,
    dataHoraEntrada DATETIME NOT NULL,
    observacao VARCHAR(255),
    FOREIGN KEY (idCliente) REFERENCES cliente(idPessoa)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idAtendente) REFERENCES atendente(idFuncionario)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Comanda (1:1 pedido, N:1 confeiteiro)
CREATE TABLE comanda (
    idComanda INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL UNIQUE,
    idConfeiteiro INT NOT NULL,
    dataAbertura DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    alteracaoDaReceita VARCHAR(255),
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idConfeiteiro) REFERENCES confeiteiro(idFuncionario)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Pagamento (1:1 comanda)
CREATE TABLE pagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idComanda INT NOT NULL UNIQUE,
    valor DECIMAL(6,2) NOT NULL,
    formaPagamento ENUM('Dinheiro','Cartao','Pix') NOT NULL,
    dataPagamento DATETIME,
    FOREIGN KEY (idComanda) REFERENCES comanda(idComanda)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- Entrega (1:1 pedido, 1:N cliente)
CREATE TABLE entrega (
    idEntrega INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL UNIQUE,
    idCliente INT NOT NULL,
    statusEntrega ENUM('Pendente','Concluida') DEFAULT 'Pendente',
    dataPrevista DATETIME NULL,
    dataConcluida DATETIME NULL,
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idCliente) REFERENCES cliente(idPessoa)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Peso (N:1 bolo)
CREATE TABLE peso (
    idPeso INT PRIMARY KEY,
    gramas FLOAT NOT NULL
);

-- Massa (N:1 bolo)
CREATE TABLE massa (
    idMassa INT PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);

-- Recheio (N:1 bolo)
CREATE TABLE recheio (
    idRecheio INT PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);

-- Cobertura (N:1 bolo)
CREATE TABLE cobertura (
    idCobertura INT PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);

-- Decoracao (N:1 bolo)
CREATE TABLE decoracao (
    idDecoracao INT PRIMARY KEY,
    descricao VARCHAR(50) NOT NULL
);

-- Bolo (1:N pedido, 1:N confeiteiro)
CREATE TABLE bolo (
    idBolo INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    idConfeiteiro INT NOT NULL,
    idPeso INT NOT NULL,
    idMassa INT NOT NULL,
    idRecheio INT NOT NULL,
    idCobertura INT NOT NULL,
    idDecoracao INT NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (idConfeiteiro) REFERENCES confeiteiro(idFuncionario)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idPeso) REFERENCES peso(idPeso)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idMassa) REFERENCES massa(idMassa)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idRecheio) REFERENCES recheio(idRecheio)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idCobertura) REFERENCES cobertura(idCobertura)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (idDecoracao) REFERENCES decoracao(idDecoracao)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- =============================== pessoas ======================================

INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('1', 'Amparo', '62449326482');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('2', 'Ryley', '95573619566');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('3', 'Brayan', '89734054729');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('4', 'Leonora', '58772552525');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('5', 'Casimir', '60504556982');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('6', 'Dexter', '41210299846');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('7', 'Maryjane', '97733589773');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('8', 'Darron', '31420490914');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('9', 'Granville', '91490923590');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('10', 'Greyson', '77311299298');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('11', 'Percival', '33834765153');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('12', 'Arturo', '33855795813');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('13', 'Lupe', '85323675908');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('14', 'Adelia', '96857768273');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('15', 'Rosa', '7232830114');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('16', 'Bell', '16930192476');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('17', 'Camilla', '6557616661');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('18', 'Fannie', '29561584116');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('19', 'Cordia', '5041831545');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('20', 'Ewell', '13696365850');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('21', 'Jakayla', '60572417732');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('22', 'Faye', '57644609129');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('23', 'Deron', '38542681536');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('24', 'Zackary', '63914315192');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('25', 'Isabel', '19037521583');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('26', 'Reggie', '60581672191');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('27', 'Kennedy', '95838965079');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('28', 'Felix', '48852069140');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('29', 'Samson', '68665848160');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('30', 'Trace', '32792050484');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('31', 'Darrick', '85113637847');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('32', 'Sallie', '85280458210');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('33', 'Ahmed', '79084293497');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('34', 'Leonie', '80335186701');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('35', 'Ron', '28368156286');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('36', 'Gracie', '91911561135');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('37', 'George', '88099300209');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('38', 'Aron', '14776628185');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('39', 'Porter', '88556603412');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('40', 'Winifred', '20846941298');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('41', 'Regan', '19956011464');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('42', 'Haylie', '37295319745');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('43', 'Kattie', '6121523375');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('44', 'Velva', '3996168589');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('45', 'Charlotte', '88252983544');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('46', 'Evan', '54138028272');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('47', 'Mathias', '41830861731');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('48', 'Suzanne', '50344913103');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('49', 'Sasha', '41020695213');
INSERT INTO pessoa (idPessoa, nome, cpf) VALUES ('50', 'Meghan', '13180126110');

-- ================================ clientes =====================================

INSERT INTO cliente (idPessoa) VALUES (11);
INSERT INTO cliente (idPessoa) VALUES (12);
INSERT INTO cliente (idPessoa) VALUES (13);
INSERT INTO cliente (idPessoa) VALUES (14);
INSERT INTO cliente (idPessoa) VALUES (15);
INSERT INTO cliente (idPessoa) VALUES (16);
INSERT INTO cliente (idPessoa) VALUES (17);
INSERT INTO cliente (idPessoa) VALUES (18);
INSERT INTO cliente (idPessoa) VALUES (19);
INSERT INTO cliente (idPessoa) VALUES (20);
INSERT INTO cliente (idPessoa) VALUES (21);
INSERT INTO cliente (idPessoa) VALUES (22);
INSERT INTO cliente (idPessoa) VALUES (23);
INSERT INTO cliente (idPessoa) VALUES (24);
INSERT INTO cliente (idPessoa) VALUES (25);
INSERT INTO cliente (idPessoa) VALUES (26);
INSERT INTO cliente (idPessoa) VALUES (27);
INSERT INTO cliente (idPessoa) VALUES (28);
INSERT INTO cliente (idPessoa) VALUES (29);
INSERT INTO cliente (idPessoa) VALUES (30);
INSERT INTO cliente (idPessoa) VALUES (31);
INSERT INTO cliente (idPessoa) VALUES (32);
INSERT INTO cliente (idPessoa) VALUES (33);
INSERT INTO cliente (idPessoa) VALUES (34);
INSERT INTO cliente (idPessoa) VALUES (35);
INSERT INTO cliente (idPessoa) VALUES (36);
INSERT INTO cliente (idPessoa) VALUES (37);
INSERT INTO cliente (idPessoa) VALUES (38);
INSERT INTO cliente (idPessoa) VALUES (39);
INSERT INTO cliente (idPessoa) VALUES (40);
INSERT INTO cliente (idPessoa) VALUES (41);
INSERT INTO cliente (idPessoa) VALUES (42);
INSERT INTO cliente (idPessoa) VALUES (43);
INSERT INTO cliente (idPessoa) VALUES (44);
INSERT INTO cliente (idPessoa) VALUES (45);
INSERT INTO cliente (idPessoa) VALUES (46);
INSERT INTO cliente (idPessoa) VALUES (47);
INSERT INTO cliente (idPessoa) VALUES (48);
INSERT INTO cliente (idPessoa) VALUES (49);
INSERT INTO cliente (idPessoa) VALUES (50);

-- =============================== funcionarios ===============================

INSERT INTO funcionario (idPessoa, dataAdmissao) VALUES ('1', '2023-07-04');
INSERT INTO funcionario (idPessoa, dataAdmissao) VALUES ('2', '2023-07-19');
INSERT INTO funcionario (idPessoa, dataAdmissao) VALUES ('3', '2023-11-24');
INSERT INTO funcionario (idPessoa, dataAdmissao) VALUES ('4', '2024-07-04');
INSERT INTO funcionario (idPessoa, dataAdmissao) VALUES ('5', '2024-08-09');
INSERT INTO funcionario (idPessoa, dataAdmissao) VALUES ('6', '2024-06-26');
INSERT INTO funcionario (idPessoa, dataAdmissao) VALUES ('7', '2025-06-26');
INSERT INTO funcionario (idPessoa, dataAdmissao) VALUES ('8', '2025-01-02');
INSERT INTO funcionario (idPessoa, dataAdmissao) VALUES ('9', '2025-05-08');
INSERT INTO funcionario (idPessoa, dataAdmissao) VALUES ('10', '2025-09-07');

-- =========================== confeiteiro, atendente =========================

INSERT INTO confeiteiro (idFuncionario) VALUES ('1');
INSERT INTO confeiteiro (idFuncionario) VALUES ('2');
INSERT INTO confeiteiro (idFuncionario) VALUES ('3');
INSERT INTO confeiteiro (idFuncionario) VALUES ('4');
INSERT INTO confeiteiro (idFuncionario) VALUES ('5');

INSERT INTO atendente (idFuncionario) VALUES ('6');
INSERT INTO atendente (idFuncionario) VALUES ('7');
INSERT INTO atendente (idFuncionario) VALUES ('8');
INSERT INTO atendente (idFuncionario) VALUES ('9');
INSERT INTO atendente (idFuncionario) VALUES ('10');

-- ====================== pedidos ===========================================

INSERT INTO pedido (idCliente, idAtendente, dataHoraEntrada, observacao) VALUES
(11, 6, '2025-10-01 09:12:00', 'Pedido normal'),
(12, 7, '2025-10-01 10:45:00', 'Pedido normal'),
(13, 8, '2025-10-01 11:20:00', 'Pedido urgente'),
(14, 9, '2025-10-01 12:05:00', 'Pedido normal'),
(15, 10, '2025-10-01 13:40:00', 'Pedido alterado'),

(11, 7, '2025-10-02 09:15:00', 'Pedido normal'),
(16, 8, '2025-10-02 10:22:00', 'Pedido urgente'),
(17, 9, '2025-10-02 11:30:00', 'Pedido normal'),
(18, 10, '2025-10-02 12:00:00', 'Pedido alterado'),
(19, 6, '2025-10-02 14:25:00', 'Pedido normal'),

(20, 6, '2025-10-03 08:30:00', 'Pedido normal'),
(21, 7, '2025-10-03 09:50:00', 'Pedido alterado'),
(22, 8, '2025-10-03 10:10:00', 'Pedido normal'),
(23, 9, '2025-10-03 11:55:00', 'Pedido urgente'),
(24, 10, '2025-10-03 13:05:00', 'Pedido normal'),

(25, 6, '2025-10-04 09:00:00', 'Pedido normal'),
(26, 7, '2025-10-04 10:20:00', 'Pedido normal'),
(12, 8, '2025-10-04 11:15:00', 'Pedido alterado'),
(13, 9, '2025-10-04 12:30:00', 'Pedido normal'),
(27, 10, '2025-10-04 14:00:00', 'Pedido urgente');

-- ======================= comanda ==========================================

INSERT INTO comanda (idPedido, idConfeiteiro, dataAbertura, alteracaoDaReceita) VALUES
(1,  2, '2025-10-01 09:20:00', NULL),            
(2,  4, '2025-10-01 10:55:00', NULL),             
(3,  1, '2025-10-01 11:25:00', NULL),               
(4,  3, '2025-10-01 12:15:00', NULL),              
(5,  5, '2025-10-01 13:50:00', 'Sem morango'),      

(6,  1, '2025-10-02 09:25:00', NULL),               
(7,  2, '2025-10-02 10:35:00', NULL),               
(8,  3, '2025-10-02 11:40:00', NULL),              
(9,  4, '2025-10-02 12:10:00', 'Bolo resfriado'),   
(10, 5, '2025-10-02 14:35:00', NULL),               

(11, 2, '2025-10-03 08:40:00', NULL),               
(12, 4, '2025-10-03 09:55:00', 'Sem cobertura'),    
(13, 1, '2025-10-03 10:25:00', NULL),              
(14, 3, '2025-10-03 12:00:00', NULL),               
(15, 5, '2025-10-03 13:15:00', NULL),               

(16, 1, '2025-10-04 09:10:00', NULL),               
(17, 2, '2025-10-04 10:25:00', NULL),               
(18, 3, '2025-10-04 11:25:00', 'menos recheio'),    
(19, 4, '2025-10-04 12:40:00', NULL),               
(20, 5, '2025-10-04 14:10:00', NULL);               

-- ================== pagamento ====================================

INSERT INTO pagamento (idComanda, valor, formaPagamento, dataPagamento) VALUES
(1,  85.00, 'Pix',      '2025-10-01 10:00:00'),
(2,  72.50, 'Dinheiro', '2025-10-01 11:10:00'),
(3, 120.00, 'Cartao',   '2025-10-01 11:45:00'),
(4,  60.00, 'Pix',      '2025-10-01 12:40:00'),
(5, 150.00, 'Cartao',   '2025-10-01 14:10:00'),

(6,  95.00, 'Pix',      '2025-10-02 09:45:00'),
(7, 110.00, 'Dinheiro', '2025-10-02 10:55:00'),
(8,  65.00, 'Cartao',   '2025-10-02 11:55:00'),
(9,  78.00, 'Pix',      '2025-10-02 12:30:00'),
(10, 55.00, 'Cartao',   '2025-10-02 15:00:00'),

(11, 80.00, 'Pix',      '2025-10-03 09:00:00'),
(12, 140.00, 'Dinheiro','2025-10-03 10:10:00'),
(13, 90.00, 'Cartao',   '2025-10-03 10:40:00'),
(14, 130.00, 'Pix',     '2025-10-03 12:20:00'),
(15, 70.00, 'Cartao',   '2025-10-03 13:40:00'),

(16, 60.00, 'Pix',      '2025-10-04 09:30:00'),
(17, 75.00, 'Cartao',   '2025-10-04 10:40:00'),
(18, 125.00, 'Pix',     '2025-10-04 11:50:00'),
(19, 90.00, 'Dinheiro', '2025-10-04 12:55:00'),
(20, 160.00, 'Cartao',  '2025-10-04 14:40:00');

-- ====================== entrega ====================================

INSERT INTO entrega (idPedido, idCliente, statusEntrega, dataPrevista, dataConcluida) VALUES
(1,  11, 'Concluida', '2025-10-02 09:00:00', '2025-10-02 10:00:00'),
(2,  12, 'Concluida', '2025-10-02 11:00:00', '2025-10-02 12:10:00'),
(3,  13, 'Pendente',  '2025-10-02 12:00:00', NULL),
(4,  14, 'Concluida', '2025-10-02 13:00:00', '2025-10-02 14:15:00'),
(5,  15, 'Concluida', '2025-10-02 15:00:00', '2025-10-02 16:10:00'),

(6,  11, 'Concluida', '2025-10-03 09:00:00', '2025-10-03 10:05:00'),
(7,  16, 'Pendente',  '2025-10-03 11:00:00', NULL),
(8,  17, 'Concluida', '2025-10-03 12:00:00', '2025-10-03 13:10:00'),
(9,  18, 'Concluida', '2025-10-03 13:00:00', '2025-10-03 14:00:00'),
(10, 19, 'Pendente',  '2025-10-03 15:00:00', NULL),

(11, 20, 'Concluida', '2025-10-04 08:00:00', '2025-10-04 09:00:00'),
(12, 21, 'Concluida', '2025-10-04 10:00:00', '2025-10-04 11:15:00'),
(13, 22, 'Pendente',  '2025-10-04 12:00:00', NULL),
(14, 23, 'Concluida', '2025-10-04 13:00:00', '2025-10-04 14:05:00'),
(15, 24, 'Concluida', '2025-10-04 14:00:00', '2025-10-04 15:10:00'),

(16, 25, 'Pendente',  '2025-10-05 09:00:00', NULL),
(17, 26, 'Concluida', '2025-10-05 10:00:00', '2025-10-05 11:00:00'),
(18, 12, 'Concluida', '2025-10-05 11:00:00', '2025-10-05 12:10:00'),
(19, 13, 'Concluida', '2025-10-05 13:00:00', '2025-10-05 14:00:00'),
(20, 27, 'Pendente',  '2025-10-05 14:00:00', NULL);

-- ===================== caracteristicas do bolo =====================
-- Massas
INSERT INTO massa (idMassa, descricao) VALUES
(1, 'Massa de Baunilha'),
(2, 'Massa de Chocolate'),
(3, 'Massa de Red Velvet'),
(4, 'Massa de Cenoura'),
(5, 'Massa de Limão');

-- Recheios
INSERT INTO recheio (idRecheio, descricao) VALUES
(1, 'Brigadeiro'),
(2, 'Doce de Leite'),
(3, 'Frutas Vermelhas'),
(4, 'Ninho com Nutella'),
(5, 'Prestígio');

-- Coberturas
INSERT INTO cobertura (idCobertura, descricao) VALUES
(1, 'Ganache de Chocolate'),
(2, 'Buttercream'),
(3, 'Chantilly'),
(4, 'Glacê Real'),
(5, 'Cobertura de Morango');

-- Decorações
INSERT INTO decoracao (idDecoracao, descricao) VALUES
(1, 'Flores Naturais'),
(2, 'Decoração Geométrica'),
(3, 'Tema Infantil'),
(4, 'Decoração Clássica'),
(5, 'Arte Moderna');

-- Pesos
INSERT INTO peso (idPeso, gramas) VALUES
(1, 1000.0),   -- 1kg
(2, 1500.0),   -- 1.5kg
(3, 2000.0),   -- 2kg
(4, 2500.0),   -- 2.5kg
(5, 3000.0);   -- 3kg

-- ===================== bolos =====================
INSERT INTO bolo (
    idPedido, 
    idConfeiteiro, 
    idPeso, 
    idMassa, 
    idRecheio, 
    idCobertura, 
    idDecoracao
) VALUES
-- Pedido 1 tem 3 bolos 
(1, 2, 1, 1, 1, 1, 1),
(1, 2, 2, 2, 2, 2, 2),
(1, 2, 3, 3, 3, 3, 3),

-- Pedido 2 tem 1 bolo
(2, 4, 4, 4, 4, 4, 4),

-- Pedido 3 tem 2 bolos
(3, 1, 5, 5, 5, 5, 5),
(3, 1, 1, 1, 2, 3, 4),

-- Pedido 4 tem 2 bolos
(4, 3, 2, 2, 3, 4, 5),
(4, 3, 3, 3, 4, 5, 1),

-- Pedido 5 tem 3 bolos 
(5, 5, 4, 4, 5, 1, 2),
(5, 5, 5, 5, 1, 2, 3),
(5, 5, 1, 1, 2, 3, 4),

-- Pedido 6 tem 1 bolo
(6, 1, 2, 2, 3, 4, 5),

-- Pedido 7 tem 2 bolos
(7, 2, 3, 3, 4, 5, 1),
(7, 2, 4, 4, 5, 1, 2),

-- Pedido 8 tem 1 bolo
(8, 3, 5, 5, 1, 2, 3),

-- Pedido 9 tem 2 bolos
(9, 4, 1, 1, 2, 3, 4),
(9, 4, 2, 2, 3, 4, 5),

-- Pedido 10 tem 1 bolo
(10, 5, 3, 3, 4, 5, 1),

-- Pedido 11 tem 2 bolos
(11, 2, 4, 4, 5, 1, 2),
(11, 2, 5, 5, 1, 2, 3),

-- Pedido 12 tem 1 bolo
(12, 4, 1, 1, 2, 3, 4),

-- Pedido 13 tem 1 bolo
(13, 1, 2, 2, 3, 4, 5),

-- Pedido 14 tem 2 bolos
(14, 3, 3, 3, 4, 5, 1),
(14, 3, 4, 4, 5, 1, 2),

-- Pedido 15 tem 1 bolo
(15, 5, 5, 5, 1, 2, 3),

-- Pedido 16 tem 1 bolo
(16, 1, 1, 1, 2, 3, 4),

-- Pedido 17 tem 1 bolo
(17, 2, 2, 2, 3, 4, 5),

-- Pedido 18 tem 1 bolo
(18, 3, 3, 3, 4, 5, 1),

-- Pedido 19 tem 1 bolo
(19, 4, 4, 4, 5, 1, 2),

-- Pedido 20 tem 1 bolo
(20, 5, 5, 5, 1, 2, 3);

-- 10 queries propostas pelo professor:

-- 1 Listar os Pedidos que estão abertos e que foram registrados há mais de X horas (tempo limite), mostrando o nome do Cliente e a data/hora da entrada do pedido.
select pes.nome,p.dataHoraEntrada from pessoa as pes
inner join cliente as c on c.idPessoa = pes.idPessoa 
inner join pedido as p on p.idCliente = c.idPessoa
where p.dataHoraEntrada < now() - interval 1 day;

-- 2 Qual é o tipo de Recheio mais vendido (contando a quantidade de bolos que o utilizam) nos últimos 3 meses, e qual a Receita (descrição) desse Recheio?
select r.descricao,count(b.idRecheio) as qtdRecheio from bolo as b
inner join recheio as r on r.idRecheio = b.idRecheio
inner join pedido as p on p.idPedido = b.idPedido
where p.dataHoraEntrada >= now() - interval 3 month group by r.idRecheio order by qtdRecheio desc limit 1;

-- 3 Listar o total de Bolos feitos e a soma do valor total dos pedidos associados para cada Confeiteiro no último mês.
select b.idConfeiteiro,count(b.idBolo) as qtdBolo,sum(pa.valor) as totalValor from bolo as b
inner join pedido as p on p.idPedido = b.idPedido
inner join comanda as co on co.idPedido = p.idPedido
inner join pagamento as pa on pa.idComanda = co.idComanda 
where p.dataHoraEntrada >= now() - interval 1 month
group by b.idConfeiteiro order by totalValor desc;

-- 4 Para um Atendente específico, quantos Pedidos ele registrou por dia da semana no último mês, e qual o valor médio desses pedidos?
select p.idAtendente,dayofweek(p.dataHoraEntrada) as dia,avg(pa.valor) as valorMedio,count(*) as qtdPedido from pedido as p
inner join comanda as co on co.idPedido = p.idPedido
inner join pagamento as pa on pa.idComanda = co.idComanda
where p.idAtendente = 6 and p.dataHoraEntrada >= now() - interval 1 month
group by dia order by dia;

-- 5 Quais Pedidos contêm mais de um Bolo e tiveram o Pagamento com a forma 'Cartão', listando o Nome do Cliente?
select p.idPedido,pes.nome,pa.formaPagamento,count(b.idBolo) as qtdBolos from pessoa as pes
inner join cliente as c on c.idPessoa = pes.idPessoa
inner join pedido as p on p.idCliente = c.idPessoa
inner join comanda as co on co.idPedido = p.idPedido
inner join pagamento as pa on pa.idComanda = co.idComanda
inner join bolo as b on b.idPedido = p.idPedido
where pa.formaPagamento = 'Cartao' group by pes.nome,p.idPedido having count(b.idBolo) > 1;

-- 6 Dado um ID de Pedido, qual é a data de abertura da Comanda correspondente e qual o Nome do Confeiteiro responsável por essa comanda?
SELECT p.idPedido,c.dataAbertura,pes.nome AS nomeConfeiteiro
FROM comanda AS c
JOIN confeiteiro AS cf ON c.idConfeiteiro = cf.idFuncionario
JOIN funcionario AS f ON cf.idFuncionario = f.idPessoa
JOIN pessoa AS pes ON f.idPessoa = pes.idPessoa
JOIN pedido AS p ON c.idPedido = p.idPedido
WHERE p.idPedido = 3;

-- 7 Listar os Clientes que realizaram mais de X pedidos no ano e cujo valor total acumulado de compras ultrapassa um limite Y.
SELECT cli.idPessoa,p.nome, COUNT(pe.idPedido) AS total_pedidos, SUM(pg.valor) AS total_gasto
FROM cliente AS cli
INNER JOIN pessoa AS p ON p.idPessoa = cli.idPessoa
INNER JOIN pedido AS pe ON pe.idCliente = cli.idPessoa
INNER JOIN comanda AS c ON c.idPedido = pe.idPedido
INNER JOIN pagamento AS pg ON pg.idComanda = c.idComanda
WHERE YEAR(pe.dataHoraEntrada) = 2025
GROUP BY cli.idPessoa, p.nome
HAVING COUNT(pe.idPedido) > 1
AND SUM(pg.valor) > 100;

-- 8 Quais Comandas foram abertas há mais de X horas, mas ainda não possuem um registro correspondente na tabela Pagamento com o status 'Concluído'?
SELECT c.idComanda,c.dataAbertura
FROM comanda AS c
LEFT JOIN pagamento AS pg ON pg.idComanda = c.idComanda
WHERE c.dataAbertura <= NOW() - INTERVAL 5 HOUR
AND (pg.dataPagamento IS NULL);

-- 9 Listar a contagem de Bolos que usam uma Massa específica (e.g., "Massa de Baunilha") agrupada por Cobertura diferente (e.g., "Ganache", "Chantilly") nos últimos 6 meses.
SELECT b.idBolo,m.descricao AS massa,c.descricao AS cobertura,p.dataHoraEntrada AS dataPedido
FROM bolo AS b
INNER JOIN massa AS m ON m.idMassa = b.idMassa
INNER JOIN cobertura AS c ON c.idCobertura = b.idCobertura
INNER JOIN pedido AS p ON p.idPedido = b.idPedido
WHERE m.descricao = 'Massa de Baunilha'
AND p.dataHoraEntrada >= NOW() - INTERVAL 6 MONTH;

-- 10 Dada uma Descrição de Massa e uma Descrição de Recheio, quantos Bolos distintos as usaram em conjunto?
select b.idBolo,m.descricao as massaDoBolo,re.descricao as recheioDoBolo from bolo as b
inner join massa as m on m.idMassa = b.idMassa
inner join recheio as re on re.idRecheio = b.idRecheio
WHERE m.descricao = 'Massa de Chocolate'
AND re.descricao = 'Doce de Leite'
order by b.idBolo;

-- [BOLOS COMPLETO]
select b.idBolo,m.descricao as massaDoBolo,re.descricao as recheioDoBolo,
co.descricao as coberturaDoBolo,de.descricao as decoracaoDoBolo,p.gramas from bolo as b
inner join massa as m on m.idMassa = b.idMassa
inner join recheio as re on re.idRecheio = b.idRecheio
inner join cobertura as co on co.idCobertura = b.idCobertura
inner join decoracao as de on de.idDecoracao = b.idDecoracao
inner join peso as p on p.idPeso = b.idPeso
order by b.idBolo;

-- queries com join:

-- 1. consulta dos nomes de todos os clientes:
select p.nome as nomeCliente, c.idPessoa from pessoa as p 
inner join cliente as c where c.idPessoa = p.idPessoa
order by c.idPessoa;

-- 2. todos nomes dos funcionarios e data de adimissão:
select f.idPessoa, p.nome as nomeFuncionario, f.dataAdmissao from pessoa as p
inner join funcionario as f on f.idPessoa = p.idPessoa
order by f.idPessoa;

-- 3. nome dos funcionarios que são confeiteiros:
select p.nome as nomeConfeiteiro, con.idFuncionario from pessoa as p
inner join funcionario as f on f.idPessoa = p.idPessoa
inner join confeiteiro as con on con.idFuncionario = f.idPessoa;

-- 4. todas as entregas pendentes com nome do cliente, data prevista e id do pedido:
select p.nome,en.idPedido,en.statusEntrega,en.dataPrevista from pessoa as p
inner join cliente as c on c.idPessoa = p.idPessoa
inner join entrega as en on en.idCliente = c.idPessoa
where en.statusEntrega = 'Pendente';

-- 5. todos os nomes dos clientes com pedidos listados como Concluido:
select p.nome,en.idPedido,en.statusEntrega,en.dataConcluida from pessoa as p
inner join cliente as c on c.idPessoa = p.idPessoa
inner join entrega as en on en.idCliente = c.idPessoa
where en.statusEntrega = 'Concluida';

-- 6. todos os bolos com: Nome do confeiteiro responsável e a descrição da massa, recheio, cobertura e do peso em gramas:
select p.nome,b.idBolo,ma.descricao as massaDoBolo,re.descricao as recheioDoBolo,
co.descricao as coberturaDoBolo, pe.gramas as pesoEmGramas
from pessoa as p
inner join funcionario as f on f.idPessoa = p.idPessoa
inner join confeiteiro as con on con.idFuncionario = f.idPessoa
inner join bolo as b on b.idConfeiteiro = con.idFuncionario
inner join massa as ma on ma.idMassa = b.idMassa
inner join recheio as re on re.idRecheio = b.idRecheio
inner join cobertura as co on co.idCobertura = b.idCobertura
inner join peso as pe on pe.idPeso = b.idPeso;

-- 7. todos os pagamentos ordenados por: nome do cliente, id da comanda, valor e forma de pagemento:
select p.nome, com.idComanda, pa.valor, pa.formaPagamento from pessoa as p
inner join cliente as c on c.idPessoa = p.idPessoa
inner join pedido as pe on pe.idCliente = c.idPessoa
inner join comanda as com on com.idPedido = pe.idPedido
inner join pagamento as pa on pa.idComanda = com.idComanda
order by pa.valor desc;

-- 8. pedidos que ainda não foram pagos (sem registro na tabela pagamento):
select pe.idPedido from pedido as pe
inner join comanda as com on com.idPedido = pe.idPedido
left join pagamento as pa on pa.idComanda = com.idComanda
where pa.idComanda is null;

-- 9. confeiteiros que nunca receberam uma comanda:
select con.idFuncionario from confeiteiro as con
left join comanda as com on com.idConfeiteiro = con.idFuncionario
where com.idConfeiteiro is null;

-- 10. nomes e quantidade de pedidos dos atendentes com pedidos registrados:
select p.nome,count(pe.idPedido) as qtdPedidos from pessoa as p
inner join funcionario as f on f.idPessoa = p.idPessoa
inner join atendente as ate on ate.idFuncionario = f.idPessoa
inner join pedido as pe on pe.idAtendente = ate.idFuncionario
group by pe.idAtendente;

-- queries com group by e having:

-- 1. quantidade de pedidos por cliente, listando apenas clientes com mais de 1 pedido:
select c.idPessoa,count(pe.idPedido) as qtdPedido from cliente as c
inner join pedido as pe on pe.idCliente = c.idPessoa
group by pe.idCliente having qtdPedido > 1;

-- 2. pedidos agrupados por mês e os meses com mais de 5 pedidos realizados:
select month(pe.dataHoraEntrada) as mesPedido,count(pe.idPedido) qtdPedidos from pedido as pe
group by mesPedido having mesPedido > 5;

-- 3. quantos bolos cada confeiteiro preparou, filtrando apenas os que fizeram mais de 5 bolos:
select con.idFuncionario,count(b.idBolo) as qtdBolo from confeiteiro as con
inner join bolo as b on b.idConfeiteiro = con.idFuncionario
group by con.idFuncionario having qtdBolo > 5;

-- 4. quantidade de pedidos por cliente, com mais de 1 entrega onde entregaStatus é 'Concluida':
select en.idCliente,count(en.statusEntrega like 'Concluido') as qtdPedidos from pedido as p
inner join entrega as en on en.idPedido = p.idPedido
group by en.idCliente having qtdPedidos > 1;

-- 5. Para o recheio de brigadeiro: a quantidade de bolos por confeiteiro, mostrando apenas os confeiteiros que fizeram mais de 1 bolo com brigadeiro.
select b.idConfeiteiro,re.descricao,count(b.idBolo) as qtdBolo from bolo as b
inner join recheio as re on re.idRecheio = b.idRecheio
where re.descricao = 'Brigadeiro'
group by b.idConfeiteiro having qtdBolo > 1

-- subqueries

# Clientes que fizeram pedido com valor acima de 100

SELECT nome 
FROM pessoa 
WHERE idPessoa IN (
    SELECT idCliente 
    FROM pedido AS p
    INNER JOIN comanda AS c ON c.idPedido = p.idPedido
    INNER JOIN pagamento AS pa ON pa.idComanda = c.idComanda
    WHERE pa.valor > 100
);

# Pedidos com mais de 1 bolo

SELECT idPedido 
FROM bolo 
GROUP BY idPedido 
HAVING COUNT(idBolo) > 1;

# Confeiteiros que já fizeram bolo de Chocolate

SELECT nome 
FROM pessoa 
WHERE idPessoa IN (
    SELECT idConfeiteiro 
    FROM bolo 
    WHERE idMassa = 2
);

# Pedidos que ainda não foram pagos

SELECT idPedido 
FROM pedido 
WHERE idPedido NOT IN (
    SELECT idPedido 
    FROM comanda 
    INNER JOIN pagamento ON pagamento.idComanda = comanda.idComanda
);


# Bolos de um confeiteiro específico (idConfeiteiro = 2)

SELECT idBolo 
FROM bolo 
WHERE idConfeiteiro = 2 
AND idPedido IN (
    SELECT idPedido 
    FROM pedido 
    WHERE dataHoraEntrada >= '2025-10-01'
);

-- VIEWS

# Todos os pedidos com valor e cliente

CREATE VIEW vwPedidosDetalhes AS
SELECT p.idPedido, pes.nome AS Cliente, pa.valor, pa.formaPagamento
FROM pedido p
INNER JOIN cliente c ON c.idPessoa = p.idCliente
INNER JOIN pessoa pes ON pes.idPessoa = c.idPessoa
INNER JOIN comanda co ON co.idPedido = p.idPedido
INNER JOIN pagamento pa ON pa.idComanda = co.idComanda;

# Bolos de cada confeiteiro

CREATE VIEW vw_bolos_produzidos AS
SELECT b.idBolo, p.nome AS confeiteiro, b.idPedidovw_bolos_produzidosidBoloconfeiteiro
FROM bolo AS b
INNER JOIN confeiteiro AS c ON c.idFuncionario = b.idConfeiteiro
INNER JOIN funcionario AS f ON f.idPessoa = c.idFuncionario
INNER JOIN pessoa AS p ON p.idPessoa = f.idPessoa;

# Pedidos pendentes de entrega

CREATE VIEW vwPedidosPendentes AS
SELECT p.idPedido, pes.nome AS Cliente, en.dataPrevista
FROM entrega en
INNER JOIN pedido p ON p.idPedido = en.idPedido
INNER JOIN cliente c ON c.idPessoa = en.idCliente
INNER JOIN pessoa pes ON pes.idPessoa = c.idPessoa
WHERE en.statusEntrega = 'Pendente';

# Pedidos pagos por Pix

CREATE VIEW vwPedidosPix AS
SELECT p.idPedido, pes.nome AS Cliente, pa.valor
FROM pagamento pa
INNER JOIN comanda co ON co.idComanda = pa.idComanda
INNER JOIN pedido p ON p.idPedido = co.idPedido
INNER JOIN cliente c ON c.idPessoa = p.idCliente
INNER JOIN pessoa pes ON pes.idPessoa = c.idPessoa
WHERE pa.formaPagamento = 'Pix';

# Bolos de 1kg e 1,5kg

CREATE VIEW vwBolosLeves AS
SELECT b.idBolo, pes.nome AS Confeiteiro, pe.gramas
FROM bolo b
INNER JOIN confeiteiro c ON c.idFuncionario = b.idConfeiteiro
INNER JOIN pessoa pes ON pes.idPessoa = c.idFuncionario
INNER JOIN peso pe ON pe.idPeso = b.idPeso
WHERE pe.gramas IN (1000, 1500);

-- UPDATES 

# Atualizar observação de um pedido

UPDATE pedido
SET observacao = 'Entrega urgente'
WHERE idPedido = 3;

# Alterar valor de pagamento

UPDATE pagamento
SET valor = 130.00
WHERE idComanda = 2;

# Mudar status de entrega

UPDATE entrega
SET statusEntrega = 'Concluida', dataConcluida = NOW()
WHERE idEntrega = 7;

-- DELETE

# Exemplo: Pedido 20 foi cancelado.
DELETE FROM pedido
WHERE idPedido = 20;






