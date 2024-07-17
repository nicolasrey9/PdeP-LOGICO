%%% https://docs.google.com/document/d/17rWNL8rdNc-eu7VTuCPgptLhSnRD6FyBZNhYNZ7Hekc/edit#heading=h.49nyg2mvbd10

festival(lollapalooza, [gunsAndRoses, theStrokes, littoNebbia],
    hipodromoSanIsidro).

lugar(hipodromoSanIsidro, 85000, 3000).

banda(gunsAndRoses, eeuu, 69420).

entradaVendida(lollapalooza, campo).
entradaVendida(lollapalooza, plateaNumerada(1)).
entradaVendida(lollapalooza, plateaGeneral(zona2)).

plusZona(hipodromoSanIsidro, zona1, 1500).



itinerante(Festival):-
    festival(Festival, Bandas, Lugar),
    festival(Festival, Bandas, OtroLugar),
    Lugar \= OtroLugar.

careta(personalFest).
careta(Festival):-
    festival(Festival, _, _),
    not(entradaVendida(Festival, campo)).


nacAndPop:-
    festival(Festival, Bandas, _),
    not(careta(Festival)),
    forall(member(Banda, Bandas), 
    (banda(Banda, argentina, Popularidad), Popularidad > 1000)).

sobrevendido(Festival):-
    festival(Festival, _, Lugar),
    lugar(Lugar, Capacidad, _),
    findall(Entrada, entradaVendida(Festival, Entrada), Entradas),
    length(Entradas, CantidadVentas),
    CantidadVentas > Capacidad.


recaudacionTotal(Festival, RecaudacionTotal):-
    festival(Festival, _, Lugar),
    findall(PrecioEntrada, (entradaVendida(Festival, TipoEntrada), 
    precio(TipoEntrada, Lugar, PrecioEntrada)), PreciosEntradas),
    sumlist(PreciosEntradas, RecaudacionTotal).
    

precio(campo, Lugar, PrecioBase):-
    lugar(Lugar, _, PrecioBase).

precio(plateaGeneral(Zona), Lugar, Precio):-
    lugar(Lugar, _, PrecioBase),
    plusZona(Lugar, Zona, Plus),
    Precio is PrecioBase + Plus.

precio(plateaNumerada(Numero), Lugar, Precio):-
    Numero > 10,
    lugar(Lugar, _, PrecioBase),
    Precio is PrecioBase * 3.

precio(plateaNumerada(Numero), Lugar, Precio):-
    Numero =< 10,
    lugar(Lugar, _, PrecioBase),
    Precio is PrecioBase * 6.



delMismoPalo(UnaBanda, OtraBanda):-
    tocaronJuntas(UnaBanda, OtraBanda).

delMismoPalo(UnaBanda, OtraBanda):-
    tocaronJuntas(UnaBanda, TercerBanda),
    banda(OtraBanda, _, Popularidad1),
    banda(TercerBanda, _, Popularidad2),
    Popularidad2 > Popularidad1,
    delMismoPalo(TercerBanda, OtraBanda).

tocaronJuntas(Banda1, Banda2):-
    festival(_, Bandas, _),
    member(Banda1, Bandas),
    member(Banda2, Bandas),
    Banda1 \= Banda2.