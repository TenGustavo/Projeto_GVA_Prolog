src/atividades.pl
modulo_atividades :-
    nl,
    writeln('==== Atividades/Trabalhos ===='),
    writeln('1) Criar atividade'),
    writeln('2) Listar atividades'),
    writeln('3) Atualizar status'),
    writeln('4) Remover atividade'),
    writeln('0) Voltar'),
    ler_inteiro('Escolha: ', Op),
    tratar_opcao_atividades(Op).

tratar_opcao_atividades(0).
tratar_opcao_atividades(1) :- criar_atividade, modulo_atividades.
tratar_opcao_atividades(2) :- listar_atividades, modulo_atividades.
tratar_opcao_atividades(3) :- atualizar_status_atividade, modulo_atividades.
tratar_opcao_atividades(4) :- remover_atividade, modulo_atividades.
tratar_opcao_atividades(_) :-
    writeln('Opcao invalida.'),
    modulo_atividades.

criar_atividade :-
    ( disciplina(_,_,_,_,_,_,_,_,_) ->
        true
    ;
        writeln('Cadastre uma disciplina antes.'),
        !
    ),
    listar_disciplinas,
    ler_inteiro('ID da disciplina: ', IdDisc),
    ( disciplina(IdDisc, _, _, _, _, _, _, _, _) ->
        ler_texto('Titulo: ', Titulo),
        ler_texto('Descricao: ', Descricao),
        writeln('Tipo: 1) tarefa  2) prova  3) trabalho  4) projeto  5) leitura  6) outro'),
        ler_inteiro('Escolha: ', OpTipo),
        opcao_tipo_atividade(OpTipo, Tipo),
        ler_texto('Prazo (texto): ', Prazo),
        proximo_id(atividade, Id),
        assertz(atividade(Id, IdDisc, Titulo, Descricao, Tipo, pendente, Prazo)),
        salvar_dados,
        writeln('Atividade criada e salva.')
    ;
        writeln('Disciplina invalida.')
    ).

opcao_tipo_atividade(1, tarefa).
opcao_tipo_atividade(2, prova).
opcao_tipo_atividade(3, trabalho).
opcao_tipo_atividade(4, projeto).
opcao_tipo_atividade(5, leitura).
opcao_tipo_atividade(_, outro).

listar_atividades :-
    nl,
    writeln('Atividades:'),
    ( atividade(_,_,_,_,_,_,_) ->
        forall(
            atividade(Id, IdDisc, Titulo, _, Tipo, Status, Prazo),
            format('# ~w | Disc=~w | ~w | ~w | ~w | Prazo: ~w~n',
                   [Id, IdDisc, Status, Tipo, Titulo, Prazo])
        )
    ;
        writeln('(vazio)')
    ).

atualizar_status_atividade :-
    listar_atividades,
    ler_inteiro('ID da atividade: ', Id),
    ( retract(atividade(Id, IdDisc, Titulo, Desc, Tipo, _, Prazo)) ->
        writeln('Novo status: 1) pendente  2) em_andamento  3) concluido'),
        ler_inteiro('Escolha: ', Op),
        opcao_status(Op, NovoStatus),
        assertz(atividade(Id, IdDisc, Titulo, Desc, Tipo, NovoStatus, Prazo)),
        salvar_dados,
        writeln('Status atualizado e salvo.')
    ;
        writeln('Atividade nao encontrada.')
    ).

opcao_status(1, pendente).
opcao_status(2, em_andamento).
opcao_status(3, concluido).
opcao_status(_, pendente).

remover_atividade :-
    listar_atividades,
    ler_inteiro('ID da atividade para remover: ', Id),
    ( retract(atividade(Id, _, _, _, _, _, _)) ->
        salvar_dados,
        writeln('Atividade removida e salva.')
    ;
        writeln('Atividade nao encontrada.')
    ).
