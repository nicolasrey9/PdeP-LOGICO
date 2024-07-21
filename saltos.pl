puntajes(hernan,[3,5,8,6,9]).
puntajes(julio,[9,7,3,9,10,2]).
puntajes(ruben,[3,5,3,8,3]).
puntajes(roque,[7,10,10]).


puntaje(Competidor, Salto, Puntaje):-
    puntajes(Competidor, Saltos),
    nth1(Salto, Saltos, Puntaje).


descalificado(Competidor):-
    puntajes(Competidor, Saltos),
    length(Saltos, Cantidad),
    Cantidad > 5.
    
final(Competidor):-
    puntajes(Competidor, Saltos),
    sumlist(Saltos, PuntajeTotal),
    PuntajeTotal >= 28.
final(Competidor):-
    puntajes(Competidor, Saltos),
    findall(Puntaje, (member(Puntaje, Saltos), Puntaje >= 8), BuenosPuntajes),
    length(BuenosPuntajes, Cantidad),
    Cantidad >= 2.

