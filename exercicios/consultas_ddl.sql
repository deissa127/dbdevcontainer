CREATE TABLE pessoa (
    cpf CHAR(11) PRIMARY KEY,
    email VARCHAR(50) NOT NULL,
    nome VARCHAR(150) NOT NULL,
    data_nasc DATE NOT NULL,
    endereco VARCHAR(300) NOT NULL,
    telefone VARCHAR(15),
    CONSTRAINT pessoa_un UNIQUE (email, nome)   -- regra: não pode haver duas pessoas com o mesmo nome e email
);

CREATE TABLE paciente (
    codigo VARCHAR(10) PRIMARY KEY,
    senha VARCHAR(10) NOT NULL,
    plano_saude VARCHAR(3) NOT NULL,
    cpf CHAR(11) NOT NULL,  -- dado que será usado para relacionar com a tabela pessoa
    FOREIGN KEY (cpf) REFERENCES pessoa(cpf)    -- veio da tabela pessoa
);

CREATE TABLE medico (
    crm VARCHAR(20) PRIMARY KEY,
    cpf CHAR(11) NOT NULL,  -- dado que será usado para relacionar com a tabela pessoa
    FOREIGN KEY (cpf) REFERENCES pessoa(cpf)    -- veio da tabela pessoa
);

CREATE TABLE especialidade (
    id INT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL
);

CREATE TABLE possui (
    crm VARCHAR(20) NOT NULL,
    id_especialidade INT NOT NULL,
    PRIMARY KEY (crm, id_especialidade),    -- impede um medico de ter a mesma especialidade cadastrada mais de uma vez
    FOREIGN KEY (crm) REFERENCES medico(crm),
    FOREIGN KEY (id_especialidade) REFERENCES especialidade(id)
);

CREATE TABLE agendamento (
    codigo_paciente VARCHAR(10) NOT NULL,
    crm_medico VARCHAR(20) NOT NULL,
    data_hora_consulta TIMESTAMP NOT NULL,
    data_hora_agendamento TIMESTAMP NOT NULL,
    valor_consulta NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (codigo_paciente, crm_medico, data_hora_consulta),
    FOREIGN KEY (codigo_paciente) REFERENCES paciente(codigo),
    FOREIGN KEY (crm_medico) REFERENCES medico(crm)
);