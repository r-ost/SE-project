% --- Reguły N: nieruchomość ---
male_mieszkanie(Nieruchomosc) :-
    nieruchomosc_powierzchnia(Nieruchomosc, Powierzchnia),
    Powierzchnia =< 40.

srednie_mieszkanie(Nieruchomosc) :- 
    nieruchomosc_powierzchnia(Nieruchomosc, Powierzchnia), 
    Powierzchnia >= 40, Powierzchnia =< 80.

duze_mieszkanie(Nieruchomosc) :- 
    nieruchomosc_powierzchnia(Nieruchomosc, Powierzchnia), 
    Powierzchnia > 80.

blisko_centrum(Nieruchomosc) :- 
    nieruchomosc_odleglosc(Nieruchomosc, Odleglosc),
    Odleglosc < 5.

daleko_od_centrum(Nieruchomosc) :- 
    nieruchomosc_odleglosc(Nieruchomosc, Odleglosc),
    Odleglosc > 15.

nowe(Nieruchomosc) :- 
    nieruchomosc_rok(Nieruchomosc, Rok), 
    Rok > 2010.

stare(Nieruchomosc) :- 
    nieruchomosc_rok(Nieruchomosc, Rok), 
    Rok < 1990.

w_dobrym_stanie(Nieruchomosc) :- 
    nieruchomosc_stan(Nieruchomosc, Stan), 
    Stan > 3.

w_zlym_stanie(Nieruchomosc) :- 
    nieruchomosc_stan(Nieruchomosc, Stan), 
    Stan =< 3.

% TODO: poprawić, bo nie ma property cena
% tanie(Nieruchomosc) :- 
%     nieruchomosc_cena(Nieruchomosc, Cena), 
%     Cena < 500000.

% drogie(Nieruchomosc) :- 
%     nieruchomosc_cena(Nieruchomosc, Cena), 
%     Cena > 1000000.

niski_standard(Nieruchomosc) :- 
    nieruchomosc_standard(Nieruchomosc, niski).

wysoki_standard(Nieruchomosc) :- 
    nieruchomosc_standard(Nieruchomosc, wysoki).

energooszczedne(Nieruchomosc) :- 
    nieruchomosc_energia(Nieruchomosc, Energia), 
    member(Energia, [a, 'A+']).

umeblowane(Nieruchomosc) :- 
    nieruchomosc_umeblowane(Nieruchomosc, tak).

% TODO: poprawić, bo nie ma property polityka_zwierzat
% przyjazne_dla_zwierzat(Nieruchomosc) :- 
%     nieruchomosc_polityka_zwierzat(Nieruchomosc, PolitykaZwierzat), 
%     PolitykaZwierzat \= 'nie'.

atrakcyjne_mieszkanie(Nieruchomosc) :-
    duze_mieszkanie(Nieruchomosc),
    nieruchomosc_pokoje(Nieruchomosc, Pokoje),
    nieruchomosc_lazienki(Nieruchomosc, Lazienki),
    Pokoje > 2, 
    Lazienki > 2,
    blisko_centrum(Nieruchomosc),
    w_dobrym_stanie(Nieruchomosc).

dla_seniora(Nieruchomosc) :-
    nieruchomosc_nr_pietra(Nieruchomosc, NrP),
    nieruchomosc_winda(Nieruchomosc, Winda),
    (NrP = 0 ; Winda = tak),
    w_dobrym_stanie(Nieruchomosc),
    \+ blisko_centrum(Nieruchomosc).

dla_niepelnosprawnych(Nieruchomosc) :-
    nieruchomosc_nr_pietra(Nieruchomosc, NrP),
    nieruchomosc_winda(Nieruchomosc, Winda),
    (NrP = 0 ; Winda = tak),
    nowe(Nieruchomosc),
    w_dobrym_stanie(Nieruchomosc).

dla_rodziny(Nieruchomosc) :-
    duze_mieszkanie(Nieruchomosc),
    nieruchomosc_pokoje(Nieruchomosc, Pokoje),
    Pokoje >= 3,
    w_dobrym_stanie(Nieruchomosc),
    umeblowane(Nieruchomosc),
    \+ blisko_centrum(Nieruchomosc).

dla_studenta(Nieruchomosc) :-
    male_mieszkanie(Nieruchomosc),
    blisko_centrum(Nieruchomosc),
    nieruchomosc_rok(Nieruchomosc, Rok),
    Rok >= 2000.