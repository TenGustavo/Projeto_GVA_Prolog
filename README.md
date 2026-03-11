# Gerenciador de Vida Acadêmica (GVA) — Prolog

Sistema desenvolvido em **programação lógica** para auxiliar estudantes no gerenciamento de sua vida acadêmica: disciplinas, atividades, horários e desempenho.

O projeto foi implementado utilizando a linguagem **entity["software","Prolog"]**, explorando conceitos centrais do **Paradigma Lógico**, como:

- Representação de conhecimento através de **fatos**
- Definição de **regras lógicas**
- Inferência automática
- **Backtracking**
- Base de conhecimento dinâmica

O sistema simula um **assistente acadêmico inteligente**, capaz de armazenar dados e realizar inferências sobre o estado acadêmico do estudante.

---

# Objetivo do Projeto

O **Gerenciador de Vida Acadêmica (GVA)** foi desenvolvido para:

- Organizar disciplinas cursadas
- Gerenciar atividades e prazos
- Evitar conflitos de horários
- Calcular desempenho acadêmico (IRA)
- Armazenar dados persistentes

Além disso, o projeto demonstra **como o Paradigma Lógico pode ser utilizado para modelar sistemas reais**, utilizando regras e inferência em vez de estruturas imperativas tradicionais.

---

# Paradigma Lógico aplicado no projeto

No Paradigma Lógico, um programa é composto por:

- **Fatos** → dados armazenados na base de conhecimento  
- **Regras** → relações lógicas entre fatos  
- **Consultas** → perguntas feitas ao sistema

Este projeto utiliza exatamente essa estrutura.

Exemplo de fatos representados no sistema:

```prolog id="j82p2l"
disciplina(Id, Codigo, Nome, Professor, CH, Situacao, Semestre, Nota, Periodo).
atividade(Id, DisciplinaId, Titulo, Descricao, Tipo, Status, Prazo).
bloco(Dia, Inicio, Fim, Tipo, Disciplina, Rotulo).
```

A partir desses fatos, o sistema pode **inferir informações**, como:

- cálculo do **IRA**
- detecção de **choque de horários**
- identificação de **atividades pendentes**

---

# Arquitetura do Projeto

Estrutura de diretórios:

``` id="nyi4m8"
Projeto_GVA_Prolog
│
├── main.pl
│
├── src
│   ├── util.pl
│   ├── persistencia.pl
│   ├── disciplinas.pl
│   ├── atividades.pl
│   ├── horarios.pl
│   ├── ira.pl
│
├── data
│   └── gva_db.pl
│
└── README.md
```

Cada módulo representa **uma parte da base de conhecimento e do raciocínio lógico do sistema**.

---

# Interligação entre os módulos e o Paradigma Lógico

## `main.pl` — Motor de execução

Arquivo responsável por:

- iniciar o sistema
- carregar a base de conhecimento
- exibir o menu principal
- delegar as consultas para os módulos

Ele conecta todos os módulos:

```prolog id="tth5oo"
:- consult('src/util.pl').
:- consult('src/persistencia.pl').
:- consult('src/disciplinas.pl').
:- consult('src/atividades.pl').
:- consult('src/horarios.pl').
:- consult('src/ira.pl').
```

### Relação com Paradigma Lógico

O `main.pl` atua como **controlador de consultas** à base de conhecimento.

Ele não executa algoritmos complexos — apenas **faz perguntas ao sistema lógico**.

---

# Módulos do Sistema

---

# 1. Disciplinas (`disciplinas.pl`)

Responsável por gerenciar informações sobre disciplinas:

- cadastrar disciplinas
- listar disciplinas
- registrar notas
- registrar períodos
- alterar situação (cursando, trancada, concluída)

Exemplo de fato armazenado:

```prolog id="13vys7"
disciplina(1, "COMP101", "Programação", "Prof. João", 60, cursando, 2024.1, none, none).
```

### Paradigma lógico

Aqui ocorre a **representação de conhecimento**:

As disciplinas são modeladas como **fatos na base lógica**.

Consultas podem ser feitas como:

```prolog id="gztnwg"
disciplina(Id, Codigo, Nome, _, _, _, _, _, _).
```

---

# 2. Atividades (`atividades.pl`)

Gerencia tarefas relacionadas às disciplinas:

- provas
- trabalhos
- leituras
- projetos
- tarefas

Cada atividade possui relação com uma disciplina.

Exemplo:

```prolog id="nnrr91"
atividade(1, 2, "Lista 1", "Exercícios de lógica", tarefa, pendente, "2024-04-10").
```

### Paradigma lógico

Relacionamento entre entidades:

``` id="6y424d"
Disciplina -> possui -> Atividades
```

O sistema usa **relações lógicas entre fatos** para organizar informações.

---

# 3. Horários (`horarios.pl`)

Gerencia a agenda semanal do estudante.

Permite:

- adicionar blocos de horário
- remover horários
- listar agenda

O sistema impede **choque de horários**.

### Paradigma lógico

A detecção de conflito é feita através de **regras lógicas** que verificam:

``` id="3vqty9"
Se dois blocos possuem
mesmo dia
intervalos sobrepostos
então existe choque
```

Esse tipo de verificação é **natural em programação lógica**, pois funciona como uma **consulta sobre relações**.

---

# 4. Desempenho Acadêmico (`ira.pl`)

Calcula o **IRA (Índice de Rendimento Acadêmico)**.

O cálculo é baseado em:

- carga horária
- período
- nota final

Exemplo de regra:

```prolog id="xbrsiy"
termo_ira(Peso, PesoNota)
```

Essa regra gera termos que posteriormente são agregados para calcular o IRA.

### Paradigma lógico

Este módulo demonstra **inferência lógica e agregação de conhecimento**.

O sistema:

1️coleta todos os fatos relevantes  
2️aplica regras  
3️produz um novo conhecimento (IRA)

---

# 5. Persistência (`persistencia.pl`)

Responsável por:

- carregar dados
- salvar dados
- inicializar base de conhecimento

Os dados são armazenados em:

``` id="4i78gu"
data/gva_db.pl
```

### Paradigma lógico

A base de dados é simplesmente **um conjunto de fatos Prolog**.

Ou seja:

O próprio banco de dados **é uma base lógica**.

---

# 6. Utilitários (`util.pl`)

Contém funções auxiliares:

- leitura de dados
- parsing de horários
- formatação de texto

Exemplo:

``` id="5ysj88"
parse_hora_min
fmt_hora
```

Esse módulo ajuda os outros módulos a **interagir com o usuário**.

---

# Fluxo de funcionamento do sistema

``` id="h1ybzh"
Usuário
   ↓
Menu principal
   ↓
Consulta lógica
   ↓
Base de conhecimento
   ↓
Inferência
   ↓
Resposta ao usuário
```

O sistema funciona como um **motor de inferência acadêmico**.

---

# Como executar

Instale o **entity["software","SWI-Prolog"]**.

Depois execute:

```bash id="rw35nu"
swipl
```

Carregue o projeto:

```prolog id="691t4w"
consult('main.pl').
```

Inicie o sistema:

```prolog id="odq7o3"
iniciar.
```

---

# Funcionalidades

Cadastro de disciplinas  
Registro de atividades  
Controle de prazos  
Agenda semanal  
Bloqueio de choque de horários  
Cálculo automático do IRA  
Persistência de dados  

---

# Conclusão

O projeto demonstra como o **Paradigma Lógico** pode ser aplicado para modelar sistemas reais.

Principais vantagens observadas:

- Representação natural de conhecimento
- Regras declarativas
- Inferência automática
- Código expressivo e compacto

O **GVA** mostra que **programação lógica não é apenas teórica**, podendo ser aplicada para resolver problemas práticos do cotidiano acadêmico.

---

Sistema ideal para estudo de:

- Programação Lógica
- Modelagem de conhecimento
- Sistemas baseados em regras
- Prolog aplicado

---

Se quiser, também posso te entregar uma **versão ainda melhor do README** com:

- diagramas
- fluxograma do sistema
- modelo lógico
- exemplos de consultas Prolog

Isso deixaria o projeto **nível GitHub profissional / nota máxima na disciplina**.
