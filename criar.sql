/*TABELA Casa:*/
DROP TABLE IF EXISTS Casa;
CREATE TABLE Casa
(
  idCasa INTEGER,
  endereco TEXT NOT NULL,
  numero INTEGER NOT NULL,
  orientacaoSolar CHAR(2) NOT NULL,
  qtdComodos INTEGER NOT NULL,
  CONSTRAINT Casa_PK PRIMARY KEY (idCasa)
);

/*TABELA Morada:*/
DROP TABLE IF EXISTS Morada;
CREATE TABLE Morada
(
  endereco TEXT,
  numero INTEGER,
  codigoPostal INTEGER NOT NULL,
  nomePais TEXT,
  CONSTRAINT Morada_PK PRIMARY KEY (numero, endereco),
  CONSTRAINT Morada_nomePais_FK1 FOREIGN KEY (nomePais) REFERENCES Pais(nome)
);

/*TABELA Grupo:*/
DROP TABLE IF EXISTS Grupo;
CREATE TABLE Grupo
(
  idGrupo INTEGER,
  nome TEXT NOT NULL,
  qtdDispositivosAssociados INTEGER NOT NULL CHECK (qtdDispositivosAssociados >= 0),
  idCasa INTEGER,
  CONSTRAINT Grupo_PK PRIMARY KEY (idGrupo),
  CONSTRAINT Grupo_idCasa_FK1 FOREIGN KEY (idCasa) REFERENCES Casa(idCasa)
);

/*TABELA GrupoDispositivoWifi:*/
DROP TABLE IF EXISTS GrupoDispositivoWifi;
CREATE TABLE GrupoDispositivoWifi
(
  idGrupo INTEGER,
  idDispositivo INTEGER,
  CONSTRAINT GrupoDispositivoWifi_PK PRIMARY KEY (idGrupo, idDispositivo),
  CONSTRAINT GrupoDispositivoWifi_idGrupo_FK1 FOREIGN KEY (idGrupo) REFERENCES Grupo(idGrupo),
  CONSTRAINT GrupoDispositivoWifi_idDispositivo_FK2 FOREIGN KEY (idDispositivo) REFERENCES DispositivoWifi(idDispositivo)
);

/*TABELA GrupoDispositivoBluetooth:*/
DROP TABLE IF EXISTS GrupoDispositivoBluetooth;
CREATE TABLE GrupoDispositivoBluetooth
(
  idGrupo INTEGER,
  idDispositivo INTEGER,
  CONSTRAINT GrupoDispositivoBluetooth_PK PRIMARY KEY (idGrupo, idDispositivo),
  CONSTRAINT GrupoDispositivoBluetooth_idGrupo_FK1 FOREIGN KEY (idGrupo) REFERENCES Grupo(idGrupo),
  CONSTRAINT GrupoDispositivoBluetooth_idDispositivo_FK2 FOREIGN KEY (idDispositivo) REFERENCES DispositivoBluetooth(idDispositivo)
);

/*TABELA GrupoDispositivoInfravermelho:*/
DROP TABLE IF EXISTS GrupoDispositivoInfravermelho;
CREATE TABLE GrupoDispositivoInfravermelho
(
  idGrupo INTEGER,
  idDispositivo INTEGER,
  CONSTRAINT GrupoDispositivoInfravermelho_PK PRIMARY KEY (idGrupo, idDispositivo),
  CONSTRAINT GrupoDispositivoInfravermelho_idGrupo_FK1 FOREIGN KEY (idGrupo) REFERENCES Grupo(idGrupo),
  CONSTRAINT GrupoDispositivoInfravermelho_idDispositivo_FK2 FOREIGN KEY (idDispositivo) REFERENCES DispositivoInfravermelho(idDispositivo)
);


/*TABELA CasaUtilizador:*/
DROP TABLE IF EXISTS CasaUtilizador;
CREATE TABLE CasaUtilizador
(
  idCasa INTEGER,
  nif INTEGER,
  CONSTRAINT CasaUtilizador_PK PRIMARY KEY (idCasa, nif),
  CONSTRAINT CasaUtilizador_idCasa_FK1 FOREIGN KEY (idCasa) REFERENCES Casa(idCasa),
  CONSTRAINT CasaUtilizador_nif_FK2 FOREIGN KEY (nif) REFERENCES Utilizador(nif)
);

/*TABELA Pais:*/
DROP TABLE IF EXISTS Pais;
CREATE TABLE Pais
(
  nome TEXT,
  CONSTRAINT Pais_PK PRIMARY KEY (nome)
);

/*TABELA Distrito:*/
DROP TABLE IF EXISTS Distrito;
CREATE TABLE Distrito
(
  idDistrito INTEGER,
  nome TEXT NOT NULL,
  nomePais TEXT,
  CONSTRAINT Distrito_PK PRIMARY KEY (idDistrito),
  CONSTRAINT Distrito_nomePais_FK1 FOREIGN KEY (nomePais) REFERENCES Pais(nome)
);

/*TABELA Concelho:*/
DROP TABLE IF EXISTS Concelho;
CREATE TABLE Concelho
(
  idConcelho INTEGER,
  nome TEXT NOT NULL,
  idDistrito INTEGER,
  CONSTRAINT Concelho_PK PRIMARY KEY (idConcelho),
  CONSTRAINT Concelho_idDistrito_FK1 FOREIGN KEY (idDistrito) REFERENCES Distrito(idDistrito)
);

/*TABELA Freguesia:*/
DROP TABLE IF EXISTS Freguesia;
CREATE TABLE Freguesia
(
  idFreguesia INTEGER,
  nome TEXT NOT NULL,
  idConcelho INTEGER,
  CONSTRAINT Freguesia_PK PRIMARY KEY (idFreguesia),
  CONSTRAINT Freguesia_idConcelho_FK1 FOREIGN KEY (idConcelho) REFERENCES Concelho(idConcelho)
);

/*TABELA Utilizador :*/
DROP TABLE IF EXISTS Utilizador;
CREATE TABLE Utilizador
(
  nif INTEGER,
  nome TEXT NOT NULL,
  dob DATE NOT NULL,
  nacionalidade TEXT,
  CONSTRAINT Utilizador_PK PRIMARY KEY (nif),
  CONSTRAINT Utilizador_nacionalidade_FK1 FOREIGN KEY (nacionalidade) REFERENCES Pais(nome)
);


/*TABELA TipoUtilizador:*/
DROP TABLE IF EXISTS TipoUtilizador;
CREATE TABLE TipoUtilizador
(
  nif INTEGER,
  idAplicacao INTEGER,
  principal BOOLEAN DEFAULT 0,
  CONSTRAINT TipoUtilizador_PK PRIMARY KEY (nif, idAplicacao),
  CONSTRAINT TipoUtilizador_nif_FK1 FOREIGN KEY (nif) REFERENCES Utilizador(nif),
  CONSTRAINT TipoUtilizador_idAplicacao_FK2 FOREIGN KEY (idAplicacao) REFERENCES Aplicacao(idAplicacao)
);

/*TABELA Idioma:*/
DROP TABLE IF EXISTS Idioma;
CREATE TABLE Idioma
(
  nome TEXT,
  CONSTRAINT Idioma_PK PRIMARY KEY (nome)
);

/*TABELA Aplicacao:*/
DROP TABLE IF EXISTS Aplicacao;
CREATE TABLE Aplicacao
(
  idAplicacao INTEGER,
  nome TEXT NOT NULL,
  versao TEXT NOT NULL,
  idioma TEXT,
  CONSTRAINT Aplicacao_PK PRIMARY KEY (idAplicacao),
  CONSTRAINT Aplicacao_idioma_FK1 FOREIGN KEY (idioma) REFERENCES Idioma(nome)
);

/*TABELA AssitenteVirtual :*/
DROP TABLE IF EXISTS AssistenteVirtual;
CREATE TABLE AssistenteVirtual
(
  idAssistente INTEGER,
  nome TEXT NOT NULL,
  idioma TEXT,
  qtdDispositivosAssociados INTEGER NOT NULL,
  idCasa INTEGER UNIQUE,
  idModelo INTEGER,
  idAplicacao INTEGER UNIQUE,
  CONSTRAINT AssitenteVirtual_PK PRIMARY KEY (idAssistente),
  CONSTRAINT AssitenteVirtual_idioma_FK1 FOREIGN KEY (idioma) REFERENCES Idioma(nome),
  CONSTRAINT AssitenteVirtual_idCasa_FK2 FOREIGN KEY (idCasa) REFERENCES Casa(idCasa),
  CONSTRAINT AssitenteVirtual_idModelo_FK3 FOREIGN KEY (idModelo) REFERENCES Modelo(idModelo),
  CONSTRAINT AssitenteVirtual_idAplicacao_FK4 FOREIGN KEY (idAplicacao) REFERENCES Aplicacao(idAplicacao)
);

/*TABELA ComandoInfravermelho :*/
DROP TABLE IF EXISTS ComandoInfravermelho;
CREATE TABLE ComandoInfravermelho
(
  idComando INTEGER,
  nome TEXT NOT NULL,
  idModelo INTEGER,
  idAplicacao INTEGER,
  CONSTRAINT ComandoInfravermelho_PK PRIMARY KEY (idComando),
  CONSTRAINT ComandoInfravermelho_idModelo_FK1 FOREIGN KEY (idModelo) REFERENCES Modelo(idModelo),
  CONSTRAINT ComandoInfravermelho_idAplicacao_FK2 FOREIGN KEY (idAplicacao) REFERENCES Aplicacao(idAplicacao)
);

/*TABELA EspecificacoesComandoInfravermelho :*/
DROP TABLE IF EXISTS EspecificacoesComandoInfravermelho;
CREATE TABLE EspecificacoesComandoInfravermelho
(
  nome TEXT,
  idModelo INTEGER,
  alcance FLOAT NOT NULL CHECK (alcance >= 0),
  frequencia FLOAT NOT NULL CHECK (frequencia >= 0),
  CONSTRAINT EspecificacoesComandoInfravermelho_PK PRIMARY KEY (nome, idModelo),
  CONSTRAINT EspecificacoesComandoInfravermelho_idModelo_FK1 FOREIGN KEY (idModelo) REFERENCES Modelo(idModelo)
);

/*TABELA Gatilho :*/
DROP TABLE IF EXISTS Gatilho;
CREATE TABLE Gatilho
(
  idGatilho INTEGER,
  condicao TEXT NOT NULL,
  CONSTRAINT Gatilho_PK PRIMARY KEY (idGatilho)
);

/*TABELA Acao:*/
DROP TABLE IF EXISTS Acao;
CREATE TABLE Acao
(
  nome TEXT,
  CONSTRAINT Acao_PK PRIMARY KEY (nome)
);

/*TABELA GatilhoAcao:*/
DROP TABLE IF EXISTS GatilhoAcao;
CREATE TABLE GatilhoAcao
(
  idGatilho INTEGER,
  nomeAcao TEXT,
  CONSTRAINT GatilhoAcao_PK PRIMARY KEY (idGatilho, nomeAcao),
  CONSTRAINT GatilhoAcao_idGatilho_FK1 FOREIGN KEY (idGatilho) REFERENCES Gatilho(idGatilho),
  CONSTRAINT GatilhoAcao_nomeAcao_FK2 FOREIGN KEY (nomeAcao) REFERENCES Acao(nome)
);

/*TABELA Modelo:*/
DROP TABLE IF EXISTS Modelo;
CREATE TABLE Modelo
(
  idModelo INTEGER,
  nome TEXT NOT NULL,
  idMarca INTEGER,
  CONSTRAINT Modelo_PK PRIMARY KEY (idModelo),
  CONSTRAINT Modelo_idMarca_FK1 FOREIGN KEY (idMarca) REFERENCES Marca(idMarca)
);

/*TABELA Marca:*/
DROP TABLE IF EXISTS Marca;
CREATE TABLE Marca
(
  idMarca INTEGER,
  nome TEXT NOT NULL,
  CONSTRAINT Marca_PK PRIMARY KEY (idMarca)
);

/*TABELA DispositivoBluetoothAcaoAssistente:*/
DROP TABLE IF EXISTS DispositivoBluetoothAcaoAssistente;
CREATE TABLE DispositivoBluetoothAcaoAssistente
(
  idDispositivo INTEGER,
  nomeAcao TEXT,
  idAssistente INTEGER,
  CONSTRAINT DispositivoBluetoothAcaoAssistente_PK PRIMARY KEY (idDispositivo, nomeAcao),
  CONSTRAINT DispositivoBluetoothAcaoAssistente_idDispositivo_FK1 FOREIGN KEY (idDispositivo) REFERENCES DispositivoBluetooth(idDispositivo),
  CONSTRAINT DispositivoBluetoothAcaoAssistente_nomeAcao_FK2 FOREIGN KEY (nomeAcao) REFERENCES Acao(nome),
  CONSTRAINT DispositivoBluetoothAcaoAssistente_idAssistente_FK3 FOREIGN KEY (idAssistente) REFERENCES AssistenteVirtual(idAssistente)
);


/*TABELA DispositivoWiFiAcaoAssistente:*/
DROP TABLE IF EXISTS DispositivoWifiAcaoAssistente;
CREATE TABLE DispositivoWifiAcaoAssistente
(
  idDispositivo INTEGER,
  nomeAcao TEXT,
  idAssistente INTEGER,
  CONSTRAINT DispositivoWifiAcaoAssistente_PK PRIMARY KEY (idDispositivo, nomeAcao),
  CONSTRAINT DispositivoWifiAcaoAssistente_idDispositivo_FK1 FOREIGN KEY (idDispositivo) REFERENCES DispositivoWiFi(idDispositivo),
  CONSTRAINT DispositivoWifiAcaoAssistente_nomeAcao_FK2 FOREIGN KEY (nomeAcao) REFERENCES Acao(nome),
  CONSTRAINT DispositivoWifiAcaoAssistente_idAssistente_FK3 FOREIGN KEY (idAssistente) REFERENCES AssistenteVirtual(idAssistente)
);

/*TABELA DispositivoInfravermelhoAcaoAssistente:*/
DROP TABLE IF EXISTS DispositivoInfravermelhoAcaoAssistente;
CREATE TABLE DispositivoInfravermelhoAcaoAssistente
(
  idDispositivo INTEGER,
  nomeAcao TEXT,
  idAssistente INTEGER,
  CONSTRAINT DispositivoInfravermelhoAcaoAssistente_PK PRIMARY KEY (idDispositivo, nomeAcao),
  CONSTRAINT DispositivoInfravermelhoAcaoAssistente_idDispositivo_FK1 FOREIGN KEY (idDispositivo) REFERENCES DispositivoInfravermelho(idDispositivo),
  CONSTRAINT DispositivoInfravermelhoAcaoAssistente_nomeAcao_FK2 FOREIGN KEY (nomeAcao) REFERENCES Acao(nome),
  CONSTRAINT DispositivoInfravermelhoAcaoAssistente_idAssistente_FK3 FOREIGN KEY (idAssistente) REFERENCES AssistenteVirtual(idAssistente)
);


/*TABELA WifiAplicacao:*/
DROP TABLE IF EXISTS WifiAplicacao;
CREATE TABLE WifiAplicacao
(
  idDispositivo INTEGER,
  idAplicacao INTEGER,
  CONSTRAINT WifiAplicacao_PK PRIMARY KEY (idDispositivo, idAplicacao),
  CONSTRAINT WifiAplicacao_idDispositivo_FK1 FOREIGN KEY (idDispositivo) REFERENCES DispositivoWifi(idDispositivo),
  CONSTRAINT WifiAplicacao_idAplicacao_FK2 FOREIGN KEY (idAplicacao) REFERENCES Aplicacao(idAplicacao)
);

/*TABELA DispositivoBluetooth:*/
DROP TABLE IF EXISTS DispositivoBluetooth;
CREATE TABLE DispositivoBluetooth
(
  idDispositivo INTEGER,
  nome TEXT NOT NULL,
  idModelo INTEGER,
  idAssistente INTEGER,
  CONSTRAINT DispositivoBluetooth_PK PRIMARY KEY (idDispositivo),
  CONSTRAINT DispositivoBluetooth_idModelo_FK1 FOREIGN KEY (idModelo) REFERENCES Modelo(idModelo),
  CONSTRAINT DispositivoBluetooth_idAssistente_FK2 FOREIGN KEY (idAssistente) REFERENCES AssistenteVirtual(idAssistente)
);

/*TABELA EspecificacoesDispositivoBluetooth:*/
DROP TABLE IF EXISTS EspecificacoesDispositivoBluetooth;
CREATE TABLE EspecificacoesDispositivoBluetooth
(
  nome TEXT,
  idModelo INTEGER,
  versaoBluetooth TEXT NOT NULL,
  alcance FLOAT NOT NULL,
  velocidadeMax FLOAT,
  CONSTRAINT EspecificacoesDispositivoBluetooth_PK PRIMARY KEY (nome, idModelo),
  CONSTRAINT EspecificacoesDispositivoBluetooth_idModelo_FK1 FOREIGN KEY (idModelo) REFERENCES Modelo(idModelo)
);

/*TABELA DispositivoWiFi:*/
DROP TABLE IF EXISTS DispositivoWifi;
CREATE TABLE DispositivoWifi
(
  idDispositivo INTEGER,
  nome TEXT NOT NULL,
  idModelo INTEGER,
  CONSTRAINT DispositivoWifi_PK PRIMARY KEY (idDispositivo),
  CONSTRAINT DispositivoWifi_idModelo_FK1 FOREIGN KEY (idModelo) REFERENCES Modelo(idModelo)
);

/*TABELA EspecificacoesDispositivoWifi:*/
DROP TABLE IF EXISTS EspecificacoesDispositivoWifi;
CREATE TABLE EspecificacoesDispositivoWifi
(
  nome TEXT,
  idModelo INTEGER,
  alcance FLOAT NOT NULL,
  velocidadeMax FLOAT,
  frequencia FLOAT NOT NULL,
  CONSTRAINT EspecificacoesDispositivoWifi_PK PRIMARY KEY (nome, idModelo),
  CONSTRAINT EspecificacoesDispositivoWifi_idModelo_FK1 FOREIGN KEY (idModelo) REFERENCES Modelo(idModelo)
);

/*TABELA DispositivoInfravermelho:*/
DROP TABLE IF EXISTS DispositivoInfravermelho;
CREATE TABLE DispositivoInfravermelho
(
  idDispositivo INTEGER,
  nome TEXT NOT NULL,
  idModelo INTEGER,
  CONSTRAINT DispositivoInfravermelho_PK PRIMARY KEY (idDispositivo),
  CONSTRAINT DispositivoInfravermelho_idModelo_FK1 FOREIGN KEY (idModelo) REFERENCES Modelo(idModelo)
);

/*TABELA EspecificacoesDispositivoInfravermelho:*/
DROP TABLE IF EXISTS EspecificacoesDispositivoInfravermelho;
CREATE TABLE EspecificacoesDispositivoInfravermelho
(
  nome TEXT,
  idModelo INTEGER,
  frequencia FLOAT NOT NULL,
  CONSTRAINT EspecificacoesDispositivoWifi_PK PRIMARY KEY (nome, idModelo),
  CONSTRAINT EspecificacoesDispositivoWifi_idModelo_FK1 FOREIGN KEY (idModelo) REFERENCES Modelo(idModelo)
);

/*TABELA DispositivoInfraComando:*/
DROP TABLE IF EXISTS DispositivoInfraComando;
CREATE TABLE DispositivoInfraComando
(
  idDispositivo INTEGER,
  idComando INTEGER,
  CONSTRAINT DispositivoInfraComando_PK PRIMARY KEY (idDispositivo,idComando),
  CONSTRAINT DispositivoInfraComando_idDispositivo_FK1 FOREIGN KEY (idDispositivo) REFERENCES DispositivoInfravermelho(idDispositivo),
  CONSTRAINT DispositivoInfraComando_idComando_FK2 FOREIGN KEY (idComando) REFERENCES ComandoInfravermelho(idComando)
);
