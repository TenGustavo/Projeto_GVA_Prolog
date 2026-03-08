src/horarios.pl
modulo_horarios :-
    nl,
    writeln('==== Horarios ===='),
    writeln('1) Adicionar bloco (impede choque)'),
    writeln('2) Remover bloco'),
    writeln('3) Listar horario semanal'),
    writeln('0) Voltar'),
    ler_inteiro('Escolha: ', Op),
    tratar_opcao_horarios(Op).

tratar_opcao_horarios(0).
tratar_opcao_horarios(1) :- adicionar_bloco, modulo_horarios.
tratar_opcao_horarios(2) :- remover_bloco, modulo_horarios.
tratar_opcao_horarios(3) :- listar_blocos, modulo_horarios.
tratar_opcao_horarios(_) :-
    writeln('Opcao invalida.'),
    modulo_horarios.

adicionar_bloco :-
    ler_inteiro('Dia (0=Dom,1=Seg,...,6=Sab): ', Dia),
    ler_texto('Inicio (HH:MM): ', InicioTxt),
    ler_texto('Fim (HH:MM): ', FimTxt),
    ( parse_hora_min(InicioTxt, Inicio),
      parse_hora_min(FimTxt, Fim),
      Inicio < Fim ->
        writeln('Tipo: 1) aula  2) compromisso'),
        ler_inteiro('Escolha: ', OpTipo),
        opcao_tipo_bloco(OpTipo, Tipo),
        escolher_disciplina_bloco(Tipo, IdDisc),
        ler_texto('Rotulo: ', Rotulo),
        verificar_e_salvar_bloco(Dia, Inicio, Fim, Tipo, IdDisc, Rotulo)
    ;
        writeln('Horario invalido. Use HH:MM e inicio < fim.')
    ).

opcao_tipo_bloco(1, aula).
opcao_tipo_bloco(_, compromisso).

escolher_disciplina_bloco(aula, IdDisc) :-
    listar_disciplinas,
    ler_inteiro('ID da disciplina (ou 0 para nao vincular): ', Id),
    ( Id =:= 0 ->
        IdDisc = none
    ; disciplina(Id, _, _, _, _, _, _, _, _) ->
        IdDisc = Id
    ;
        writeln('Disciplina invalida. Bloco ficara sem vinculo.'),
        IdDisc = none
    ).
escolher_disciplina_bloco(compromisso, none).

verificar_e_salvar_bloco(Dia, Inicio, Fim, Tipo, IdDisc, Rotulo) :-
    findall((Id, Dia2, Ini2, Fim2, Tipo2, Rot2),
            (bloco(Id, Dia2, Ini2, Fim2, Tipo2, _, Rot2),
             conflita(Dia, Inicio, Fim, Dia2, Ini2, Fim2)),
            Conflitos),
    ( Conflitos = [] ->
        proximo_id(bloco, Id),
        assertz(bloco(Id, Dia, Inicio, Fim, Tipo, IdDisc, Rotulo)),
        salvar_dados,
        writeln('Bloco inserido e salvo.')
    ;
        writeln('Conflito detectado. Nao foi possivel inserir.'),
        writeln('Conflita com:'),
        imprimir_conflitos(Conflitos)
    ).

imprimir_conflitos([]).
imprimir_conflitos([(Id, Dia, Ini, Fim, Tipo, Rotulo)|Resto]) :-
    dia_nome(Dia, NomeDia),
    fmt_hora(Ini, HIni),
    fmt_hora(Fim, HFim),
    format('- #~w ~w ~w-~w (~w) ~w~n', [Id, NomeDia, HIni, HFim, Tipo, Rotulo]),
    imprimir_conflitos(Resto).

remover_bloco :-
    listar_blocos,
    ler_inteiro('ID do bloco para remover: ', Id),
    ( retract(bloco(Id, _, _, _, _, _, _)) ->
        salvar_dados,
        writeln('Bloco removido e salvo.')
    ;
        writeln('Bloco nao encontrado.')
    ).

listar_blocos :-
    nl,
    writeln('Horario semanal:'),
    findall((Dia, Inicio, Id, Fim, Tipo, IdDisc, Rotulo),
            bloco(Id, Dia, Inicio, Fim, Tipo, IdDisc, Rotulo),
            Lista),
    sort(Lista, Ordenada),
    ( Ordenada = [] ->
        writeln('(vazio)')
    ;
        imprimir_blocos(Ordenada)
    ).

imprimir_blocos([]).
imprimir_blocos([(Dia, Inicio, Id, Fim, Tipo, IdDisc, Rotulo)|Resto]) :-
    dia_nome(Dia, NomeDia),
    fmt_hora(Inicio, HIni),
    fmt_hora(Fim, HFim),
    texto_opcional(IdDisc, IdDiscTxt),
    format('# ~w | ~w | ~w-~w | ~w | Disc=~w | ~w~n',
           [Id, NomeDia, HIni, HFim, Tipo, IdDiscTxt, Rotulo]),
    imprimir_blocos(Resto).