% -*- prolog -*- 

% this defines morfeusz_analyse/2:
:-initialization(load_foreign_library(foreign('libmorfeusz-swi'))).

:-op(550, xfy, '.').

% morfeusz(+String, +Predicate, Start, Stop)
% redefines predicate Predicate/5: Predicate(from,to, form,base,tag)

morfeusz(String, _, _, _) :- var(String), !, fail.
morfeusz(_, Predicate, _, _) :- not(atom(Predicate)), !, fail.
morfeusz(String, Predicate, Start, Stop) :-
	morfeusz_analyse(String, MO),
	abolish(Predicate/5),
	rozbebesz(Predicate, Start, Stop, MO).

rozbebesz(_, 0, 0, []).
rozbebesz(Pred, Start, Stop, [i(Start, Stop, F, H, I)]) :- !,
	T =.. [Pred, Start, Stop, F, H, I],
	assertz(T).
rozbebesz(Pred, Start, Stop, [i(Start, K, F, H, I) | MOO]) :-
	T =.. [Pred, Start, K, F, H, I],
	assertz(T),
	rozbebesz(Pred, _, Stop, MOO).
