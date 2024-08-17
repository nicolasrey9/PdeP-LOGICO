herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).


tiene(ergon, aspiradora(200)).
tiene(ergon, trapeador).
tiene(peter, trapeador).
tiene(winston, varitaDeNeutrones).

%%%%%%%%%%%%%%%%%
%%%% Punto 2 %%%%
%%%%%%%%%%%%%%%%%

satisfaceHerramienta(Persona, Herramienta):-
    tiene(Persona, Herramienta),
    Herramienta \= aspiradora(_).
satisfaceHerramienta(Persona, aspiradora(Potencia)):-
    tiene(Persona, aspiradora(OtraPotencia)),
    OtraPotencia >= Potencia.

%%%%%%%%%%%%%%%%%
%%%% Punto 3 %%%%
%%%%%%%%%%%%%%%%%
empleado(Persona):- tiene(Persona, _).

puedeRealizarTarea(Persona, Tarea):-
    satisfaceHerramienta(Persona, varitaDeNeutrones),
    herramientasRequeridas(Tarea, _).
puedeRealizarTarea(Persona, Tarea):-
    herramientasRequeridas(Tarea, HerramientasRequeridas),
    empleado(Persona),
    forall(member(Herramienta, HerramientasRequeridas), satisfaceHerramienta(Persona, Herramienta)).

%%%%%%%%%%%%%%%%%
%%%% Punto 4 %%%%
%%%%%%%%%%%%%%%%%
tareaPedida(nico, cortarPasto, 100).
tareaPedida(nico, limpiarPieza, 20).
tareaPedida(nico, ordenarCocina, 50).

precio(ordenarCocina, 10).
precio(cortarPasto, 15).
precio(limpiarPieza, 8).

cobrarPedido(Cliente, PrecioTotal):-
    tareaPedida(Cliente, _, _),
    findall(Precio, (tareaPedida(Cliente, Tarea, Metros), precioTarea(Tarea, Metros, Precio)), Precios),
    sum_list(Precios, PrecioTotal).
    
precioTarea(Tarea, MetrosCuadrados, Precio):-
    precio(Tarea, PrecioPorMetroCuadrado),
    Precio is MetrosCuadrados * PrecioPorMetroCuadrado.

%%%%%%%%%%%%%%%%%
%%%% Punto 5 %%%%
%%%%%%%%%%%%%%%%%
aceptaPedidoDe(Cliente, Empleado):-
    empleado(Empleado),
    tareasPedidas(Cliente, Tareas),
    forall(member(Tarea, Tareas), puedeRealizarTarea(Empleado, Tarea)),
    acepta(Empleado, Tareas, Cliente).


tareasPedidas(Cliente, Tareas):-
    findall(Tarea, tareaPedida(Cliente, Tarea, _), Tareas).


acepta(peter, _, _).
acepta(ray, Pedidos, _):-
    not(member(limpiarTecho, Pedidos)).
acepta(winston, _, Cliente):-
    cobrarPedido(Cliente, Precio),
    Precio > 500.
acepta(egon, Pedidos, _):-
    forall(member(Tarea, Pedidos), not(esCompleja(Tarea))).

esCompleja(limpiarTecho).
esCompleja(Tarea):-
    herramientasRequeridas(Tarea, Herramientas),
    length(Herramienta, Cantidad),
    Cantidad > 2.
    

%%%%%%%%%%%%%%%%%
%%%% Punto 6 %%%%
%%%%%%%%%%%%%%%%%
