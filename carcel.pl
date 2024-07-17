%% https://docs.google.com/document/d/12zUNFV4K7Iofc47FN-b7O-gXjTrqgP4dQh47yJVlvw0/edit

% guardia(Nombre)
guardia(bennett).
guardia(mendez).
guardia(george).

% prisionero(Nombre, Crimen)
prisionero(piper, narcotrafico([metanfetaminas])).
prisionero(alex, narcotrafico([heroina])).
prisionero(alex, homicidio(george)).
prisionero(red, homicidio(rusoMafioso)).
prisionero(suzanne, robo(450000)).
prisionero(suzanne, robo(250000)).
prisionero(suzanne, robo(2500)).
prisionero(dayanara, narcotrafico([heroina, opio])).
prisionero(dayanara, narcotrafico([metanfetaminas])).


% controla(Controlador, Controlado)
controla(piper, alex).
controla(bennett, dayanara).
controla(Guardia, Otro):- prisionero(Otro,_), guardia(Guardia), not(controla(Otro, Guardia)).


conflictoDeIntereses(Persona1, Persona2) :-
    controla(Persona1, X),
    controla(Persona2, X),
    not(controla(Persona1, Persona2)),
    not(controla(Persona2, Persona1)),
    Persona1 \= Persona2.


peligroso(Preso) :-
    prisionero(Preso, _),
    forall(prisionero(Preso, Crimenes), crimenGrave(Crimenes)).

crimenGrave(homicidio(_)).
crimenGrave(narcotráfico(Drogas)):-
    length(Drogas, Cantidad),
    Cantidad >= 5.
crimenGrave(narcotráfico(Drogas)):-
    member(metanfetaminas, Drogas).
    
    
ladronDeGuanteBlanco(Ladron):-
    prisionero(Ladron, _),
    forall(prisionero(Ladron, Crimenes), roboCaro(Crimenes)).

roboCaro(robo(Monto)) :- Monto > 100000.


condena(Prisionero, Condena):-
    prisionero(Prisionero, _),
    findall(Pena, (prisionero(Prisionero, Crimen), pena(Crimen, Pena)), PenaPorCrimen),
    sumlist(PenaPorCrimen, Condena).

pena(robo(Monto), Pena) :- Pena is Monto / 10000.
pena(homicidio(Muerto), 9) :- guardia(Muerto).
pena(homicidio(Muerto), 7) :- not(guardia(Muerto)).
pena(narcotrafico(Drogas), Pena) :- length(Drogas, Cantidad), Pena is Cantidad * 2.



capo(Capo):-
    prisionero(Capo, _),
    not(controla(_, Capo)),
    forall(persona(Persona), controlaDirectaOIndirectamente(Capo, Persona)).

controlaDirectaOIndirectamente(Dominador, Dominado):- controla(Dominador, Dominado).
controlaDirectaOIndirectamente(Dominador, Dominado):- 
    controlaDirectaOIndirectamente(Dominador, Intermediario), 
    controlaDirectaOIndirectamente(Intermediario, Dominado).

persona(Persona):- prisionero(Persona, _).
persona(Persona):- guardia(Persona).