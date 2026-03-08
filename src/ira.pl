src/ira.pl
:- use_module(library(lists)).

ira_individual(IRA) :-
    findall(CH,
            disciplina(_, _, _, _, CH, trancada, _, _, _),
            ListaTrancadas),
    sumlist(ListaTrancadas, T),

    findall(CH2,
            disciplina(_, _, _, _, CH2, _, _, _, _),
            ListaTodas),
    sumlist(ListaTodas, C),

    findall((Peso, PesoNota),
            termo_ira(Peso, PesoNota),
            Termos),

    pesos(Termos, Pesos),
    pesos_notas(Termos, PesosNotas),
    sumlist(Pesos, Den),
    sumlist(PesosNotas, Num),

    ( Den =:= 0 ->
        MediaPond = 0
    ;
        MediaPond is Num / Den
    ),

    ( C =:= 0 ->
        Fator = 1
    ;
        Fator is 1 - (0.5 * T / C)
    ),

    IRA is Fator * MediaPond.

termo_ira(Peso, PesoNota) :-
    disciplina(_, _, _, _, CH, _, _, Nota, Periodo),
    Nota \= none,
    Periodo \= none,
    P is min(6, Periodo),
    Peso is P * CH,
    PesoNota is P * CH * Nota.

pesos([], []).
pesos([(P, _)|Resto], [P|Saida]) :-
    pesos(Resto, Saida).

pesos_notas([], []).
pesos_notas([(_, PN)|Resto], [PN|Saida]) :-
    pesos_notas(Resto, Saida).