:- consult('../baza_wiedzy.pl').

% --- Reguły N: nieruchomość ---
male_mieszkanie(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, Pow, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _), Pow < 40.
srednie_mieszkanie(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, Pow, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _), Pow >= 40, Pow =< 80.
duze_mieszkanie(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, Pow, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _), Pow > 80.

blisko_centrum(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, Odleglosc, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _), Odleglosc < 5.
daleko_od_centrum(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, Odleglosc, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _), Odleglosc > 15.

nowe(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Rok, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _), Rok > 2010.
stare(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Rok, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _), Rok < 1990.

w_dobrym_stanie(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Stan, _, _, _), Stan > 3.
w_zlym_stanie(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Stan, _, _, _), Stan =< 3.

tanie(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Cena, _, _, _, _), Cena < 500000.
drogie(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Cena, _, _, _, _), Cena > 1000000.

niski_standard(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, niski, _, _, _).
wysoki_standard(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, wysoki, _, _, _).

energooszczedne(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Energia, _, _, _, _, _, _), member(Energia, [a, 'A+']).

umeblowane(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, tak, _).

przyjazne_dla_zwierzat(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, PolitykaZwierzat, _), PolitykaZwierzat \= 'nie'.

atrakcyjne_mieszkanie(ID) :-
    duze_mieszkanie(ID),
    nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, Pokoje, Lazienki, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _), 
    Pokoje > 2, 
    Lazienki > 2,
    blisko_centrum(ID),
    w_dobrym_stanie(ID).

dla_seniora(ID) :-
    nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, NrP, _, Winda, _, _, _, _, _, _, _, _, _, _, _),
    (NrP = 0 ; Winda = tak),
    w_dobrym_stanie(ID),
    \+ blisko_centrum(ID).

dla_niepelnosprawnych(ID) :-
    nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, NrP, _, Winda, _, _, _, _, _, _, _, _, _, _, _),
    (NrP = 0 ; Winda = tak),
    nowe(ID),
    w_dobrym_stanie(ID).

dla_rodziny(ID) :-
    duze_mieszkanie(ID),
    nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, Pokoje, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    Pokoje >= 3,
    w_dobrym_stanie(ID),
    umeblowane(ID),
    \+ blisko_centrum(ID).

dla_studenta(ID) :-
    male_mieszkanie(ID),
    blisko_centrum(ID),
    nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Rok, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    Rok >= 2000.