%Punto 1: El destino es asi, lo se... (2 puntos)

destino(dodain, pehuenia).
destino(dodain, sanMartin).
destino(dodain, esquel).
destino(dodain, sarmiento).
destino(dodain, camarones).
destino(dodain, playasDoradas).

destino(alf, sanMartin).
destino(alf, esquel).
destino(alf, bolson).

destino(nico, marDelPlata).

destino(vale, bolson).
destino(vale, calafate).

destino(martu, Destino):-
    destino(nico, Destino).
destino(martu, Destino):-
    destino(alf, Destino).


% Punto 2: Vacaciones copadas (4 puntos)
% atraccion(lugar, atraccion).
atraccion(esquel, parqueNacional(losAlerces)).
atraccion(esquel, excursion(trochita, 8)).
atraccion(esquel, excursion(trevelin, 8)).

atraccion(pehuenia, cerro(bateaMahuida, 2000)).
atraccion(pehuenia, cuerpoDeAgua(moquehue, si, 14)).
atraccion(pehuenia, cuerpoDeAgua(alumine, si, 19)).

atraccion(marDelPlata, parqueNacional(losGordos)).

%cuerpoDeAgua(Nombre, Pescar, Temp)
persona(Persona):- destino(Persona,_).

vacacionesCopadas(Persona):-
    persona(Persona),
    forall(destino(Persona, Lugar), tieneAtraccionCopada(Lugar)).
    
tieneAtraccionCopada(Lugar):-
    atraccion(Lugar, Atraccion),
    esCopada(Atraccion).

esCopada(cerro(_,Metros)):- Metros > 2000.
esCopada(cuerpoDeAgua(_, si, _)).
esCopada(cuerpoDeAgua(_, _, Temperatura)):- Temperatura > 20.
esCopada(playa(_, MareaPromedio)):- MareaPromedio < 5.
esCopada(excursion(_ , CantidadLetras)):- CantidadLetras > 7.
esCopada(parqueNacional(_)).


% playa(Nombre, MareaPromedio)
% excursion(Nombre, CantidadLetras).


% Punto 3: Ni se me cruzo por la cabeza (2 puntos)
noSeCruzaron(UnaPersona, OtraPersona):-
    persona(UnaPersona),
    persona(OtraPersona),
    UnaPersona \= OtraPersona,
    not((destino(UnaPersona, Lugar), destino(OtraPersona, Lugar))).

noSeCruzaron2(UnaPersona, OtraPersona):-
    destino(UnaPersona, Lugar),
    persona(OtraPersona),
    UnaPersona \= OtraPersona,
    not(destino(OtraPersona, Lugar)).


% Punto 4: Vacaciones gasoleras (2 puntos)

costoDeVida(sarmiento, 100).
costoDeVida(esquel, 150).
costoDeVida(pehuenia, 180).
costoDeVida(sanMartin, 150).
costoDeVida(camarones, 135).
costoDeVida(playasDoradas, 170).
costoDeVida(bariloche, 140).
costoDeVida(calafate, 240).
costoDeVida(bolson, 145).
costoDeVida(marDelPlata, 140).

vacacionesGasoleras(Persona):-
    persona(Persona),
    forall(destino(Persona, Lugar), esGasolero(Lugar)).

esGasolero(Lugar):-
    costoDeVida(Lugar, CostoDeVida),
    CostoDeVida < 160.

% Punto 5: Itinerarios posibles (3 puntos)

itinerariosPosibles(Persona, Itinerario):-
    persona(Persona),
    findall(Destino, destino(Persona, Destino), Destinos),
    length(Destinos, CantidadDeDestinos),
    armarItinerario(Destinos, CantidadDeDestinos, Itinerario).
    
armarItinerario(Destinos, Cantidad, Itinerario):-
    (forall(member(Miembro, Destinos), member(Miembro, Itinerario)),
    length(Itinerario, Cantidad)).

