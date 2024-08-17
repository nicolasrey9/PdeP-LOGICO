%%%%%%%%%%%%%%%%
%%%% Punto 1 %%%%
%%%%%%%%%%%%%%%%%

atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).

atiende(lucas, martes, 10, 20).

atiende(juanC, sabados, 18, 22).
atiende(juanC, domingos, 18, 22).

atiende(juanFdS, jueves, 10, 20).
atiende(juanFdS, viernes, 12, 20).

atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).

atiende(martu, miercoles, 23, 24).

atiende(vale, Dias, Desde, Hasta):- atiende(dodain, Dias, Desde, Hasta).
atiende(vale, Dias, Desde, Hasta):- atiende(juanC, Dias, Desde, Hasta).


%%%%%%%%%%%%%%%%%
%%%% Punto 2 %%%%
%%%%%%%%%%%%%%%%%
quienAtiende(Dia, Hora, Persona):-
    atiende(Persona, Dia, Desde, Hasta),
    between(Desde, Hasta, Hora).


%%%%%%%%%%%%%%%%%
%%%% Punto 3 %%%%
%%%%%%%%%%%%%%%%%
foreverAlone(Dia, Hora, Persona):-
    quienAtiende(Dia, Hora, Persona),
    not((quienAtiende(Dia, Hora, OtraPersona), OtraPersona \= Persona)).



%%%%%%%%%%%%%%%%%
%%%% Punto 4 %%%%
%%%%%%%%%%%%%%%%%
posibilidadesDeAtencion(Dia, Persona):-
    quienAtiende(Dia, _, Persona).

%%%%%%%%%%%%%%%%%
%%%% Punto 5 %%%%
%%%%%%%%%%%%%%%%%
% ventas(Vendedor, dia, ventas).

ventas(dodain, lunes10DeAgosto, [golosinas(1200), cigarrillos(jockey), golosinas(50)]).
ventas(dodain, miercoles12DeAgosto, [bebidas(8, alcoholicas), bebidas(1, noAlcoholicas), golosinas(10)]).
ventas(martu, miercoles12DeAgosto, [golosinas(1000), cigarrillos([chesterfield, colorado, parisiennes])]).
ventas(lucas, martes11DeAgosto, [golosinas(600)]).
ventas(lucas, martes18DeAgosto, [bebidas(2, noAlcoholicas), cigarrillos(derby)]).


suertudo(Vendedor):-
    ventas(Vendedor, _, _),
    forall(ventas(Vendedor, _, [PrimeraVenta | _]), ventaImportante(PrimeraVenta)).


ventaImportante(golosinas(Valor)):-
    Valor > 100.
ventaImportante(bebidas(_, alcoholicas)).
ventaImportante(bebidas(Cantidad, _)):-
    Cantidad > 5.
ventaImportante(cigarrillos(Marcas)):-
    length(Marcas, Cantidad),
    Cantidad > 2.
    