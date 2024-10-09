#meu primeiro naquinho
create schema EC1_CC1M

#usando meu banquinho
USE EC1_CC1M

#Criando a tabele fornecedores
create table if not exists FORNECEDORES(
#NOMEDOATRIBUTO - TIPO - RESTRIÇÃO DE INTEGRIDADE(OPCIONAL
ID_FORNEC INT PRIMARY KEY,
FORNEC_NOME VARCHAR(45) NOT NULL,
FORNEC_RUA VARCHAR(45) NOT NULL,
FORNEC_NUMRUA INT,
FORNEC_BAIRRO VARCHAR(45) NOT NULL,
FORNEC_CIDADE VARCHAR(45) NOT NULL,
FORNEC_ESTADO VARCHAR(45) NOT NULL,
FORNEC_PAIS VARCHAR(30) NOT NULL,
FORNEC_CODPOSTAL VARCHAR(10) NOT NULL,
FORNEC_TELEFONE VARCHAR(15) NOT NULL,
FORNEC_CONTATO TXT NOT NULL
);
#Criando a tabele PRODUTOS
create table if not exists PRODUTOS(
#NOMEDOATRIBUTO - TIPO - RESTRIÇÃO DE INTEGRIDADE(OPCIONAL
ID_PRODUTO INT PRIMARY KEY,
PRODUTO_NOME varchar(45) NOT NULL,
PRODUTO_DESCRICAO TEXT NOT NULL,
PRODUTO_ESPECTEC TEXT NOT NULL,
PRODUTO_QUANT DECIMAL(10,3) NOT NULL,
PRODUTO_PRECOUNIT DECIMAL(10,2) NOT NULL,
PRODUTO_UNIDADEMEDIDA VARCHAR(10) NOT NULL,
PRODUTO_ESTOQ_MIN DECIMAL(10,3) NOT NULL
);
#Criando a tabele FILIAIS
create table if not exists FILIAIS(
#NOMEDOATRIBUTO - TIPO - RESTRIÇÃO DE INTEGRIDADE(OPCIONAL
ID_FILIAIS INT PRIMARY KEY,
FILIAIS_NOME VARCHAR(30) NOT NULL,
FILIAIS_RUA VARCHAR(100) NOT NULL,
FILIAIS_NUMRUA INT,
FILIAIS_BAIRRO VARCHAR(50) NOT NULL,
FILIAIS_CIDADE VARCHAR(50) NOT NULL,
FILIAIS_ESTADO VARCHAR(50) NOT NULL,
FILIAIS_PAI VARCHAR(30) NOT NULL,
FILIAIS_CODPOSTAL VARCHAR(10) NOT NULL,
FILIAIS_CAPACIDADE TEXT NOT NULL
);
#FASE 4: CRIAR AS TABELAS COM DEPENDÊNCIA DE CHAVE ESTRANGEIRA
#CRIANDO A TABELA PEDIDOS
CREATE TABLE IF NOT EXISTS PEDIDOS(
ID_PEDIDOS INT PRIMARY KEY,
PEDIDOS_DATA DATE NOT NULL,
PEDIDOS_HORA TIME NOT NULL,
PEDIDOS_PREVISAO DATE NOT NULL,
PEDIDOS_STATUS ENUM('PENDENTE','CONCLUÍDO','EM ESPERA'),
PEDIDOS_FORNECEDOR INT NOT NULL, #NOSSA CHAE ESTRANGEIRA DE FORNECEDOR
#CRIANDO A REFERENCIA PARA A CHAVE ESTRANGEIRA
#RESTRIÇÃO APELIDO CH. ESTRANGEIRA(CAMPO CRIADO) REFERENCIA TABELA(CH ,PRIMÁRIA)
CONSTRAINT FK_FORNECEDOR foreign key (PED_FORNECEDOR) #DAR NOME A RESTRIÇÃO(CONSTRAINT)
REFERENCES FORNECEDORES(FORNEC_COD) #REFERENCIA A CHAVE PRIMÁRIA DE FORNECEDORES
);
#CRIANDO TABELA RECEBIMENTOS (VEIO DEPOIS TEM DEPENDENCIA DE PEDIDOS)
CREATE TABLE IF NOT EXISTS RECEBIMENTOS(
RECEB_DATA DATE NOT NULL,
RECEB_HORA TIME NOT NULL,
RECEB_QUANT_PROD DECIMAL(10,3)
RECEB_CONDICAO TEXT NOT NULL,
RECEB_PEDIDOS INT PRIMARY KEY,
CONSTRAINT FK_PEDIDOS FOREIGN KEY(RECEB_PEDIDOS) REFERENCE PEDIDOS(ID_PEDIDOS));

#FASE 5: CRIANDO AS TABELAS ASSOCIATIVAS (ENTIDADES ASSOCIATIVAS)
CREATE TABLE IF NOT EXISTS PEDIDO_PRODUTOS(
PDPR_PEDIDOS INT,
PDPR_PRODUTOS INT,
primary key(PEDIDOS,PRODUTOS),
PDPR_QUANT DECIMAL(10,3) NOT NULL,
CONSTRAINT PKFK_PEDIDOS FOREIGN KEY(PDPR_PEDIDOS) REFERENCES PEDIDOS(ID_PEDIDOS),
CONSTRAINT PKFK_PRODUTOS FOREIGN KEY(PDPR_PRODUTOS) REFERENCES PEDIDOS(ID_PRODUTOS)
);