#  Lenora DataManager

![Status](https://img.shields.io/badge/Status-Em%20Desenvolvimento-yellow) ![Banco de Dados](https://img.shields.io/badge/Banco%20de%20Dados-MySQL-blue) ![Linguagem](https://img.shields.io/badge/Linguagem-Java-red) ![Objetivo](https://img.shields.io/badge/Objetivo-Gestão%20Pedagógica-brightgreen)

## 📝 Sobre o Projeto

O **Lenora DataManager** é um sistema projetado para centralizar e facilitar a gestão pedagógica e financeira de escolas de idiomas e professores autônomos. 

A proposta partiu de uma necessidade real do cotidiano profissional no ensino de idiomas, visando substituir controles manuais e planilhas pouco efetivas por uma solução tecnológica robusta baseada em banco de dados. O foco é resolver problemas críticos como o controle rigoroso de frequência, regras de remarcação e a gestão de prazos de pagamentos.

## ✨ Diferenciais e Funcionalidades

O sistema possui uma estrutura modular para garantir a saúde financeira do negócio e permitir que o professor foque exclusivamente no ensino:

*   **Princípio de Revisão Inteligente:** Utiliza lógica de repetição espaçada para gerar alertas automáticos sobre o momento ideal de revisitar temas para cada aluno, combatendo a curva do esquecimento.
*   **Gestão de Frequência e Política de 24h:** Controle de presenças e validação automática de remarcações, exigindo 24 horas de antecedência para não contabilizar como falta cobrada.
*   **Gestão Financeira:** Controle completo de mensalidades e status de pagamento, com alertas para inativação de alunos inadimplentes.
*   **Perfis de Acesso:** Níveis de acesso flexíveis (Gestor, Pedagógico e Administrativo) que protegem dados financeiros e garantem a segurança da informação.
*   **Segurança de Dados:** Rotina de backup diário automatizado.

## 💻 Tecnologias e Arquitetura

Este projeto foi estruturado seguindo as melhores práticas de abstração de dados e integridade referencial:

*   **Banco de Dados:** MySQL (escolhido por sua confiabilidade e robustez na garantia de integridade referencial).
*   **Linguagem de Programação:** Java (responsável pela lógica de aplicação e processamento do Motor de Revisão Inteligente).
*   **Conexão:** JDBC (Java Database Connectivity) para comunicação segura entre a aplicação e o banco de dados.
