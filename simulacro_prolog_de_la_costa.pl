%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% PUNTO 1 %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% comida(Producto, Precio).
puestoDeComida(hamburguesa, 2000).
puestoDeComida(lomitoCompleto, 2500).
puestoDeComida(panchitoConPapas, 1500).
puestoDeComida(caramelos, 0).

% atraccion(Nombre, tranquila(PublicoObjetivo)).
atraccion(autitosChocadores, tranquila(chicosYAdultos)).
atraccion(casaEmbrujada, tranquila(chicosYAdultos)).
atraccion(laberinto, tranquila(chicosYAdultos)).
atraccion(tobogan, tranquila(chicos)).
atraccion(calesita, tranquila(chicos)).

% atraccion(nombre, intensa(coeficienteDeLanzamiento)).
atraccion(barcoPirata, intensa(14)).
atraccion(tazasChinas, intensa(6)).
atraccion(simulador3D, intensa(2)).

% atraccion(nombre, montaniaRusa(giros, duracion)).
atraccion(abismoMortalRecargada, montaniaRusa(3, 134)).
atraccion(paseoPorElBosque, montaniaRusa(0, 45)).

atraccion(torpedoSalpicon, acuatica(septiembre, marzo)).
atraccion(esperoQueHayasTraidoUnaMudaDeRopa, acuatica(septiembre, marzo)).

% visitante(nombre, datosSuperficiales(edad, dinero), sentimiento(hambre, aburrimiento))
% grupo(nombre, grupo).
visitante(eusebio, datosSuperficiales(80, 3000), sentimiento(50, 0)).
visitante(carmela, datosSuperficiales(80,    0), sentimiento(0, 25)).

visitante(joaco, datosSuperficiales(22,    0), sentimiento(100, 100)).
visitante(fede,  datosSuperficiales(36, 1000), sentimiento( 50,   0)).

grupo(eusebio, viejitos).
grupo(carmela, viejitos).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% PUNTO 2 %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
visitante(Nombre):-
    visitante(Nombre, _, _).

vieneSolo(Visitante):-
    visitante(Visitante),
    not(vieneAcompaniado(Visitante)).

vieneAcompaniado(Visitante):-
    grupo(Visitante, _).

sentimientos(Visitante, Hambre, Aburrimiento):-
    visitante(Visitante, _, sentimiento(Hambre, Aburrimiento)).

sumaSentimientos(Visitante, Suma):-
    sentimientos(Visitante, Hambre, Aburrimiento),
    Suma is Hambre + Aburrimiento.

sumaSentimientosEntre(Visitante, Base, Tope) :-
    sumaSentimientos(Visitante, Suma),
    between(Base, Tope, Suma).


bienestar(Visitante, felicidadPlena):-
    sumaSentimientos(Visitante, 0),
    vieneAcompaniado(Visitante).

bienestar(Visitante, podriaEstarMejor):-
    sumaSentimientos(Visitante, 0),
    vieneSolo(Visitante).

bienestar(Visitante, podriaEstarMejor):-
    sumaSentimientosEntre(Visitante, 1, 50).

bienestar(Visitante, necesitaEntretenerse):-
    sumaSentimientosEntre(Visitante, 51, 99).

bienestar(Visitante, seQuiereIrACasa):-
    sumaSentimientos(Visitante, Suma),
    Suma >= 100.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% PUNTO 3 %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dinero(Visitante, SuDinero):-
    visitante(Visitante, datosSuperficiales(_, SuDinero), _).

hambre(Visitante, SuHambre):-
    sentimientos(Visitante, SuHambre, _).

edad(Visitante, Edad):-
    visitante(Visitante, datosSuperficiales(Edad, _), _).

esChico(Visitante):-
    edad(Visitante, Edad),
    Edad < 13.

comida(Comida):-
    puestoDeComida(Comida, _).


puedeSatisfacer(Grupo, Comida):-
    grupo(_, Grupo),
    comida(Comida),
    forall(grupo(Integrante, Grupo), (puedePagar(Integrante, Comida), quitaHambre(Comida, Integrante))).

puedePagar(Visitante, Comida):-
    dinero(Visitante, Dinero),
    puestoDeComida(Comida, Precio),
    Dinero >= Precio.

quitaHambre(lomitoCompleto, _).
quitaHambre(hamburguesa, Visitante):-
    hambre(Visitante, Hambre),
    Hambre < 50.
quitaHambre(panchitoConPapas, Visitante):-
    esChico(Visitante).
leQuitaElHambre(caramelos, Visitante) :-
    forall(comida(Comida), not((puedePagar(Visitante, Comida), Comida \= caramelos))).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% PUNTO 4 %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lluviaDeHamburguesas(Visitante, Atraccion):-
    puedePagar(Visitante, hamburguesa),
    atraccionVomitiva(Visitante, Atraccion).

atraccionVomitiva(_, tobogan).
atraccionVomitiva(Visitante, Atraccion):-
    atraccion(Atraccion, TipoDeAtraccion),
    tipoDeAtraccionVomitiva(Visitante, TipoDeAtraccion).

tipoDeAtraccionVomitiva(_, intensa(CoeficienteDeLanzamiento)):-
    CoeficienteDeLanzamiento > 10.

tipoDeAtraccionVomitiva(Visitante, MontaniaRusa) :-
    esPeligrosa(Visitante, MontaniaRusa).
    
esPeligrosa(Visitante, montaniaRusa(Giros, _)) :-
    not(esChico(Visitante)),
    not(bienestar(Visitante, necesitaEntretenerse)),
    tieneLaMaximaCantidadDeGiros(Giros).
    
esPeligrosa(Visitante, montaniaRusa(_, Duracion)) :-
    esChico(Visitante),
    Duracion > 60.

tieneLaMaximaCantidadDeGiros(GirosMax):-
    forall(atraccion(_, montaniaRusa(Giros, _)), GirosMax >= Giros).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% PUNTO 5 %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

opcionDeEntretenimiento(Visitante, _, Opcion):-
    puedePagar(Visitante, Opcion).

opcionDeEntretenimiento(_, _, Opcion):-
    atraccion(Opcion, tranquila(chicosYAdultos)).

opcionDeEntretenimiento(_, _, Opcion):-
    atraccion(Opcion, intensa(_)).

opcionDeEntretenimiento(Visitante, _, Opcion):-
    atraccion(Opcion, MontaniaRusa),
    visitante(Visitante),
    not(esPeligrosa(Visitante, MontaniaRusa)).

opcionDeEntretenimiento(_, Mes, Opcion):-
    atraccion(Opcion, Acuatica),
    mesDeAtraccion(Acuatica, Mes).

opcionDeEntretenimiento(Visitante, _, Opcion):-
    atraccion(Opcion, tranquila(chicos)),
    grupo(Visitante, SuGrupo),
    grupoConChicos(SuGrupo).

grupoConChicos(Grupo):-
    grupo(Chico, Grupo),
    esChico(Chico).

mesDeAtraccion(acuatica(MesInicio, MesCierre), Mes):-
    mesesDesdeHasta(MesInicio, MesCierre, Meses),
    member(Mes, Meses).

mesesDesdeHasta(septiembre, marzo, [septiembre, octubre, noviembre, diciembre, enero, febrero, marzo]).

