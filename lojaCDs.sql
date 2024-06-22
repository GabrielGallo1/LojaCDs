CREATE DATABASE Db_CDS; 
USE Db_CDS;

-- Tabela Tb_Artista
CREATE TABLE Tb_Artista (
    Cod_Art INT COMMENT 'Código Artista' AUTO_INCREMENT NOT NULL,
    Nome_Art VARCHAR(100) NOT NULL COMMENT 'Nome do Artista ou nome da Banda' UNIQUE,
    CONSTRAINT pk_Cod_Art PRIMARY KEY (Cod_Art)
);

-- Tabela Tb_Gravadora
CREATE TABLE Tb_Gravadora (
    Cod_Grav INT COMMENT 'Código Gravadora' AUTO_INCREMENT NOT NULL,
    Nome_Grav VARCHAR(50) NOT NULL COMMENT 'Nome da Gravadora' UNIQUE,
    CONSTRAINT pk_Cod_Grav PRIMARY KEY (Cod_Grav)
);

-- Tabela Tb_Categoria
CREATE TABLE Tb_Categoria (
    Cod_Cat INT COMMENT 'Código da Categoria' AUTO_INCREMENT NOT NULL,
    Nome_Cat VARCHAR(50) NOT NULL COMMENT 'Nome da Categoria' UNIQUE,
    CONSTRAINT pk_Cod_Cat PRIMARY KEY (Cod_Cat)
);

-- Tabela Tb_Estado
CREATE TABLE Tb_Estado (
    Sigla_Est CHAR(2) COMMENT 'Sigla do Estado' NOT NULL,
    Nome_Est VARCHAR(50) NOT NULL COMMENT 'Nome do Estado' UNIQUE,
    CONSTRAINT pk_Sigla_Est PRIMARY KEY (Sigla_Est)
);

-- Tabela Tb_Cidade
CREATE TABLE Tb_Cidade (
    Cod_Cid INT COMMENT 'Código da Cidade' AUTO_INCREMENT NOT NULL,
    Sigla_Est CHAR(2) NOT NULL COMMENT 'Sigla do Estado',
    Nome_Cid VARCHAR(100) NOT NULL COMMENT 'Nome da cidade',
    CONSTRAINT pk_Cod_Cid PRIMARY KEY (Cod_Cid),
    CONSTRAINT fk_Sigla_Est FOREIGN KEY (Sigla_Est)
        REFERENCES Tb_Estado (Sigla_Est)
);

-- Tabela Tb_Cliente
CREATE TABLE Tb_Cliente (
    Cod_Cli INT COMMENT 'Código do Cliente' AUTO_INCREMENT NOT NULL,
    Cod_Cid INT COMMENT 'Código da Cidade' NOT NULL,
    Nome_Cli VARCHAR(100) NOT NULL COMMENT 'Nome do Cliente',
    End_Cli VARCHAR(200) NOT NULL COMMENT 'Endereço do Cliente',
    Renda_Cli DECIMAL(10,2) COMMENT 'Renda do Cliente' NOT NULL DEFAULT 0.00,
    Sexo_Cli ENUM('M', 'F') COMMENT 'Sexo do Cliente' NOT NULL DEFAULT 'F',
    CONSTRAINT chk_Renda_Cli CHECK (Renda_Cli >= 0),
    CONSTRAINT pk_Cod_Cli PRIMARY KEY (Cod_Cli),
    CONSTRAINT fk_Cod_Cid FOREIGN KEY (Cod_Cid)
        REFERENCES Tb_Cidade (Cod_Cid)
);

-- Tabela Tb_Conjuge
CREATE TABLE Tb_Conjuge (
    Cod_Cli INT COMMENT 'Código do Cliente' NOT NULL,
    Nome_Conj VARCHAR(100) NOT NULL COMMENT 'Nome do Conjugue',
    Renda_Conj DECIMAL(10,2) COMMENT 'Renda do Conjugue' NOT NULL DEFAULT 0.00,
    Sexo_Conj ENUM('M', 'F') COMMENT 'Sexo do Conjugue' NOT NULL DEFAULT 'M',
    CONSTRAINT chk_Renda_Conj CHECK (Renda_Conj >= 0),
    CONSTRAINT pk_Cod_Cli PRIMARY KEY (Cod_Cli),
    CONSTRAINT fk_Cod_Cli FOREIGN KEY (Cod_Cli)
        REFERENCES Tb_Cliente (Cod_Cli)
);

-- Tabela Tb_Funcionario
CREATE TABLE Tb_Funcionario (
    Cod_Func INT COMMENT 'Código do Funcionário' AUTO_INCREMENT NOT NULL,
    Nome_Func VARCHAR(100) NOT NULL COMMENT 'Nome do Funcionário',
    End_Func VARCHAR(200) NOT NULL COMMENT 'Endereço do Funcionário',
    Sal_Func DECIMAL(10,2) COMMENT 'Salário do Funcionário' NOT NULL DEFAULT 0.00,
    Sexo_Func ENUM('M', 'F') COMMENT 'Sexo do Funcionário' NOT NULL DEFAULT 'M',
    CONSTRAINT chk_Sal_Func CHECK (Sal_Func >= 0),
    CONSTRAINT pk_Cod_Func PRIMARY KEY (Cod_Func)
);

-- Tabela Tb_Dependente
CREATE TABLE Tb_Dependente (
    Cod_Dep INT COMMENT 'Código do Dependente' AUTO_INCREMENT NOT NULL,
    Cod_Func INT COMMENT 'Código do Funcionário' NOT NULL,
    Nome_Dep VARCHAR(100) NOT NULL COMMENT 'Nome do Dependente',
    Sexo_Dep ENUM('M', 'F') COMMENT 'Sexo do Dependente' NOT NULL DEFAULT 'M',
    CONSTRAINT pk_Cod_Dep PRIMARY KEY (Cod_Dep),
    CONSTRAINT fk_Cod_Func FOREIGN KEY (Cod_Func)
        REFERENCES Tb_Funcionario (Cod_Func)
);

-- Tabela Tb_Titulo
CREATE TABLE Tb_Titulo (
    Cod_Tit INT COMMENT 'Código do Título' AUTO_INCREMENT NOT NULL,
    Cod_Cat INT COMMENT 'Código da Categoria' NOT NULL,
    Cod_Grav INT COMMENT 'Código da Gravadora' NOT NULL,
    Nome_CD VARCHAR(100) NOT NULL COMMENT 'Nome do CD' UNIQUE,
    Val_CD DECIMAL(10,2) COMMENT 'Valor do CD' NOT NULL,
    Qtd_Estq INT COMMENT 'Quantidade de CD de cada Título em Estoque' NOT NULL,
    CONSTRAINT pk_Cod_Tit PRIMARY KEY (Cod_Tit),
    CONSTRAINT fk_Cod_Cat FOREIGN KEY (Cod_Cat)
        REFERENCES Tb_Categoria (Cod_Cat),
    CONSTRAINT fk_Cod_Grav FOREIGN KEY (Cod_Grav)
        REFERENCES Tb_Gravadora (Cod_Grav),
    CONSTRAINT chk_Val_CD CHECK (Val_CD > 0),
    CONSTRAINT chk_Qtd_Estq CHECK (Qtd_Estq >= 0)
);

-- Tabela Tb_Pedido
CREATE TABLE Tb_Pedido (
    Num_Ped INT COMMENT 'Código do Pedido' AUTO_INCREMENT NOT NULL,
    Cod_Cli INT COMMENT 'Código do Cliente' NOT NULL,
    Cod_Func INT COMMENT 'Código do Funcionário' NOT NULL,
    Data_Ped DATETIME NOT NULL COMMENT 'Data do Pedido',
    Val_Ped DECIMAL(10,2) COMMENT 'Valor do Pedido' NOT NULL DEFAULT 0,
    CONSTRAINT pk_Num_Ped PRIMARY KEY (Num_Ped),
    CONSTRAINT fk_Cod_Cli FOREIGN KEY (Cod_Cli)
        REFERENCES Tb_Cliente (Cod_Cli),
    CONSTRAINT fk_Cod_Func FOREIGN KEY (Cod_Func)
        REFERENCES Tb_Funcionario (Cod_Func),
    CONSTRAINT chk_Val_Ped CHECK (Val_Ped >= 0)
);

-- Tabela Tb_Titulo_Pedido
CREATE TABLE Tb_Titulo_Pedido (
    Num_Ped INT COMMENT 'Código do Pedido' NOT NULL,
    Cod_Tit INT COMMENT 'Código do Título' NOT NULL,
    Qtd_Estq INT COMMENT 'Quantidade de CD de cada Título em Estoque' NOT NULL,
    Val_CD DECIMAL(10,2) COMMENT 'Valor do CD' NOT NULL DEFAULT 0,
    CONSTRAINT pk_Titulo_Pedido PRIMARY KEY (Num_Ped, Cod_Tit),
    CONSTRAINT fk_Num_Ped FOREIGN KEY (Num_Ped)
        REFERENCES Tb_Pedido (Num_Ped),
    CONSTRAINT fk_Cod_Tit FOREIGN KEY (Cod_Tit)
        REFERENCES Tb_Titulo (Cod_Tit),
    CONSTRAINT chk_Qtd_Estq CHECK (Qtd_Estq >= 1),
    CONSTRAINT chk_Val_CD CHECK (Val_CD > 0)
);

-- Tabela Tb_Titulo_Artista
CREATE TABLE Tb_Titulo_Artista (
    Cod_Tit INT COMMENT 'Código do Título' NOT NULL,
    Cod_Art INT COMMENT 'Código do Artista' NOT NULL,
    CONSTRAINT pk_Titulo_Artista PRIMARY KEY (Cod_Tit, Cod_Art),
    CONSTRAINT fk_Cod_Tit FOREIGN KEY (Cod_Tit)
        REFERENCES Tb_Titulo (Cod_Tit),
    CONSTRAINT fk_Cod_Art FOREIGN KEY (Cod_Art)
        REFERENCES Tb_Artista (Cod_Art)
);
