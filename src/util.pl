src/util.pl
:- use_module(library(readutil)).

ler_string(Mensagem, Texto) :-
    write(Mensagem),
    read_line_to_string(user_input, Texto).

ler_texto(Mensagem, Atom) :-
    ler_string(Mensagem, Texto),
    atom_string(Atom, Texto).

ler_inteiro(Mensagem, Numero) :-
    repeat,
    ler_string(Mensagem, Texto),
    ( catch(number_string(N, Texto), _, fail),
      integer(N) ->
        Numero = N
    ;
        writeln('Entrada invalida. Digite um numero inteiro.'),
        fail
    ).

ler_real(Mensagem, Numero) :-
    repeat,
    ler_string(Mensagem, Texto),
    ( catch(number_string(N, Texto), _, fail) ->
        Numero = N
    ;
        writeln('Entrada invalida. Digite um numero.'),
        fail
    ).

dia_nome(0, 'Dom').
dia_nome(1, 'Seg').
dia_nome(2, 'Ter').
dia_nome(3, 'Qua').
dia_nome(4, 'Qui').
dia_nome(5, 'Sex').
dia_nome(6, 'Sab').

fmt_hora(Minutos, Texto) :-
    H is Minutos // 60,
    M is Minutos mod 60,
    format(atom(Texto), '~|~`0t~d~2+:~|~`0t~d~2+', [H, M]).

parse_hora_min(AtomOuString, Minutos) :-
    ( atom(AtomOuString) -> atom_string(AtomOuString, S) ; S = AtomOuString ),
    split_string(S, ":", "", [SH, SM]),
    number_string(H, SH),
    number_string(M, SM),
    H >= 0, H =< 23,
    M >= 0, M =< 59,
    Minutos is H * 60 + M.

conflita(Dia, Ini1, Fim1, Dia, Ini2, Fim2) :-
    Ini1 < Fim2,
    Fim1 > Ini2.

texto_opcional(none, '-') :- !.
texto_opcional(Valor, Valor).

primeiros_n(_, [], []).
primeiros_n(0, _, []) :- !.
primeiros_n(N, [X|Xs], [X|Ys]) :-
    N > 0,
    N1 is N - 1,
    primeiros_n(N1, Xs, Ys).
