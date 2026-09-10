CREATE TABLE pessoa (

	idPessoa INT AUTO_INCREMENT PRIMARY KEY,    -- chave primaria de pessoa, com incrementação automatica
	nome VARCHAR(45) NOT NULL,                  -- nome seguindo a covenção de 45 caracteres e nao nulo
	cpf CHAR(11) NOT NULL UNIQUE                -- cfp tambem nao nulo e unico
    
);

-- pessoa 1:1 cliente
CREATE TABLE cliente (

	idPessoa INT PRIMARY KEY,                          -- chave primaria de Cliente é o id da tabela pessoa
  
	FOREIGN KEY (idPessoa) REFERENCES pessoa(idPessoa) -- idPessoa tambem é a chave estrangeira
	ON DELETE RESTRICT ON UPDATE CASCADE               -- garante que os dados nao sejam excluidos, e atualiza em cascata(Pessoa muda -> cliente muda -> ...)
    
);

-- pessoa 1:1 funcionario
CREATE TABLE funcionario (

	idPessoa INT PRIMARY KEY,                          -- chave primaria de Cliente é o id da tabela pessoa
	dataAdmissao DATE,                                 -- data de admissão do funcionario
  
	FOREIGN KEY (idPessoa) REFERENCES pessoa(idPessoa) -- assim como cliente, herda a PK idPessoa
	ON DELETE RESTRICT ON UPDATE CASCADE               -- garante que os dados nao sejam excluidos, e atualiza em cascata(Pessoa muda -> cliente muda -> ...)
    
);

 -- funcionario 1:1 atendente
CREATE TABLE atendente (

	idFuncionario INT PRIMARY KEY,                               -- atendente herda idFuncionario
  
	FOREIGN KEY (idFuncionario) REFERENCES funcionario(idPessoa) -- idFubcionario como FK
	ON DELETE RESTRICT ON UPDATE CASCADE                         -- garante que os dados nao sejam excluidos, e atualiza em cascata(Pessoa muda -> cliente muda -> ...)
  
);

 -- funcionario 1:1 confeiteiro
CREATE TABLE confeiteiro (

	idFuncionario INT PRIMARY KEY,                               -- herda idFuncionario
  
	FOREIGN KEY (idFuncionario) REFERENCES funcionario(idPessoa) -- FK de funcionario
	ON DELETE RESTRICT ON UPDATE CASCADE                         -- garante que os dados nao sejam excluidos, e atualiza em cascata(Pessoa muda -> cliente muda -> ...)

);

-- ############################################# --

-- cliente 1:N pedido, atentende 1:N pedido
CREATE TABLE pedido (

	idPedido INT AUTO_INCREMENT PRIMARY KEY,                      -- id com incrementação automatica(todo registro id++)
	idCliente INT NOT NULL,                                       -- identificador de cliente no pedido
	idAtendente INT NOT NULL,                                     -- atendente que registra
	dataHoraEntrada DATETIME NOT NULL,                            -- define fila/ordem de chegada
	observacao VARCHAR(255),                                      -- detalhes do pedido
  
	FOREIGN KEY (idCliente) REFERENCES cliente(idPessoa)          -- FK de cliente
	ON DELETE RESTRICT ON UPDATE CASCADE,                         
	FOREIGN KEY (idAtendente) REFERENCES atendente(idFuncionario) -- FK de atendente
	ON DELETE RESTRICT ON UPDATE CASCADE                          -- garante que os dados nao sejam excluidos, e atualiza em cascata(hierarquica)
    
);

-- pedido 1:1 comanda, confeiteiro 1:N comanda
CREATE TABLE comanda (

	idComanda INT AUTO_INCREMENT PRIMARY KEY,                         -- id com incrementação automatica               
	idPedido INT NOT NULL UNIQUE,                                     -- identificador de pedido, 1 pedido por comanda
	idConfeiteiro INT NOT NULL,                                       -- confeiteiro(s) que RECEBE a comanda
	dataAbertura DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,         -- registra a abertura da comanda, do data/horario atual ao banco
  
	FOREIGN KEY (idPedido) REFERENCES pedido(idPedido)                -- FK do pedido
	ON DELETE CASCADE ON UPDATE CASCADE,                              -- deleta a comanda, caso o pedido for excluido
	FOREIGN KEY (idConfeiteiro) REFERENCES confeiteiro(idFuncionario) -- FK do confeiteiro
	ON DELETE RESTRICT ON UPDATE CASCADE                              -- impede o caso de exluir o confeiteiro antes de alterar suas comandas
    
);

-- comanda 1:1 pagamento
CREATE TABLE pagamento (

	idPagamento INT AUTO_INCREMENT PRIMARY KEY,                    -- id com incrementação automatica
	idComanda INT NOT NULL UNIQUE,                                 -- pagamento vinculado a comanda
	valor DECIMAL(6,2) NOT NULL,                                   -- valor do pagamento
	formaPagamento ENUM('Dinheiro','Cartao','Pix') NOT NULL,       -- forma de pagamento
	dataPagamento DATETIME,                                        -- data do pagamento
  
	FOREIGN KEY (idComanda) REFERENCES comanda(idComanda)          -- FK da comanda
	ON DELETE CASCADE ON UPDATE CASCADE                            -- pagamento nao existe sem comanda
    
);

-- pedido 1:1 entrega, cliente 1:N entrega
CREATE TABLE entrega (

	idEntrega INT AUTO_INCREMENT PRIMARY KEY,                      -- id da entrega como auto increment
	idPedido INT NOT NULL UNIQUE,                                  -- identificador de pedido, um pedido por engtrega 
	idCliente INT NOT NULL,										 -- identificador de cliente, CLIENTE pode ter N entregas				
	statusEntrega ENUM('Pendente','Concluida') DEFAULT 'Pendente', -- status da entrega, setado como pendente por default
	dataPrevista DATETIME NULL,                                    -- data prevista da entrega
	dataConcluida DATETIME NULL,                                   -- data de conclusão
  
	FOREIGN KEY (idPedido) REFERENCES pedido(idPedido)             -- FK de pedido
	ON DELETE CASCADE ON UPDATE CASCADE,                           -- exclui a entrega se o pedido for exluido
	FOREIGN KEY (idCliente) REFERENCES cliente(idPessoa)           -- FK de cliente
	ON DELETE RESTRICT ON UPDATE CASCADE                           -- não pode excluir se houver entrega relacionada
  
);

-- ################################### -- 

-- pedido 1:N bolo, confeiteiro 1:N bolo
CREATE TABLE bolo (

	idBolo INT AUTO_INCREMENT PRIMARY KEY,                            -- id unico para cada bolo, com incrementação automatica
	idPedido INT NOT NULL,                                            -- id do pedido, cada pedido tem N bolos
	idConfeiteiro INT NOT NULL,                                       -- id do confeiteiro, cada confeiteito faz N bolos
    
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido)                -- PK do pedido
    ON DELETE CASCADE ON UPDATE CASCADE,                              -- exclui e atualiza conforme a hierarquia do pedido
    FOREIGN KEY (idConfeiteiro) REFERENCES confeiteiro(idFuncionario) -- PK do confeiteiro
    ON DELETE RESTRICT ON UPDATE CASCADE                              -- garante não é possível excluir um confeiteiro enquanto ele tiver bolos
    
);

-- bolo 1:1 peso
CREATE TABLE peso (

	idBolo INT PRIMARY KEY,                       -- id herdado de bolo 
	gramas FLOAT NOT NULL,                        -- quantidade  kilogramas do bolo
    
	FOREIGN KEY (idBolo) REFERENCES bolo(idBolo)  -- FK do bolo
    ON DELETE CASCADE ON UPDATE CASCADE           -- deleta e atualiza por bolo
    
);

-- bolo 1:1 massa
CREATE TABLE massa (

	idBolo INT PRIMARY KEY,                        -- id herdado de bolo
	descricao VARCHAR(50) NOT NULL,                -- descricao da massa
    
	FOREIGN KEY (idBolo) REFERENCES bolo(idBolo)   -- FK do bolo
    ON DELETE CASCADE ON UPDATE CASCADE            -- deleta e atualiza por bolo
    
);

-- bolo 1:1 recheio
CREATE TABLE recheio (

	idBolo INT PRIMARY KEY,                           -- id herdado de bolo
	descricao VARCHAR(50) NOT NULL,                   -- descricao do recheio
    
	FOREIGN KEY (idBolo) REFERENCES bolo(idBolo)      -- FK de bolo
    ON DELETE CASCADE ON UPDATE CASCADE               -- deleta e atualiza por bolo
    
);

-- bolo 1:1 cobertura
CREATE TABLE cobertura (

	idBolo INT PRIMARY KEY,                         -- id herdado de bolo
	descricao VARCHAR(50) NOT NULL,                 -- descricao da cobertura
    
	FOREIGN KEY (idBolo) REFERENCES bolo(idBolo)    -- FK de bolo
    ON DELETE CASCADE ON UPDATE CASCADE             -- deleta e atualiza por bolo
    
);

-- bolo 1:1 decoracao
CREATE TABLE decoracao (

	idBolo INT PRIMARY KEY,                         -- id herdado de bolo
	descricao VARCHAR(50) NOT NULL,                 -- descriçaõ de decoração
    
	FOREIGN KEY (idBolo) REFERENCES bolo(idBolo)    -- FK de bolo
    ON DELETE CASCADE ON UPDATE CASCADE             -- deleta e atualiza por bolo
    
);