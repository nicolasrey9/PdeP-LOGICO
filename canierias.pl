%%%%%%%%%% PUNTO 1
precio(Canieria, PrecioTotal):-
    findall(PrecioPieza, (member(Pieza, Canieria), precioPieza(Pieza, PrecioPieza)), Precios),
    sumlist(Precios, PrecioTotal).

precioPieza(codo(_), 5).
precioPieza(canio(_, metrosLongitud), Precio) :-
    Precio is metrosLongitud * 3.
precioPieza(canilla(trangular, _, _), 20).
precioPieza(canilla(_, _, Ancho), 12) :-
    Ancho =< 5.
precioPieza(canilla(_, _, Ancho), 15) :-
    Ancho > 5.


%%%%%%%%%%% PUNTO 2
puedoEnchufar(Pieza1, Pieza2) :-
    color(Pieza1, Color),
    color(Pieza2, Color).

puedoEnchufar(Pieza1, Pieza2) :-
    color(Pieza1, Color1),
    color(Pieza2, Color2),
    sonEnchufables(Color1, Color2).

color(codo(Color), Color).
color(canio(Color, _), Color).
color(canilla(_, Color, _), Color).

sonEnchufables(Color1, Color2) :-