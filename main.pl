
:- consult('src/util.pl').
:- consult('src/persistencia.pl').
:- consult('src/disciplinas.pl').
:- consult('src/atividades.pl').
:- consult('src/horarios.pl').
:- consult('src/ira.pl').

iniciar :-
    carregar_dados,
    menu_principal.

menu_principal :-
    nl,
    writeln('=== Gerenciador de Vida Academica (GVA) - Prolog ==='),
    writeln('(Persistencia: data/gva_db.pl)'),
    mostrar_alertas_simples,
    nl,
    writeln('1) Disciplinas'),
    writeln('2) Atividades/Trabalhos'),
    writeln('3) Agenda (melhoria futura)'),
    writeln('4) Desempenho (IRA UFCG)'),
    writeln('5) Notificacoes (antecedencia)'),
    writeln('6) Horarios (com bloqueio de choque)'),
    writeln('0) Sair'),
    ler_inteiro('Escolha: ', Op),
    tratar_opcao_principal(Op).

tratar_opcao_principal(0) :-
    salvar_dados,
    writeln('Estado salvo. Encerrando.').

tratar_opcao_principal(1) :-
    modulo_disciplinas,
    menu_principal.

tratar_opcao_principal(2) :-
    modulo_atividades,
    menu_principal.

tratar_opcao_principal(3) :-
    writeln('Agenda: para manter simples, ficou como melhoria futura.'),
    menu_principal.

tratar_opcao_principal(4) :-
    nl,
    writeln('=== Desempenho: IRA UFCG (Individual) ==='),
    ira_individual(IRA),
    format('IRA (escala ~0..10): ~2f~n', [IRA]),
    IRA1000 is IRA * 1000,
    format('IRA x 1000: ~2f~n', [IRA1000]),
    writeln('Obs: so entra no IRA quem tem Nota Final e Periodo.'),
    menu_principal.

tratar_opcao_principal(5) :-
    configurar_notificacoes,
    menu_principal.

tratar_opcao_principal(6) :-
    modulo_horarios,
    menu_principal.

tratar_opcao_principal(_) :-
    writeln('Opcao invalida.'),
    menu_principal.

mostrar_alertas_simples :-
    findall((Status, Titulo, Prazo),
            (atividade(_, _, Titulo, _, _, Status, Prazo), Status \= concluido),
            Lista),
    ( Lista = [] ->
        true
    ;
        nl,
        writeln('ALERTAS (simples): atividades nao concluidas:'),
        primeiros_n(5, Lista, Primeiros),
        imprimir_alertas(Primeiros)
    ).

imprimir_alertas([]).
imprimir_alertas([(Status, Titulo, Prazo)|Resto]) :-
    format('- [~w] ~w (prazo: ~w)~n', [Status, Titulo, Prazo]),
    imprimir_alertas(Resto).

configurar_notificacoes :-
    nl,
    ( preferencia(Horas) ->
        format('Antecedencia atual (horas): ~w~n', [Horas])
    ;
        writeln('Antecedencia atual (horas): 48')
    ),
    ler_inteiro('Nova antecedencia em horas: ', NovaHoras),
    retractall(preferencia(_)),
    assertz(preferencia(NovaHoras)),
    salvar_dados,
    writeln('Preferencia salva.').
