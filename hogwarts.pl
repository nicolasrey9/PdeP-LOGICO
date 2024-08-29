ago(harry, sangre(mestiza), [coraje, amistoso, orgullo, inteligencia]).
mago(draco, sangre(pura), [orgullo, inteligencia]).
mago(hermione, sangre(impura), [orgullo, inteligencia, responsabilidad]).

odiariaQuedar(harry, slytherin).
odiariaQuedar(harry, hufflepuff).

casa(slytherin).
casa(hufflepuff).
casa(gryffindor).
casa(ravenclaw).

busca(gryffindor, coraje).
busca(slytherin, orgullo).
busca(slytherin, inteligencia).
busca(ravenclaw, inteligencia).
busca(ravenclaw, responsabilidad).
busca(hufflepuff, amistoso).


mago(Mago):-
    mago(Mago, _, _).

sangreImpura(Mago):-
    mago(Mago, sangre(impura), _).


%%%%%%%%%%%%%%%%%
%%%% Punto 1 %%%%
%%%%%%%%%%%%%%%%%
permiteEntrar(Mago, Casa):-
    casa(Casa),
    mago(Mago),
    Casa \= slytherin.
permiteEntrar(Mago, slytherin):-
    mago(Mago),
    not(sangreImpura(Mago)).

%%%%%%%%%%%%%%%%%
%%%% Punto 2 %%%%
%%%%%%%%%%%%%%%%%
tieneCaracter(Mago, Casa):-
    casa(Casa),
    mago(Mago, _, Caracteristicas),
    forall(busca(Casa, LoQueSeBusca), member(LoQueSeBusca, Caracteristicas)).

%%%%%%%%%%%%%%%%%
%%%% Punto 3 %%%%
%%%%%%%%%%%%%%%%%
podriaQuedar(hermione, gryffindor).
podriaQuedar(Mago, Casa):-
    tieneCaracter(Mago, Casa),
    permiteEntrar(Mago, Casa),
    not(odiariaQuedar(Mago, Casa)).


%%%%%%%%%%%%%%%%%
%%%% Punto 4 %%%%
%%%%%%%%%%%%%%%%%

amistoso(Mago):-
    mago(Mago, _, Caracteristicas),
    member(amistoso, Caracteristicas).

cadenaDeAmistades(Amigos):-
    forall(member(Amigo, Amigos), amistoso(Amigo)),
    cadenaDeCasas(Amigos).


cadenaDeCasas([_]).
cadenaDeCasas([UnAmigo, OtroAmigo | Amigos]):-
    podriaQuedar(UnAmigo, UnaCasa),
    podriaQuedar(OtroAmigo, UnaCasa),
    cadenaDeCasas([OtroAmigo | Amigos]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% PARTE 2 %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).

% accion(Persona, Accion()).
accion(harry, fueraDeCama).
accion(hermione, irA(tercerPiso)).
accion(hermione, irA(biblioteca)).
accion(harry, irA(bosque)).
accion(harry, irA(tercerPiso)).
accion(draco, irA(mazmorras)).
accion(ron, ganarPartidaDeAjedrez).
accion(hermione, salvarAmigos).
accion(harry, ganarAVoldemort).

puntaje(fueraDeCama, -50).
puntaje(ganarPartidaDeAjedrez, 50).
puntaje(salvarAmigos, 50).
puntaje(ganarAVoldemort, 60).
puntaje(irA(Lugar), 0):- not(prohibido(Lugar, _)).
puntaje(irA(Lugar), Puntaje):- prohibido(Lugar, Puntaje).

prohibido(bosque, -50).
prohibido(biblioteca, -10).
prohibido(tercerPiso, -75).

buenaAccion(Accion):-
    puntaje(Accion, Puntaje),
    Puntaje >= 0.

malaAccion(Accion):- not(buenaAccion(Accion)).

%%%%%%%%%%%%%%%%%
%%%% Punto 1 %%%%
%%%%%%%%%%%%%%%%%
esBuenAlumno(Mago):-
    accion(Mago, _),
    not((accion(Mago, UnaAccion), malaAccion(UnaAccion))).

esRecurrente(Accion):-
    accion(UnMago, Accion),
    accion(OtroMago, Accion),
    UnMago \= OtroMago.


%%%%%%%%%%%%%%%%%
%%%% Punto 2 %%%%
%%%%%%%%%%%%%%%%%
puntajeTotal(Casa, PuntajeTotal):-
    casa(Casa),
    findall(Puntaje, (esDe(UnMago, Casa), puntajeMago(UnMago, Puntaje)), Puntajes),
    sum_list(Puntajes, PuntajeTotal).

puntajeMago(UnMago, Puntaje):-
    accion(UnMago, Accion), 
    puntaje(Accion, Puntaje).


%%%%%%%%%%%%%%%%%
%%%% Punto 3 %%%%
%%%%%%%%%%%%%%%%%
casaGanadora(Casa):-
    puntajeTotal(Casa, PuntajeMax),
    forall(puntajeTotal(_, Puntajes), PuntajeMax >= Puntajes).

%%%%%%%%%%%%%%%%%
%%%% Punto 4 %%%%
%%%%%%%%%%%%%%%%%
accion(hermione, responderPregunta(dondeSeEncuentraUnBezoar)).
accion(hermione, responderPregunta(comoHacerLevitarUnaPluma)).


puntaje(responderPregunta(Pregunta), Puntaje):-
    pregunta(Pregunta, Puntaje, Profesor),
    Profesor \= snape.
puntaje(responderPregunta(Pregunta), Puntaje):-
    pregunta(Pregunta, Dificultad, snape),
    Puntaje is Dificultad / 2.


pregunta(dondeSeEncuentraUnBezoar, 20, snape).
pregunta(comoHacerLevitarUnaPluma, 25, flitwick).

