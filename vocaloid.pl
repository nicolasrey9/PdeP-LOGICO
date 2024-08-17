canta(megurineLuka, [cancion(nightFever, 4), cancion(foreverYoung, 5)]).
canta(hatsuneMiku, [cancion(tellYourWorld, 4)]).
canta(gumi, [cancion(foreverYoung, 4), cancion(tellYourWorld, 5)]).
canta(seeU, [cancion(novemberRain, 6), cancion(nightFever, 5)]).


%%%%%%%%%%%%%%%%%
%%%% Punto 1 %%%%
%%%%%%%%%%%%%%%%%

duracionTotalDeCanciones(Canciones, DuracionTotal):-
    findall(Duracion, duracionDeCancion(Canciones, Duracion), Duraciones),
    sum_list(Duraciones, DuracionTotal).


novedoso(Vocaloid):-
    canta(Vocaloid, Canciones),
    cantidadMinimaDeCanciones(Canciones, 2),
    duracionTotalDeCanciones(Canciones, TiempoTotalDeCanciones),
    TiempoTotalDeCanciones < 15.
    
    
%%%%%%%%%%%%%%%%%
%%%% Punto 2 %%%%
%%%%%%%%%%%%%%%%%
duracionDeCancion(Canciones, DuracionDeUnaCancion):- 
    member(cancion(_, DuracionDeUnaCancion), Canciones).

acelerado(Vocaloid):-
    canta(Vocaloid, Canciones),
    not((duracionDeCancion(Canciones, Duracion), Duracion > 4)).


%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%
%%%% Punto 1 %%%%
%%%%%%%%%%%%%%%%%

concierto(mikuExpo, estadosUnidos, 2000, gigante(2, 6)).
concierto(magicalMirai, japon, 3000, gigante(3, 10)).
concierto(vocalektVisions, estadosUnidos, 1000, mediano(9)).
concierto(mikuFest, argentina, 100, pequenio(4)).


%%%%%%%%%%%%%%%%%
%%%% Punto 2 %%%%
%%%%%%%%%%%%%%%%%
cantidadMinimaDeCanciones(Canciones, CantidadMinimaDeCanciones):-
    length(Canciones, CantidadCanciones),
    CantidadCanciones >= CantidadMinimaDeCanciones.


puedeParticipar(hatsuneMiku, Concierto):-
    concierto(Concierto, _, _, _).
puedeParticipar(Vocaloid, Concierto):-
    Vocaloid \= hatsuneMiku,
    canta(Vocaloid, Canciones),
    concierto(Concierto, _, _, Requisitos),
    cumplen(Canciones, Requisitos).


cumplen(Canciones, gigante(CantidadMinimaDeCanciones, DuracionMinima)):-
    cantidadMinimaDeCanciones(Canciones, CantidadMinimaDeCanciones),
    duracionTotalDeCanciones(Canciones, DuracionTotal),
    DuracionTotal > DuracionMinima.
cumplen(Canciones, mediano(DuracionMaxima)):-
    duracionTotalDeCanciones(Canciones, DuracionTotal),
    DuracionTotal < DuracionMaxima.
cumplen(Canciones, pequenio(DuracionMinimaDeUnaCAncion)):-
    duracionDeCancion(Canciones, Duracion),
    Duracion > DuracionMinimaDeUnaCAncion.


%%%%%%%%%%%%%%%%%
%%%% Punto 3 %%%%
%%%%%%%%%%%%%%%%%

masFamoso(Vocaloid):-
    nivelDeFama(Vocaloid, NivelDeFama),
    forall(canta(OtroVocaloid, _), (nivelDeFama(OtroVocaloid, OtroNivelDeFama), NivelDeFama >= OtroNivelDeFama)).

nivelDeFama(Vocaloid, NivelDeFama):-
    canta(Vocaloid, Canciones),
    length(Canciones, CantidadCanciones),
    famaPorConciertos(Vocaloid, FamaTotalDeConciertos),
    NivelDeFama is CantidadCanciones * FamaTotalDeConciertos.

famaPorConciertos(Vocaloid, FamaTotalDeConciertos):-
    findall(FamaPorConcierto, (puedeParticipar(Vocaloid, Concierto), concierto(Concierto, _, FamaPorConcierto, _)), FamaPorConciertos),
    sum_list(FamaPorConciertos, FamaTotalDeConciertos).

%%%%%%%%%%%%%%%%%
%%%% Punto 4 %%%%
%%%%%%%%%%%%%%%%%
conoce(megurineLuka, hatsuneMiku).
conoce(megurineLuka, gumi).
conoce(gumi, seeU).
conoce(seeU, kaito).


conocido(UnVocaloid, OtroVocaloid):-
    conoce(UnVocaloid, OtroVocaloid).
conocido(UnVocaloid, OtroVocaloid):-
    conoce(OtroVocaloid, UnVocaloid).

conocido(UnVocaloid, OtroVocaloid):- 
    conoce(UnVocaloid, Alguien),
    conocido(Alguien, OtroVocaloid),
    UnVocaloid \= OtroVocaloid.

esElUnico(Vocaloid, Concierto):-
    puedeParticipar(Vocaloid, Concierto),
    not((conocido(Vocaloid, Conocido), puedeParticipar(Conocido, Concierto))).

    