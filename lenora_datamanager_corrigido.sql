-- =========================================================
-- Lenora DataManager - Modelo de Dados (Etapa 2)
-- Projeto Integrador - Senac
-- =========================================================

CREATE DATABASE IF NOT EXISTS lenora_datamanager;
USE lenora_datamanager;

-- ---------------------------------------------------------
-- Tabela: usuarios
-- ---------------------------------------------------------
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    perfil ENUM('gestor', 'pedagogico', 'administrativo') NOT NULL
);

-- ---------------------------------------------------------
-- Tabela: professores
-- ---------------------------------------------------------
CREATE TABLE professores (
    id_professor INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    idiomas_dominio VARCHAR(255),
    disponibilidade_horaria VARCHAR(255),
    dados_contato VARCHAR(150),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- ---------------------------------------------------------
-- Tabela: alunos
-- ---------------------------------------------------------
CREATE TABLE alunos (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    contato VARCHAR(150),
    data_matricula DATE NOT NULL,
    data_vencimento_contrato DATE,
    nivel_proficiencia_inicial VARCHAR(50),
    status ENUM('ativo', 'inativo') NOT NULL DEFAULT 'ativo'
);

-- ---------------------------------------------------------
-- Tabela: turmas
-- ---------------------------------------------------------
CREATE TABLE turmas (
    id_turma INT AUTO_INCREMENT PRIMARY KEY,
    id_professor INT NOT NULL,
    nome_turma VARCHAR(150) NOT NULL,
    horario_fixo VARCHAR(100),
    FOREIGN KEY (id_professor) REFERENCES professores(id_professor)
);

-- ---------------------------------------------------------
-- Tabela: turma_alunos (associativa N:N entre turmas e alunos)
-- ---------------------------------------------------------
CREATE TABLE turma_alunos (
    id_turma_aluno INT AUTO_INCREMENT PRIMARY KEY,
    id_turma INT NOT NULL,
    id_aluno INT NOT NULL,
    UNIQUE KEY uq_turma_aluno (id_turma, id_aluno),
    FOREIGN KEY (id_turma) REFERENCES turmas(id_turma),
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno)
);

-- ---------------------------------------------------------
-- Tabela: aulas
-- ---------------------------------------------------------
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

-- ---------------------------------------------------------
-- Tabela: conteudos_materiais
-- ---------------------------------------------------------
CREATE TABLE conteudos_materiais (
    id_conteudo INT AUTO_INCREMENT PRIMARY KEY,
    id_aula INT NOT NULL,
    topico_gramatical VARCHAR(150),
    material_didatico VARCHAR(255),
    observacoes TEXT,
    data_ministrado DATE NOT NULL,
    FOREIGN KEY (id_aula) REFERENCES aulas(id_aula)
);

-- ---------------------------------------------------------
-- Tabela: revisoes (Principio de Revisao Inteligente)
-- ---------------------------------------------------------
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

-- ---------------------------------------------------------
-- Tabela: mensalidades
-- ---------------------------------------------------------
CREATE TABLE mensalidades (
    id_mensalidade INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_vencimento DATE NOT NULL,
    data_pagamento DATE NULL,
    status_pagamento ENUM('pago', 'pendente', 'inadimplente') NOT NULL DEFAULT 'pendente',
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno)
);
