modulo_disciplinas :-
    nl,
    writeln('==== Disciplinas ===='),
    writeln('1) Cadastrar disciplina'),
    writeln('2) Listar disciplinas'),
    writeln('3) Remover disciplina'),
    writeln('4) Editar situacao'),
    writeln('5) Registrar nota final e periodo'),
    writeln('0) Voltar'),
    ler_inteiro('Escolha: ', Op),
    tratar_opcao_disciplinas(Op).

tratar_opcao_disciplinas(0).
tratar_opcao_disciplinas(1) :- cadastrar_disciplina, modulo_disciplinas.
tratar_opcao_disciplinas(2) :- listar_disciplinas, modulo_disciplinas.
tratar_opcao_disciplinas(3) :- remover_disciplina, modulo_disciplinas.
tratar_opcao_disciplinas(4) :- editar_situacao_disciplina, modulo_disciplinas.
tratar_opcao_disciplinas(5) :- registrar_nota_periodo, modulo_disciplinas.
tratar_opcao_disciplinas(_) :-
    writeln('Opcao invalida.'),
    modulo_disciplinas.

listar_disciplinas :-
    nl,
    writeln('Disciplinas:'),
    ( disciplina(_,_,_,_,_,_,_,_,_) ->
        forall(
            disciplina(Id, Codigo, Nome, Professor, CH, Situacao, Semestre, Nota, Periodo),
            (
                texto_opcional(Nota, NotaTxt),
                texto_opcional(Periodo, PeriodoTxt),
                format('# ~w - ~w: ~w | Prof=~w | CH=~w | ~w | Sem=~w | NotaFinal=~w | Periodo=~w~n',
                       [Id, Codigo, Nome, Professor, CH, Situacao, Semestre, NotaTxt, PeriodoTxt])
            )
        )
    ;
        writeln('(vazio)')
    ).

cadastrar_disciplina :-
    ler_texto('Codigo: ', Codigo),
    ( disciplina(_, Codigo, _, _, _, _, _, _, _) ->
        writeln('Ja existe disciplina com esse codigo.'),
        !
    ;
        ler_texto('Nome: ', Nome),
        ler_texto('Professor: ', Professor),
        ler_inteiro('Carga horaria: ', CH),
        ler_texto('Semestre (ex: 2025.2): ', Semestre),
        writeln('Situacao: 1) cursando  2) concluida  3) trancada  4) planejada'),
        ler_inteiro('Escolha: ', OpSit),
        opcao_situacao(OpSit, Situacao),
        proximo_id(disciplina, Id),
        assertz(disciplina(Id, Codigo, Nome, Professor, CH, Situacao, Semestre, none, none)),
        salvar_dados,
        writeln('Disciplina cadastrada e salva.')
    ).

opcao_situacao(1, cursando).
opcao_situacao(2, concluida).
opcao_situacao(3, trancada).
opcao_situacao(4, planejada).
opcao_situacao(_, cursando).

remover_disciplina :-
    listar_disciplinas,
    ler_inteiro('ID da disciplina para remover: ', Id),
    ( retract(disciplina(Id, _, _, _, _, _, _, _, _)) ->
        retractall(atividade(_, Id, _, _, _, _, _)),
        desvincular_blocos_disciplina(Id),
        salvar_dados,
        writeln('Disciplina removida. Atividades ligadas foram removidas; blocos foram desvinculados.')
    ;
        writeln('Disciplina nao encontrada.')
    ).

desvincular_blocos_disciplina(IdDisc) :-
    forall(
        retract(bloco(Id, Dia, Ini, Fim, Tipo, IdDisc, Rotulo)),
        assertz(bloco(Id, Dia, Ini, Fim, Tipo, none, Rotulo))
    ).

editar_situacao_disciplina :-
    listar_disciplinas,
    ler_inteiro('ID da disciplina: ', Id),
    ( retract(disciplina(Id, Codigo, Nome, Professor, CH, _, Semestre, Nota, Periodo)) ->
        writeln('Nova situacao: 1) cursando  2) concluida  3) trancada  4) planejada'),
        ler_inteiro('Escolha: ', OpSit),
        opcao_situacao(OpSit, NovaSituacao),
        assertz(disciplina(Id, Codigo, Nome, Professor, CH, NovaSituacao, Semestre, Nota, Periodo)),
        salvar_dados,
        writeln('Situacao atualizada e salva.')
    ;
        writeln('Disciplina nao encontrada.')
    ).

registrar_nota_periodo :-
    listar_disciplinas,
    ler_inteiro('ID da disciplina: ', Id),
    ( retract(disciplina(Id, Codigo, Nome, Professor, CH, Situacao, Semestre, _, _)) ->
        ler_real('Nota final (Ni): ', Nota),
        ler_inteiro('Periodo/semestre em que foi cursada (Pi): ', Periodo),
        assertz(disciplina(Id, Codigo, Nome, Professor, CH, Situacao, Semestre, Nota, Periodo)),
        salvar_dados,
        writeln('Nota e periodo registrados e salvos.')
    ;
        writeln('Disciplina nao encontrada.')
    ).
