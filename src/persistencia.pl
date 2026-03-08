src/persistencia.pl
:- use_module(library(filesex)).

:- dynamic disciplina/9.
:- dynamic atividade/7.
:- dynamic bloco/7.
:- dynamic preferencia/1.
:- dynamic contador/2.

garantir_pasta_dados :-
    ( exists_directory('data') ->
        true
    ;
        make_directory_path('data')
    ).

inicializar_banco :-
    retractall(disciplina(_,_,_,_,_,_,_,_,_)),
    retractall(atividade(_,_,_,_,_,_,_)),
    retractall(bloco(_,_,_,_,_,_,_)),
    retractall(preferencia(_)),
    retractall(contador(_,_)),
    assertz(preferencia(48)),
    assertz(contador(disciplina, 1)),
    assertz(contador(atividade, 1)),
    assertz(contador(bloco, 1)).

carregar_dados :-
    garantir_pasta_dados,
    inicializar_banco,
    ( exists_file('data/gva_db.pl') ->
        catch(consult('data/gva_db.pl'), _, writeln('Aviso: banco invalido. Iniciando vazio.'))
    ;
        true
    ),
    garantir_fatos_basicos.

garantir_fatos_basicos :-
    ( preferencia(_) -> true ; assertz(preferencia(48)) ),
    ( contador(disciplina, _) -> true ; assertz(contador(disciplina, 1)) ),
    ( contador(atividade, _) -> true ; assertz(contador(atividade, 1)) ),
    ( contador(bloco, _) -> true ; assertz(contador(bloco, 1)) ).

salvar_dados :-
    garantir_pasta_dados,
    open('data/gva_db.pl', write, Stream),
    write(Stream, ':- dynamic disciplina/9.'), nl(Stream),
    write(Stream, ':- dynamic atividade/7.'), nl(Stream),
    write(Stream, ':- dynamic bloco/7.'), nl(Stream),
    write(Stream, ':- dynamic preferencia/1.'), nl(Stream),
    write(Stream, ':- dynamic contador/2.'), nl(Stream), nl(Stream),

    forall(disciplina(A,B,C,D,E,F,G,H,I),
           (writeq(Stream, disciplina(A,B,C,D,E,F,G,H,I)), write(Stream, '.'), nl(Stream))),

    forall(atividade(A,B,C,D,E,F,G),
           (writeq(Stream, atividade(A,B,C,D,E,F,G)), write(Stream, '.'), nl(Stream))),

    forall(bloco(A,B,C,D,E,F,G),
           (writeq(Stream, bloco(A,B,C,D,E,F,G)), write(Stream, '.'), nl(Stream))),

    forall(preferencia(A),
           (writeq(Stream, preferencia(A)), write(Stream, '.'), nl(Stream))),

    forall(contador(A,B),
           (writeq(Stream, contador(A,B)), write(Stream, '.'), nl(Stream))),

    close(Stream).

proximo_id(Tipo, Id) :-
    retract(contador(Tipo, Id)),
    Novo is Id + 1,
    assertz(contador(Tipo, Novo)).