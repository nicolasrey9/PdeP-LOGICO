ockey(valdivieso, 155, 52).
jockey(leguisamo, 161, 49).
jockey(lezcano, 149, 50).
jockey(baratucci, 153, 55).
jockey(falero, 157, 52).

caballeriza(valdivieso, elTute).
caballeriza(falero, elTute).
caballeriza(lezcano, lasHormigas).
caballeriza(baratucci, elCharabon).
caballeriza(leguisamo, elCharabon).

caballo(botafogo).
caballo(oldMan).
caballo(energica).
caballo(matBoy).
caballo(yatasto).


leGusta(botafogo, baratucci).
leGusta(botafogo, Jockey):-
    jockey(Jockey, _, Peso),
    Peso < 52.

leGusta(oldMan, Jockey):- 
    jockey(Jockey, _,_), 
    muchasLetras(Jockey).

leGusta(energica, Jockey):-
    jockey(Jockey, _, _),
    not(leGusta(botafogo, Jockey)).

leGusta(matBoy, Jockey):-
    jockey(Jockey, Altura, _),
    Altura > 170.

muchasLetras(Palabra):- 
    atom_length(Palabra, Length),
    Length > 7.


gano(botafogo,granPremioNacional).
gano(botafogo,granPremioRepublica).
gano(oldMan,granPremioRepublica).
gano(oldMan,campeonatoPalermoDeOro).
gano(matBoy,granPremioCriadores).

%%%%%%%%%%%%%%%%%
%%%% Punto 2 %%%%
%%%%%%%%%%%%%%%%%
prefiereAVarios(Caballo):-
    leGusta(Caballo, UnJockey),
    leGusta(Caballo, OtroJockey),
    UnJockey \= OtroJockey.


%%%%%%%%%%%%%%%%%
%%%% Punto 3 %%%%
%%%%%%%%%%%%%%%%%

aborrece(Caballo, Caballeriza):-
    caballo(Caballo),
    caballeriza(_, Caballeriza),
    not(leGustaAlguienDeLaCAballeriza(Caballo, Caballeriza)).

leGustaAlguienDeLaCAballeriza(Caballo, Caballeriza):-
    caballeriza(Jockey, Caballeriza),
    leGusta(Caballo, Jockey).


%%%%%%%%%%%%%%%%%
%%%% Punto 4 %%%%
%%%%%%%%%%%%%%%%%
piolin(Jockey):-
    jockey(Jockey, _, _),
    forall(ganoPremioImportante(Caballo), leGusta(Caballo, Jockey)).

ganoPremioImportante(Caballo):-
    gano(Caballo, Premio),
    esImportante(Premio).

esImportante(granPremioNacional).
esImportante(granPremioRepublica).


%%%%%%%%%%%%%%%%%
%%%% Punto 5 %%%%
%%%%%%%%%%%%%%%%%

ganadora(Apuesta, [Primero, Segundo | _]):-
    ganaSegunTipoApuesta(Apuesta, Primero, Segundo).

ganaSegunTipoApuesta(ganadorPorUnCaballo(Primero), Primero, _).

ganaSegunTipoApuesta(segundoPorUnCaballo(Primero), Primero, _).
ganaSegunTipoApuesta(segundoPorUnCaballo(Segundo), _, Segundo).

ganaSegunTipoApuesta(exacta(Primero, Segundo), Primero, Segundo).

ganaSegunTipoApuesta(imperfecta(UnCaballo, OtroCaballo), UnCaballo, OtroCaballo).
ganaSegunTipoApuesta(imperfecta(UnCaballo, OtroCaballo), OtroCaballo, UnCaballo).



%%%%%%%%%%%%%%%%%
%%%% Punto 6 %%%%
%%%%%%%%%%%%%%%%%

colorCaballo(botafogo, color(negro)).
colorCaballo(oldMan, color(marron)).
colorCaballo(energica, color(gris, negro)).
colorCaballo(matBoy, color(marron, blanco)).
colorCaballo(yatasto, color(blanco, marron)).

puedeComprar(Caballos, Color) :-
    coloresPosbiles(Color),
    findall(Caballo, esDeEseColor(Caballo, Color), Caballos).
    
esDeEseColor(Caballo, Color) :-
    colorCaballo(Caballo, Colores),
    tieneEseColor(Color, Colores).

coloresPosbiles(Color) :-
    esDeEseColor(_, Color).

tieneEseColor(Color, color(Color)).
tieneEseColor(Color, color(Color, _)).
tieneEseColor(Color, color(_, Color)).