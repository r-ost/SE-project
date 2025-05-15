% -------------------------------
% Fakty o nieruchomościach
% -------------------------------

% nieruchomosc(ID, Typ, Lokalizacja, Powierzchnia, Pokoje, Lazienki, RokBudowy, Stan, Odleglosc, Umeblowane, Energia, Zwierzeta).

nieruchomosc(n1, mieszkanie, miasto, 35, 1, 1, 2012, 4, 3.0, tak, b, tak).
nieruchomosc(n2, mieszkanie, przedmiescia, 85, 4, 2, 1995, 5, 7.0, nie, a, nie).
nieruchomosc(n3, dom, wies, 150, 5, 3, 2018, 5, 20.0, tak, a, tak).
nieruchomosc(n4, mieszkanie, miasto, 60, 2, 1, 1985, 3, 2.5, nie, c, nie).
nieruchomosc(n5, mieszkanie, miasto, 90, 3, 2, 2020, 5, 1.0, tak, a, tak).
nieruchomosc(n6, mieszkanie, przedmiescia, 100, 6, 4, 2015, 4, 1.0, tak, b, nie).

% -------------------------------
% Reguły ogólne
% -------------------------------

male_mieszkanie(ID) :-
    nieruchomosc(ID, mieszkanie, _, Pow, _, _, _, _, _, _, _, _),
    Pow < 40.

srednie_mieszkanie(ID) :-
    nieruchomosc(ID, mieszkanie, _, Pow, _, _, _, _, _, _, _, _),
    Pow >= 40, Pow =< 80.

duze_mieszkanie(ID) :-
    nieruchomosc(ID, mieszkanie, _, Pow, _, _, _, _, _, _, _, _),
    Pow > 80.

blisko_centrum(ID) :-
    nieruchomosc(ID, _, _, _, _, _, _, _, Odleglosc, _, _, _),
    Odleglosc < 5.

daleko_od_centrum(ID) :-
    nieruchomosc(ID, _, _, _, _, _, _, _, Odleglosc, _, _, _),
    Odleglosc > 15.

nowe(ID) :-
    nieruchomosc(ID, _, _, _, _, _, Rok, _, _, _, _, _),
    Rok > 2010.

stare(ID) :-
    nieruchomosc(ID, _, _, _, _, _, Rok, _, _, _, _, _),
    Rok < 1990.

w_dobrym_stanie(ID) :-
    nieruchomosc(ID, _, _, _, _, _, _, Stan, _, _, _, _),
    Stan > 3.

w_zlym_stanie(ID) :-
    nieruchomosc(ID, _, _, _, _, _, _, Stan, _, _, _, _),
    Stan =< 3.
