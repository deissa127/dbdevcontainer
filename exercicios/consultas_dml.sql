--------------- INSERTS ---------------

INSERT INTO dbo.pessoa(cpf, email, nome, data_nasc, endereco, telefone) VALUES
    ('002', 'pp@gmail.com', 'Pedro I', '10-01-1479', 'R. Vasco', NULL),
    ('003', 'ps@email.com', 'Pedro II', '10-02-1516', 'R. Flamengo', '5501'),
    ('001', 'dj@email.com', 'D João VI', '01-12-1415', 'R. Portugal', NULL),
    ('004', 'jj@email.com', 'JJ Xavier', '12-11-1746', 'R. Minas', '5502');

INSERT INTO dbo.paciente(codigo, senha, plano_saude, cpf) VALUES
    ('002', 'senha1', 'Não', '002'),
    ('003', 'senha2', 'SIM', '003');

INSERT INTO dbo.medico(crm, cpf) VALUES
    ('111', '001'),
    ('112', '004');

INSERT INTO dbo.especialidade(id, descricao) VALUES
    (01, 'Pediatra'),
    (02, 'Cardiologista'),
    (03, 'Ortopedista');

INSERT INTO dbo.medicoEspecialidade(crm, id_especialidade) VALUES
    ('111', 01),
    ('112', 02),
    ('112', 03);

INSERT INTO dbo.agendamento(codigo_paciente, crm_medico, data_hora_consulta, data_hora_agendamento, valor_consulta) VALUES
    ('002', '111', '14-04-1782 16:00:00', '14-03-1782 10:04:45', 'R$ 80,00'),
    ('002', '112', '15-04-1782 10:00:00', '14-03-1782 10:04:45', 'R$ 100,00'),
    ('002', '112', '17-05-1783 08:00:00', '10-05-1783 16:32:00', 'R$ 100,00'),
    ('003', '111', '17-05-1783 08:30:00', '09-05-1783 09:05:56', 'R$ 0,00');

---------------- UPDATES ---------------

UPDATE dbo.pessoa 
SET data_nasc = '01-12-1416' 
WHERE cpf = '001';

UPDATE dbo.pessoa
SET telefone = '5503'
    email = 'pf@email.com'
WHERE cpf = '002';

UPDATE dbo.pessoa 
SET telefone = CONCAT('9', telefone)
WHERE telefone IS NOT NULL;

UPDATE dbo.agendamento 
SET data_hora_consulta = DATEADD(DAY, 2, data_hora_consulta)
    valor_consulta = 'R$ 150,00'
WHERE CAST(data_hora_consulta AS DATE) = '17-05-1783';

UPDATE dbo.medicoEspecialidade
SET id_especialidade = 01
WHERE crm = '112' AND id_especialidade = 02;

---------------- DELETES ---------------

DELETE FROM dbo.agendamento
WHERE codigo_paciente = '002'
AND crm_medico = '112'
AND data_hora_consulta = '19-05-1783 08:00:00';

DELETE FROM dbo.agendamento
WHERE crm_medico IN (
    SELECT crm
    FROM dbo.medico
    WHERE cpf IN (
        SELECT cpf
        FROM dbo.pessoa
        WHERE nome = 'D João VI'
    )
);
AND valor_consulta = 'R$ 0,00';

DELETE FROM dbo.paciente
WHERE plano_saude = 'SIM'
OR cpf IN (
    SELECT cpf 
    FROM dbo.pessoa 
    WHERE telefone IS NULL
    );

DELETE FROM dbo.agendamento WHERE crm_medico = '112';
DELETE FROM dbo.medicoEspecialidade WHERE crm = '112';
DELETE FROM dbo.medico WHERE cpf = '004';
DELETE FROM dbo.pessoa WHERE cpf = '004';