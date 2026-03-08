# Gerenciador de Vida Academica (GVA) em Prolog

Projeto desenvolvido na disciplina de Paradigmas de Linguagens de Programacao (PLP), utilizando Prolog, com o objetivo de exercitar o paradigma logico por meio de um sistema de linha de comando (CLI).

O sistema auxilia o estudante no gerenciamento de sua vida academica, permitindo o controle de disciplinas, atividades, horarios e desempenho academico.

---

## Objetivo do Projeto

Desenvolver um sistema simples, modular e persistente em Prolog, aplicando conceitos como:

- Fatos e regras
- Predicados
- Recursividade simples
- Persistencia em arquivo
- Separacao por arquivos

---

## Funcionalidades

- Cadastro e gerenciamento de disciplinas
- Registro de atividades e trabalhos academicos
- Controle de horario semanal com bloqueio de conflitos
- Persistencia de dados em arquivo
- Calculo do IRA (Indice de Rendimento Academico) conforme modelo usado no projeto original
- Interface baseada em menu CLI

---

## Estrutura do Projeto

gva-prolog/
├─ main.pl
├─ src/
│  ├─ util.pl
│  ├─ persistencia.pl
│  ├─ disciplinas.pl
│  ├─ atividades.pl
│  ├─ horarios.pl
│  └─ ira.pl
├─ data/
│  └─ gva_db.pl
└─ README.md# Projeto_GVA_Prolog
