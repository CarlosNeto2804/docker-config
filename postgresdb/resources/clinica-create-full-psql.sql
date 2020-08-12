DROP DATABASE IF EXISTS clinicadb;
CREATE DATABASE clinicadb;

\c clinicadb;

CREATE SCHEMA clinicaschema;

SET search_path=clinicaschema;

DROP TABLE IF EXISTS clinicaschema.AMBULATORIO CASCADE;
DROP TABLE IF EXISTS clinicaschema.PESSOA CASCADE;
DROP TABLE IF EXISTS clinicaschema.MEDICO CASCADE;
DROP TABLE IF EXISTS clinicaschema.PACIENTE CASCADE;
DROP TABLE IF EXISTS clinicaschema.FUNCIONARIO CASCADE;
DROP TABLE IF EXISTS clinicaschema.CONSULTA CASCADE;


CREATE TABLE clinicaschema.AMBULATORIO(
	codAmbulatorio Integer PRIMARY KEY,
	andar Integer NOT NULL,
	capacidade Integer NOT NULL
);

CREATE TABLE clinicaschema.PESSOA (
	cpf varchar(11) PRIMARY KEY,
	nome varchar(40) NOT NULL,
	idade integer NOT NULL,
	cidade varchar(30)
);

CREATE TABLE clinicaschema.MEDICO (
	codMed integer PRIMARY KEY,
	cpf varchar(11) UNIQUE NOT NULL,
	especialidade varchar(50) NOT NULL,
	codAmbulatorio integer,
	CONSTRAINT cpfm_fk FOREIGN KEY(cpf) REFERENCES clinicaschema.PESSOA(cpf) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT codambm_fk FOREIGN KEY(codAmbulatorio) REFERENCES clinicaschema.AMBULATORIO(codAmbulatorio) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE clinicaschema.PACIENTE (
	codPac integer PRIMARY KEY,
	cpf varchar(11) UNIQUE NOT NULL,
	doenca varchar(50),
	CONSTRAINT cpfp_fk FOREIGN KEY(cpf) REFERENCES clinicaschema.PESSOA(cpf) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE clinicaschema.FUNCIONARIO (
	codFunc integer PRIMARY KEY,
	cpf varchar(11) UNIQUE NOT NULL,
	salario numeric(10,2) DEFAULT 0,
	CONSTRAINT cpff_fk FOREIGN KEY(cpf) REFERENCES clinicaschema.PESSOA(cpf) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE clinicaschema.CONSULTA (
	codMed integer,
	codPac integer,
	data date,
	hora time,
	CONSTRAINT cons_pk PRIMARY KEY (codMed, codPac, data, hora),
	CONSTRAINT codmc_fk FOREIGN KEY(codMed) REFERENCES clinicaschema.MEDICO(codMed) ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT codpc_fk FOREIGN KEY(codPac) REFERENCES clinicaschema.PACIENTE(codPac) ON DELETE NO ACTION ON UPDATE NO ACTION	
);


INSERT INTO clinicaschema.AMBULATORIO (codAmbulatorio, andar, capacidade) VALUES (1,1,30);
INSERT INTO clinicaschema.AMBULATORIO (codAmbulatorio, andar, capacidade) VALUES (2,1,50);
INSERT INTO clinicaschema.AMBULATORIO (codAmbulatorio, andar, capacidade) VALUES (3,2,40);
INSERT INTO clinicaschema.AMBULATORIO (codAmbulatorio, andar, capacidade) VALUES (4,2,25);
INSERT INTO clinicaschema.AMBULATORIO (codAmbulatorio, andar, capacidade) VALUES (5,2,55);

-- PESSOA/MEDICO
INSERT INTO clinicaschema.PESSOA (nome, idade, cpf, cidade) VALUES ('João', 40, '10000100000', 'Florianópolis');
INSERT INTO clinicaschema.PESSOA (nome, idade, cpf, cidade) VALUES ('Maria', 42, '11100100000', 'Blumenau');
INSERT INTO clinicaschema.PESSOA (nome, idade, cpf, cidade) VALUES ('Pedro', 51, '10001101000', 'São José');
INSERT INTO clinicaschema.PESSOA (nome, idade, cpf, cidade) VALUES ('Carlos', 28, '11110100000', 'Joinville');
INSERT INTO clinicaschema.PESSOA (nome, idade, cpf, cidade) VALUES ('Marcia', 33, '10110100000', 'Biguaçu');
INSERT INTO clinicaschema.PESSOA (nome, idade, cpf, cidade) VALUES ('Asdrúbal', 24, '12345678985', 'Coxim');
-- PESSOA/PACIENTE
INSERT INTO clinicaschema.PESSOA (nome, idade, cpf, cidade) VALUES ('Ana', 20, '220100000', 'Florianópolis');
INSERT INTO clinicaschema.PESSOA (nome, idade, cpf, cidade) VALUES ('Paulo', 24, '8110100000', 'Palhoça');
INSERT INTO clinicaschema.PESSOA (nome, idade, cpf, cidade) VALUES ('Lucia', 30, '17910100000', 'Biguaçu');
INSERT INTO clinicaschema.PESSOA (nome, idade, cpf, cidade) VALUES ('Carlos', 28, '12510100000', 'Joinville');
-- PESSOAL/FUNCIONARIO
INSERT INTO clinicaschema.PESSOA (nome, idade, cpf, cidade) VALUES ('Rita', 32, '12510100020', 'São José');
INSERT INTO clinicaschema.PESSOA (nome, idade, cpf, cidade) VALUES ('Maria', 55, '12510100360', 'Palhoça');
INSERT INTO clinicaschema.PESSOA (nome, idade, cpf, cidade) VALUES ('Caio', 45, '12510147800', 'Florianópolis');
INSERT INTO clinicaschema.PESSOA (nome, idade, cpf, cidade) VALUES ('Carlos', 44, '12510105800', 'Florianópolis');
INSERT INTO clinicaschema.PESSOA (nome, idade, cpf, cidade) VALUES ('Paula', 33, '12510100002', 'Florianópolis');


INSERT INTO clinicaschema.MEDICO (codMed, cpf, especialidade, codAmbulatorio) VALUES (1, '10000100000', 'ortopedia',1);
INSERT INTO clinicaschema.MEDICO (codMed, cpf, especialidade, codAmbulatorio) VALUES (2, '11100100000', 'traumatologia',2);
INSERT INTO clinicaschema.MEDICO (codMed, cpf, especialidade, codAmbulatorio) VALUES (3, '10001101000', 'pediatria',2);
INSERT INTO clinicaschema.MEDICO (codMed, cpf, especialidade, codAmbulatorio) VALUES (4, '11110100000', 'ortopedia',1);
INSERT INTO clinicaschema.MEDICO (codMed, cpf, especialidade, codAmbulatorio) VALUES (5, '10110100000', 'neurologia',3);
INSERT INTO clinicaschema.MEDICO (codMed, cpf, especialidade, codAmbulatorio) VALUES (6, '12345678985', 'neurologia',NULL);

INSERT INTO clinicaschema.PACIENTE (codPac, cpf, doenca) VALUES (1, 220100000, 'gripe');
INSERT INTO clinicaschema.PACIENTE (codPac, cpf, doenca) VALUES (2, 8110100000, 'fratura');
INSERT INTO clinicaschema.PACIENTE (codPac, cpf, doenca) VALUES (3, 17910100000, 'tendinite');
INSERT INTO clinicaschema.PACIENTE (codPac, cpf, doenca) VALUES (4, 12510100000, 'sarampo');
INSERT INTO clinicaschema.PACIENTE (codPac, cpf, doenca) VALUES (5, 12510100002, 'catapora');

INSERT INTO clinicaschema.FUNCIONARIO (codFunc, cpf, salario) VALUES (1, '12510100020' ,1200);
INSERT INTO clinicaschema.FUNCIONARIO (codFunc, cpf, salario) VALUES (2, '12510100360', 1220);
INSERT INTO clinicaschema.FUNCIONARIO (codFunc, cpf, salario) VALUES (3, '12510147800', 1100);
INSERT INTO clinicaschema.FUNCIONARIO (codFunc, cpf, salario) VALUES (4, '12510105800', 1200);
INSERT INTO clinicaschema.FUNCIONARIO (codFunc, cpf, salario) VALUES (5, '12510100002', 2500);

INSERT INTO clinicaschema.CONSULTA (codMed, codPac, data, hora) VALUES (1, 1, '2010-10-12', '14:00');
INSERT INTO clinicaschema.CONSULTA (codMed, codPac, data, hora) VALUES (1, 4, '2010-10-13', '10:00');
INSERT INTO clinicaschema.CONSULTA (codMed, codPac, data, hora) VALUES (2, 1, '2010-10-13', '9:00');
INSERT INTO clinicaschema.CONSULTA (codMed, codPac, data, hora) VALUES (2, 2, '2010-10-13', '11:00');
INSERT INTO clinicaschema.CONSULTA (codMed, codPac, data, hora) VALUES (2, 3, '2010-10-14', '14:00');
INSERT INTO clinicaschema.CONSULTA (codMed, codPac, data, hora) VALUES (2, 4, '2010-10-14', '17:00');
INSERT INTO clinicaschema.CONSULTA (codMed, codPac, data, hora) VALUES (3, 1, '2010-10-19', '18:00');
INSERT INTO clinicaschema.CONSULTA (codMed, codPac, data, hora) VALUES (3, 3, '2010-10-12', '10:00');
INSERT INTO clinicaschema.CONSULTA (codMed, codPac, data, hora) VALUES (3, 4, '2010-10-19', '13:00');
INSERT INTO clinicaschema.CONSULTA (codMed, codPac, data, hora) VALUES (4, 4, '2010-10-20', '13:00');
INSERT INTO clinicaschema.CONSULTA (codMed, codPac, data, hora) VALUES (4, 4, '2010-10-22', '19:30');
