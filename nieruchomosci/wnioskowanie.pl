:- consult('baza_wiedzy.pl').

% -------------------------------
% Przykład reguły eksperckiej
% -------------------------------

atrakcyjne_mieszkanie(ID) :-
    duze_mieszkanie(ID),
    nieruchomosc(ID, _, _, _, Pokoje, Lazienki, _, _, _, _, _, _),
    Pokoje > 2,
    Lazienki > 2,
    blisko_centrum(ID),
    w_dobrym_stanie(ID).

% Reguła: dla rodziny
dobre_dla_rodziny(ID) :-
    nieruchomosc(ID, Typ, _, Pow, Pokoje, Lazienki, _, Stan, Odleglosc, _, _, _),
    member(Typ, [mieszkanie, dom]),
    Pokoje > 3,
    Lazienki > 2,
    Pow > 80,
    Stan > 3,
    Odleglosc =< 10.

% Reguła: dla singla
dobre_dla_singla(ID) :-
    nieruchomosc(ID, _, _, Pow, 1, 1, _, Stan, _, _, _, _),
    Pow < 40,
    Stan > 3.
