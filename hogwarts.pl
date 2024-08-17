mago(harry, sangre(mestiza), [corajudo, amistoso, orgulloso, inteligente]).
mago(draco, sangre(pura), [orgulloso, inteligente]).
mago(hermione, sangre(impura), [orgulloso, inteligente, responsable]).

odiariaQuedar(harry, slytherin).
odiariaQuedar(harry, hufflepuff).

casa(slytherin).
casa(hufflepuff).
casa(gryffindor).
casa(ravenclaw).

mago(Mago):-
    mago(Mago, _, _).

sangreImpura(Mago):-
    mago(Mago, sangre(impura), _).


%%%%%%%%%%%%%%%%%
%%%% Punto 1 %%%%
%%%%%%%%%%%%%%%%%
permiteEntrar(Casa, Mago):-
    casa(Casa),
    mago(Mago),
    Casa \= slytherin.
permiteEntrar(slytherin, Mago):-
    mago(Mago),
    not(sangreImpura(Mago)).


