# Documento Técnico — Gerenciador de Vida Acadêmica (GVA)

**Projeto:** Gerenciador de Vida Acadêmica (GVA)  
**Disciplina:** Paradigmas de Linguagens de Programação  
**Implementação:** paradigma declarativo / funcional (sem referência a linguagem específica)

---

## Introdução

O **Gerenciador de Vida Acadêmica (GVA)** é um sistema modular projetado para auxiliar estudantes na organização de sua rotina acadêmica: disciplinas, atividades, horários e acompanhamento de desempenho. Este documento descreve a organização do projeto, a participação dos integrantes e — com ênfase teórica — a relação conceitual entre o sistema e o **paradigma lógico**.

A proposta do GVA é apresentar uma **modelagem declarativa do domínio acadêmico**, onde conhecimento é representado de forma explícita e regras são usadas para inferir novos fatos a partir dos existentes. Mesmo sendo implementado numa linguagem funcional/imperativa no código, o projeto foi pensado para enfatizar os princípios do paradigma lógico: fatos, regras e consultas.

---

## Objetivo deste documento

1. Apresentar a arquitetura e responsabilidades do projeto.  
2. Documentar a participação dos integrantes, mantendo os nomes exatamente como previstos no arquivo original.  
3. Explicitar, com profundidade teórica, como os conceitos do **paradigma lógico** se aplicam ao GVA e de que forma o sistema materializa essas ideias.

(Arquivo original analisado e utilizado como base: fileciteturn0file0)

---

## Organização geral do projeto

O sistema foi organizado de forma modular, com cada componente tendo responsabilidade bem definida para facilitar manutenção, testes e evolução.

Estrutura conceitual (exemplo):

```
Main
Types
Disciplinas
Atividades
Horarios
Persistence
```

Cada módulo contém um conjunto de operações puras (ou que isolam efeitos) que manipulam estruturas de dados que representam o conhecimento do domínio.

---

## Participação dos integrantes (mantidos exatamente)

### Arthur — Módulo Main

Responsável pelo ponto de entrada do sistema e pela orquestração das chamadas entre módulos. Implementou a interface textual (CLI), fluxo de menu e roteamento de consultas.

Principais responsabilidades técnicas:
- Coordenação de execução e invocação de operações.
- Separação entre lógica de negócio e código de I/O (operações com efeitos).
- Composição de funções para construir fluxos reutilizáveis.


### Gustavo — Módulo Types

Responsável pela modelagem de dados do sistema: definiu as estruturas que representam disciplinas, atividades, horários e o estado global.

Principais responsabilidades técnicas:
- Definição dos tipos de domínio.
- Validação estrutural de dados.
- Garantia de coerência semântica entre módulos.


### Leandro — Módulos Persistence e Horarios

Responsável pela persistência dos dados e pelo controle da grade de horários.

Principais responsabilidades técnicas:
- Serialização / desserialização do estado do sistema.
- Leitura e escrita segura de arquivos de armazenamento.
- Inserção, remoção e verificação de conflitos de horários.


### Oscar — Módulo Disciplinas

Responsável pelo gerenciamento de disciplinas: cadastro, remoção, listagem e preparação de dados para cálculos acadêmicos (como o IRA).

Principais responsabilidades técnicas:
- Manipulação de coleções de disciplinas.
- Geração de relatórios e dados agregados.


### Igor — Módulo Atividades

Responsável pelo gerenciamento de atividades acadêmicas: criação, atualização de status, listagem e vinculação com disciplinas.

Principais responsabilidades técnicas:
- Modelagem das atividades como entidades do domínio.
- Operações puras de transformação sobre coleções de atividades.

---

## Modelagem conceitual e relação com o Paradigma Lógico

Abaixo apresentamos um mapeamento detalhado entre conceitos do paradigma lógico e os artefatos do GVA, seguido por considerações teóricas relevantes.

### Mapeamento entre paradigma lógico e GVA

| Paradigma Lógico | Representação no GVA |
|------------------|----------------------|
| Fato             | Estrutura de dado (registro/objeto) que descreve uma entidade (ex.: disciplina, atividade, bloco de horário) |
| Regra            | Função pura que deriva informação a partir de fatos (ex.: cálculo de IRA, detecção de conflitos) |
| Consulta         | Chamadas às funções que filtram/consultam o estado do sistema |
| Base de conhecimento | Conjunto de estruturas de dados que representam o estado atual (em memória ou persistido) |
| Inferência       | Composição de funções e aplicação de regras para gerar novo conhecimento ou resposta |

### Fundamentos teóricos explorados

1. **Representação de conhecimento** — No paradigma lógico, o conhecimento é codificado como fatos e regras. No GVA, cada entidade do domínio (disciplina, atividade, horário) é explicitada em estruturas de dados; essas estruturas são os "fatos" da nossa base.

2. **Regras e inferência** — Regras lógicas (como implicações) são análogas às funções que, dadas coleções de fatos, retornam conclusões: por exemplo, uma função que identifica atividades pendentes ou que computa o IRA a partir de notas e cargas horárias.

3. **Unificação e correspondência** — Embora unificação (matching) seja um mecanismo nativo em linguagens lógicas, o GVA reproduz esse comportamento por meio de padrões de combinação e filtragem (pattern matching em linguagens funcionais / comparações estruturais em outras). Isso permite encontrar fatos que satisfaçam um padrão (ex.: todas as atividades com prazo em uma data específica).

4. **Backtracking e busca** — Em Prolog o backtracking permite explorar alternativas automaticamente. No GVA, algoritmos de busca e filtros podem ser escritos para simular essa exploração: por exemplo, tentar combinações de horários até encontrar uma grade sem conflito.

5. **Horn clauses e clausulação** — Muitas regras úteis podem ser entendidas como cláusulas de Horn (uma conclusão derivada de um conjunto de premissas). No nosso contexto, uma função que determina "aluno em risco" a partir de condições (IRA baixo, muitas atividades pendentes) equivale a uma regra composta por premissas.

6. **Base de conhecimento dinâmica** — A persistência das estruturas de dados permite manter e evoluir a base de conhecimento ao longo do tempo: inserções, remoções e atualizações alteram o conjunto de fatos disponíveis para inferência.

---

## Exemplos conceituais (pseudo-regras / pseudocódigo)

A seguir, exemplos ilustrativos que mostram como formular regras e consultas em estilo lógico, traduzidas para uma representação declarativa agnóstica de linguagem.

### Exemplo 1 — Fatos (representação)

- Disciplina(ID, Código, Nome, CH, Situação, Período)
- Atividade(ID, DisciplinaID, Título, Tipo, Status, Prazo)
- BlocoHorario(Dia, Inicio, Fim, DisciplinaID)

### Exemplo 2 — Regra: Atividades pendentes

```
AtividadesPendentes(Estado) = filter(atividade -> atividade.status == PENDENTE, Estado.atividades)
```

### Exemplo 3 — Regra: Conflito de horários

```
Conflito(blocoA, blocoB) = (blocoA.dia == blocoB.dia) && (intervalsOverlap(blocoA.inicio, blocoA.fim, blocoB.inicio, blocoB.fim))

ExisteConflito(grade) = exists(pairs in grade, Conflito(pair.a, pair.b))
```

### Exemplo 4 — Regra: Cálculo simplificado de IRA

```
IRA = sum_over_disciplinas(nota * peso) / sum_over_disciplinas(peso)

onde peso pode ser definido pela carga horária
```

Esses exemplos mostram como regras declarativas podem ser expressas e aplicadas à base de fatos para derivar conhecimento.

---

## Boas práticas adotadas e recomendações arquiteturais

- **Separação clara entre código puro e operações de I/O**: facilita testes e raciocínio formal sobre o sistema.
- **Modelagem explícita do domínio**: usar tipos/estruturas autoexplicativas para facilitar a analogia com fatos lógicos.
- **Isolamento das regras de negócio**: concentrar inferências em funções puras que recebem um estado e retornam conclusões, aproximando-se do comportamento de um motor lógico.
- **Persistência controlada**: manter serialização/deserialização centralizada para preservar a consistência da base de conhecimento.
- **Testes baseados em exemplos lógicos**: criar casos de teste que funcionem como "consultas" e validem as regras de inferência.

---

## Considerações finais

Este documento apresenta o GVA sob o viés da modelagem declarativa e da teoria do paradigma lógico, mantendo a identificação dos integrantes conforme o arquivo original. A versão apresentada aqui **não faz referência a nenhuma linguagem específica** e foca em explicar como os conceitos lógicos foram aplicados ao projeto, tornando-o um material adequado para relatório de disciplina e para conferência técnica.

Se desejarem, posso gerar:
- um README.md pronto para o repositório com seções resumidas e instruções de uso;  
- diagramas conceituais (modelo entidade-relacionamento e fluxo de inferência);  
- exemplos de testes/consultas na forma de scripts que simulam consultas lógicas.

---

*Documento gerado com base no arquivo original enviado e analisado.*

