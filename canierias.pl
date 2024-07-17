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
color(codo(Color), Color).
color(canio(Color, _), Color).
color(canilla(_, Color, _), Color).

coloresEnchufables(azul, rojo).
coloresEnchufables(rojo, negro).


colorDerecho(Canieria, ColorDerecho) :-
    reverse(CanieriaInvertida, Canieria),
    nth0(0, CanieriaInvertida, PiezaDerecha),
    color(PiezaDerecha, ColorDerecho).

colorIzquierdo(Canieria, ColorIzquierdo) :-
    nth0(0, Canieria, PiezaIzquierda),
    color(PiezaIzquierda, ColorIzquierdo).


puedoEnchufar(Canieria, Canieria) :-
    colorDerecho(Canieria, Color),
    colorIzquierdo(Canieria, Color).
puedoEnchufar(Canieria, Canieria) :-
    colorDerecho(Canieria, Color1),
    colorIzquierdo(Canieria, Color2),
    coloresEnchufables(Color1, Color2).
