

-- =========================================================
-- 1) CRIAÇÃO DA BASE DE DADOS
-- =========================================================
DROP DATABASE IF EXISTS lenora_datamanager;
CREATE DATABASE lenora_datamanager;
USE lenora_datamanager;

-- =========================================================
-- 2) CRIAÇÃO DAS TABELAS
-- =========================================================

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    perfil ENUM('gestor', 'pedagogico', 'administrativo') NOT NULL
);

CREATE TABLE professores (
    id_professor INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    idiomas_dominio VARCHAR(255),
    disponibilidade_horaria VARCHAR(255),
    dados_contato VARCHAR(150),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE alunos (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    contato VARCHAR(150),
    data_matricula DATE NOT NULL,
    data_vencimento_contrato DATE,
    nivel_proficiencia_inicial VARCHAR(50),
    status ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo'
);

CREATE TABLE turmas (
    id_turma INT AUTO_INCREMENT PRIMARY KEY,
    id_professor INT NOT NULL,
    nome_turma VARCHAR(150) NOT NULL,
    horario_fixo VARCHAR(100),
    FOREIGN KEY (id_professor) REFERENCES professores(id_professor)
);

CREATE TABLE turma_alunos (
    id_turma_aluno INT AUTO_INCREMENT PRIMARY KEY,
    id_turma INT NOT NULL,
    id_aluno INT NOT NULL,
    UNIQUE KEY uq_turma_aluno (id_turma, id_aluno),
    FOREIGN KEY (id_turma) REFERENCES turmas(id_turma),
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno)
);

CREATE TABLE aulas (
    id_aula INT AUTO_INCREMENT PRIMARY KEY,
    id_turma INT NOT NULL,
    id_aluno INT NOT NULL,
    data_hora DATETIME NOT NULL,
    status ENUM('presenca', 'falta', 'remarcacao', 'falta_cobrada') NOT NULL,
    data_solicitacao_remarcacao DATETIME NULL,
    FOREIGN KEY (id_turma) REFERENCES turmas(id_turma),
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno)
);

CREATE TABLE conteudos_materiais (
    id_conteudo INT AUTO_INCREMENT PRIMARY KEY,
    id_aula INT NOT NULL,
    topico_gramatical VARCHAR(150),
    material_didatico VARCHAR(255),
    observacoes TEXT,
    data_ministrado DATE NOT NULL,
    FOREIGN KEY (id_aula) REFERENCES aulas(id_aula)
);

CREATE TABLE revisoes (
    id_revisao INT AUTO_INCREMENT PRIMARY KEY,
    id_conteudo INT NOT NULL,
    id_aluno INT NOT NULL,
    data_original DATE NOT NULL,
    intervalo_dias INT NOT NULL DEFAULT 20,
    data_sugerida_revisao DATE NOT NULL,
    status_revisao ENUM('pendente', 'concluida') NOT NULL DEFAULT 'pendente',
    FOREIGN KEY (id_conteudo) REFERENCES conteudos_materiais(id_conteudo),
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno)
);

CREATE TABLE mensalidades (
    id_mensalidade INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_vencimento DATE NOT NULL,
    data_pagamento DATE NULL,
    status_pagamento ENUM('pago', 'pendente', 'inadimplente') NOT NULL DEFAULT 'pendente',
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno)
);

-- =========================================================
-- 3) INSERÇÃO DE DADOS (5 registros por tabela)
-- =========================================================

-- usuarios (5)
INSERT INTO usuarios (nome, email, senha, perfil) VALUES
('Kyara Amaral', 'kyara@lenora.com', 'senha123', 'gestor'),
('Mariana Souza', 'mariana@lenora.com', 'senha123', 'pedagogico'),
('Carlos Lima', 'carlos@lenora.com', 'senha123', 'pedagogico'),
('Fernanda Alves', 'fernanda@lenora.com', 'senha123', 'administrativo'),
('Rodrigo Nunes', 'rodrigo@lenora.com', 'senha123', 'pedagogico');

-- professores (5) - todos ligados a um usuário (id_usuario 1 a 5)
INSERT INTO professores (id_usuario, idiomas_dominio, disponibilidade_horaria, dados_contato) VALUES
(1, 'Espanhol, Português', 'Manhã e tarde', '(37) 99999-0001'),
(2, 'Espanhol', 'Tarde', '(37) 99999-0002'),
(3, 'Espanhol, Inglês', 'Noite', '(37) 99999-0003'),
(4, 'Espanhol', 'Manhã', '(37) 99999-0004'),
(5, 'Espanhol, Italiano', 'Tarde e noite', '(37) 99999-0005');

-- alunos (5)
INSERT INTO alunos (nome, contato, data_matricula, data_vencimento_contrato, nivel_proficiencia_inicial, status) VALUES
('João Pedro Silva', 'joao@email.com', '2026-01-10', '2026-12-10', 'A1', 'ativo'),
('Ana Beatriz Costa', 'ana@email.com', '2026-02-05', '2027-02-05', 'A2', 'ativo'),
('Lucas Martins', 'lucas@email.com', '2026-03-01', '2027-03-01', 'B1', 'ativo'),
('Camila Rocha', 'camila@email.com', '2026-01-20', '2026-07-20', 'A1', 'ativo'),
('Rafael Torres', 'rafael@email.com', '2026-04-15', '2027-04-15', 'B2', 'ativo');

-- turmas (5) - referenciando professores 1 a 5
INSERT INTO turmas (id_professor, nome_turma, horario_fixo) VALUES
(1, 'Espanhol Iniciante A', 'Seg e Qua 09h'),
(2, 'Espanhol Intermediário B', 'Ter e Qui 14h'),
(3, 'Conversação Avançada', 'Sex 19h'),
(4, 'Espanhol Iniciante B', 'Seg 10h'),
(5, 'Preparatório Intercâmbio', 'Qua 18h');

-- turma_alunos (5) - usando apenas turmas 1 a 4 e alunos 1 a 4 (turma 5 e aluno 5 ficam livres p/ exclusão)
INSERT INTO turma_alunos (id_turma, id_aluno) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(1, 2);

-- aulas (5) - usando apenas turmas 1 a 4 e alunos 1 a 4 (aula 5 fica livre p/ exclusão)
INSERT INTO aulas (id_turma, id_aluno, data_hora, status, data_solicitacao_remarcacao) VALUES
(1, 1, '2026-07-06 09:00:00', 'presenca', NULL),
(2, 2, '2026-07-07 14:00:00', 'presenca', NULL),
(3, 3, '2026-07-10 19:00:00', 'falta', NULL),
(4, 4, '2026-07-06 10:00:00', 'remarcacao', '2026-07-05 20:00:00'),
(1, 2, '2026-07-13 09:00:00', 'presenca', NULL);

-- conteudos_materiais (5) - usando apenas aulas 1 a 4 (conteúdo 5 fica livre p/ exclusão)
INSERT INTO conteudos_materiais (id_aula, topico_gramatical, material_didatico, observacoes, data_ministrado) VALUES
(1, 'Presente do indicativo', 'Apostila Unidade 1', 'Aluno com boa fixação', '2026-07-06'),
(2, 'Pretérito perfeito', 'Apostila Unidade 4', 'Precisa reforçar irregulares', '2026-07-07'),
(3, 'Subjuntivo presente', 'Material próprio', 'Conversação fluida', '2026-07-10'),
(4, 'Ser x Estar', 'Apostila Unidade 2', 'Aula remarcada, revisão rápida', '2026-07-06'),
(4, 'Vocabulário viagem', 'Slides próprios', 'Foco em intercâmbio', '2026-07-13');

-- revisoes (5) - usando apenas conteúdos 1 a 4 e alunos 1 a 4
INSERT INTO revisoes (id_conteudo, id_aluno, data_original, intervalo_dias, data_sugerida_revisao, status_revisao) VALUES
(1, 1, '2026-07-06', 20, '2026-07-26', 'pendente'),
(2, 2, '2026-07-07', 20, '2026-07-27', 'pendente'),
(3, 3, '2026-07-10', 15, '2026-07-25', 'pendente'),
(4, 4, '2026-07-06', 20, '2026-07-26', 'concluida'),
(1, 1, '2026-07-06', 40, '2026-08-15', 'pendente');

-- mensalidades (5) - usando apenas alunos 1 a 4
INSERT INTO mensalidades (id_aluno, valor, data_vencimento, data_pagamento, status_pagamento) VALUES
(1, 250.00, '2026-07-10', '2026-07-09', 'pago'),
(2, 250.00, '2026-07-10', NULL, 'pendente'),
(3, 300.00, '2026-07-05', '2026-07-05', 'pago'),
(4, 250.00, '2026-06-10', NULL, 'inadimplente'),
(1, 250.00, '2026-08-10', NULL, 'pendente');

-- =========================================================
-- 4) EXIBIÇÃO DOS DADOS (SELECT * e SELECT ... WHERE)
-- =========================================================

-- 4.1) SELECT * em todas as tabelas
SELECT * FROM usuarios;
SELECT * FROM professores;
SELECT * FROM alunos;
SELECT * FROM turmas;
SELECT * FROM turma_alunos;
SELECT * FROM aulas;
SELECT * FROM conteudos_materiais;
SELECT * FROM revisoes;
SELECT * FROM mensalidades;

-- 4.2) SELECT com WHERE (buscas específicas)
SELECT * FROM usuarios WHERE perfil = 'pedagogico';
SELECT * FROM alunos WHERE status = 'ativo' AND nivel_proficiencia_inicial = 'A1';
SELECT * FROM aulas WHERE status = 'falta';
SELECT * FROM mensalidades WHERE status_pagamento = 'inadimplente';
SELECT * FROM revisoes WHERE status_revisao = 'pendente' AND data_sugerida_revisao <= '2026-07-27';
SELECT * FROM turmas WHERE id_professor = 1;

-- =========================================================
-- 5) EDIÇÃO DOS DADOS (UPDATE - pelo menos 1 por tabela)
-- =========================================================

UPDATE usuarios SET senha = 'novaSenha456' WHERE id_usuario = 1;
UPDATE professores SET disponibilidade_horaria = 'Manhã, tarde e noite' WHERE id_professor = 1;
UPDATE alunos SET nivel_proficiencia_inicial = 'A2' WHERE id_aluno = 1;
UPDATE turmas SET horario_fixo = 'Seg e Qua 09h30' WHERE id_turma = 1;
UPDATE turma_alunos SET id_aluno = 3 WHERE id_turma = 1 AND id_aluno = 2;
UPDATE aulas SET status = 'presenca' WHERE id_aula = 3;
UPDATE conteudos_materiais SET observacoes = 'Revisado após feedback do aluno' WHERE id_conteudo = 1;
UPDATE revisoes SET status_revisao = 'concluida' WHERE id_revisao = 1;
UPDATE mensalidades SET status_pagamento = 'pago', data_pagamento = '2026-07-10' WHERE id_mensalidade = 2;

-- Conferindo as alterações
SELECT * FROM usuarios WHERE id_usuario = 1;
SELECT * FROM mensalidades WHERE id_mensalidade = 2;

-- =========================================================
-- 6) EXCLUSÃO DOS DADOS (DELETE - pelo menos 1 por tabela)
-- Observação: os registros escolhidos abaixo (o "5º" de cada tabela)
-- foram propositalmente deixados sem nenhuma outra tabela referenciando-os,
-- para que o DELETE funcione sem violar as chaves estrangeiras (FK).
-- =========================================================

-- Ordem: das tabelas "filhas" para as "mãe", por segurança de FK
DELETE FROM mensalidades WHERE id_mensalidade = 5;
DELETE FROM revisoes WHERE id_revisao = 5;
DELETE FROM conteudos_materiais WHERE id_conteudo = 5;
DELETE FROM aulas WHERE id_aula = 5;
DELETE FROM turma_alunos WHERE id_turma = 1 AND id_aluno = 3;
DELETE FROM turmas WHERE id_turma = 5;
DELETE FROM alunos WHERE id_aluno = 5;
DELETE FROM professores WHERE id_professor = 5;
DELETE FROM usuarios WHERE id_usuario = 5;

-- Conferindo as exclusões (nenhuma dessas consultas deve retornar linha)
SELECT * FROM mensalidades WHERE id_mensalidade = 5;
SELECT * FROM revisoes WHERE id_revisao = 5;
SELECT * FROM conteudos_materiais WHERE id_conteudo = 5;
SELECT * FROM aulas WHERE id_aula = 5;
SELECT * FROM turmas WHERE id_turma = 5;
SELECT * FROM alunos WHERE id_aluno = 5;
SELECT * FROM professores WHERE id_professor = 5;
SELECT * FROM usuarios WHERE id_usuario = 5;
