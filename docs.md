# Documentação do Projeto -- GVA (Gerenciador de Vida Acadêmica)

## Visão Geral

O **GVA (Gerenciador de Vida Acadêmica)** é um sistema desenvolvido em
**Prolog** com o objetivo de auxiliar estudantes na organização de sua
vida acadêmica.\
O sistema permite gerenciar disciplinas, atividades, horários e calcular
o **IRA (Índice de Rendimento Acadêmico)**, além de manter persistência
dos dados.

O projeto foi dividido em módulos independentes para facilitar o
desenvolvimento, manutenção e organização do código.

Arquitetura geral:

-   `main.pl` inicializa o sistema e controla o menu principal.
-   Os módulos em `src/` implementam as funcionalidades específicas.
-   O diretório `data/` armazena o banco de dados persistente.

------------------------------------------------------------------------

# Estrutura do Projeto

    Projeto_GVA_Prolog
    │
    ├── main.pl
    ├── src
    │   ├── util.pl
    │   ├── persistencia.pl
    │   ├── disciplinas.pl
    │   ├── atividades.pl
    │   ├── horarios.pl
    │   └── ira.pl
    │
    └── data
        └── gva_db.pl

------------------------------------------------------------------------

# Divisão de Responsabilidades

## Arthur --- Main e Utilitários

Arthur foi responsável pela **estrutura central do sistema** e pelas
**funções utilitárias usadas em todos os módulos**.

### main.pl

Este arquivo representa o **ponto de entrada do sistema**.

Responsabilidades:

-   Inicializar o sistema
-   Carregar todos os módulos necessários
-   Controlar o fluxo do programa
-   Apresentar o menu principal ao usuário

Principais funções:

-   `iniciar/0`
-   `menu_principal/0`
-   `tratar_opcao_principal/1`

Esse arquivo é responsável por **integrar todos os módulos do projeto**,
garantindo que as funcionalidades funcionem de forma coordenada.

------------------------------------------------------------------------

### util.pl

O módulo de utilidades fornece **funções auxiliares reutilizáveis** para
facilitar a interação com o usuário.

Responsabilidades:

-   Leitura segura de entradas do usuário
-   Conversão de tipos de dados
-   Padronização da entrada de informações

Principais funções:

-   `ler_string/2`
-   `ler_texto/2`
-   `ler_inteiro/2`
-   `ler_real/2`

Essas funções são utilizadas em praticamente todos os módulos do
sistema.

------------------------------------------------------------------------

# Leandro --- Persistência de Dados

Leandro implementou o sistema de **armazenamento permanente das
informações do sistema**.

### persistencia.pl

Esse módulo é responsável por garantir que os dados do sistema sejam
**salvos e carregados automaticamente**.

Responsabilidades:

-   Definir predicados dinâmicos
-   Carregar dados do banco de dados
-   Salvar dados atualizados
-   Gerenciar o arquivo de persistência

Principais funções:

-   `carregar_dados/0`
-   `salvar_dados/0`

------------------------------------------------------------------------

### gva_db.pl

Arquivo responsável por armazenar os **fatos do sistema**, como:

-   disciplinas cadastradas
-   atividades
-   horários
-   notas e créditos para cálculo do IRA

Esse arquivo funciona como um **banco de dados simples em Prolog**.

------------------------------------------------------------------------

# Gustavo --- Módulo de Disciplinas

Gustavo desenvolveu o módulo responsável por **gerenciar as disciplinas
do aluno**.

### disciplinas.pl

Esse módulo permite cadastrar e manipular disciplinas no sistema.

Funcionalidades implementadas:

-   Cadastro de disciplina
-   Listagem de disciplinas
-   Remoção de disciplina
-   Consulta de disciplina

Cada disciplina pode conter informações como:

-   nome da disciplina
-   código
-   carga horária
-   créditos

Esse módulo serve como **base para outras funcionalidades do sistema**,
como atividades e cálculo do IRA.

------------------------------------------------------------------------

# Igor --- Módulo de Atividades

Igor implementou o gerenciamento de **atividades acadêmicas**.

### atividades.pl

Este módulo permite registrar atividades relacionadas às disciplinas.

Funcionalidades:

-   Cadastro de atividades
-   Associação de atividades a disciplinas
-   Listagem de atividades
-   Remoção de atividades

Exemplos de atividades:

-   provas
-   trabalhos
-   exercícios
-   projetos

Esse módulo ajuda o estudante a **acompanhar suas responsabilidades
acadêmicas**.

------------------------------------------------------------------------

# Oscar --- IRA e Horários

Oscar foi responsável pelos módulos de **organização de horários e
cálculo do IRA**.

------------------------------------------------------------------------

## horarios.pl

Esse módulo permite organizar os **horários das disciplinas**.

Funcionalidades:

-   Cadastro de horário de aula
-   Associação com disciplinas
-   Consulta de horários cadastrados

Com isso, o estudante pode visualizar sua **grade semanal de aulas**.

------------------------------------------------------------------------

## ira.pl

O módulo de IRA é responsável pelo **cálculo do Índice de Rendimento
Acadêmico**.

Funcionalidades:

-   Registro de notas
-   Registro de créditos das disciplinas
-   Cálculo automático do IRA

O cálculo considera:

-   notas obtidas
-   carga de créditos
-   disciplinas cursadas

Esse módulo fornece ao estudante uma **visão clara do seu desempenho
acadêmico**.

------------------------------------------------------------------------

# Conclusão

O projeto foi estruturado de forma modular para facilitar o
desenvolvimento colaborativo.

Cada integrante contribuiu com um conjunto específico de
funcionalidades:

  -----------------------------------------------------------------------
  Integrante                    Responsabilidade
  ----------------------------- -----------------------------------------
  Arthur                        Estrutura principal do sistema
                                (`main.pl`) e utilidades (`util.pl`)

  Leandro                       Persistência de dados (`persistencia.pl`)

  Gustavo                       Gerenciamento de disciplinas

  Igor                          Sistema de atividades

  Oscar                         Cálculo de IRA e organização de horários
  -----------------------------------------------------------------------

Essa divisão permitiu que o sistema fosse desenvolvido de forma
organizada, mantendo **separação de responsabilidades e melhor
manutenção do código**.
