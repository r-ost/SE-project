:- consult('baza_wiedzy.pl').

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

energooszczedne(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Energia, _, _, _, _, _, _), member(Energia, [a, 'A+']).

umeblowane(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, tak, _).

atrakcyjne_mieszkanie(ID) :-
    duze_mieszkanie(ID),
    nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, Pokoje, Lazienki, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    Pokoje > 2, Lazienki > 2,
    blisko_centrum(ID),
    w_dobrym_stanie(ID).

przyjazne_dla_zwierzat(ID) :- nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, PolitykaZwierzat, _), PolitykaZwierzat \= 'nie'.

dla_seniora(ID) :-
    nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, NrP, _, Winda, _, _, _, _, _, _, _, Stan, _, _, _),
    (NrP = 0 ; Winda = tak),
    w_dobrym_stanie(ID),
    \+ blisko_centrum(ID).

dla_niepelnosprawnych(ID) :-
    nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, NrP, _, Winda, _, _, _, _, _, _, _, Stan, _, _, _),
    (NrP = 0 ; Winda = tak),
    nowe(ID),
    w_dobrym_stanie(ID).




% --- Reguły S: sprzedaż ---
oferta_rodzinna(OID) :-
    oferta_sprzedazy(OID, PID, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, Typ, _, _, _, _, _, _, _, _, Odleglosc, Pow, _, Pokoje, Lazienki, _, _, _, _, _, _, _, _, _, _, _, _, Stan, _, _, _),
    member(Typ, [mieszkanie, dom]),
    Pokoje > 3, Lazienki > 2, Pow > 80, Odleglosc < 10, Stan > 3.

oferta_singlowa(OID) :-
    oferta_sprzedazy(OID, PID, _, _, Cena, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, Pow, _, Pokoje, Lazienki, _, _, _, _, _, _, _, _, _, _, _, _, Stan, _, _, _),
    Pokoje = 1, Lazienki = 1, Pow < 40, Stan > 3, Cena < 500000.

inwestycyjna(OID) :-
    oferta_sprzedazy(OID, PID, _, _, Cena, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, Odl, Pow, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Stan, _, _, _),
    CenaZaM2 is Cena / Pow,
    CenaZaM2 < 5000,
    (Stan > 3 ; Stan =< 3),
    Odl < 5.

luksusowa_sprzedaz(OID) :-
    oferta_sprzedazy(OID, PID, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, Pow, wysoki, _, Lazienki, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    Pow > 150, Lazienki >= 3, umeblowane(PID).

oferta_ekologiczna(OID) :-
    oferta_sprzedazy(OID, PID, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Energia, _, _, _, _, _, _),
    member(Energia, ['a','a+', 'a++', 'a+++']).








% --- Reguły W: wynajem ---
oferta_dla_studentow(OID) :-
    oferta_wynajmu(OID, PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, _, _, Pokoje, Lazienki, _, _, _, _, _, _, _, _, _, _, _, _, Stan, _, _, _),
    Pokoje > 2,
    Lazienki > 1,
    Stan > 3.

oferta_dla_rodzin(OID) :-
    oferta_wynajmu(OID, PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, Pow, _, Pokoje, Lazienki, _, _, _, _, _, _, _, _, _, _, _, _, Stan, _, _, _),
    Pokoje > 3,
    Lazienki > 2,
    Pow > 80,
    Stan > 3.

oferta_ekonomiczna(OID) :-
    oferta_wynajmu(OID, PID, _, _, Cena, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Stan, _, _, _),
    Cena < 2000,
    Stan > 3.

oferta_luksusowa(OID) :-
    oferta_wynajmu(OID, PID, _, _, Cena, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, Pow, wysoki, _, _, Lazienki, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    Pow > 150,
    Lazienki >= 3,
    umeblowane(PID),
    Cena > 5000.

oferta_przyjazna_zwierzetom(OID) :-
    oferta_wynajmu(OID, PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, Typ, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, PolitykaZwierzat, _),
    member(Typ, [dom, mieszkanie]),
    PolitykaZwierzat \= 'nie',
    (parter(PID) ; budynek_z_winda(PID)).

oferta_dla_seniorow(OID) :-
    oferta_wynajmu(OID, PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, NrP, _, Winda, _, _, _, _, _, _, _, Stan, _, _, _),
    (NrP = 0 ; Winda = tak),
    w_dobrym_stanie(PID),
    \+ blisko_centrum(PID),
    oferta_ekonomiczna(OID).

oferta_ekologiczna(OID) :-
    oferta_wynajmu(OID, PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Energia, _, _, _, _, _, _),
    member(Energia, ['a','a+', 'a++', 'a+++']).

oferta_krotkoterminowa(OID) :-
    oferta_wynajmu(OID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, MinOkres, _),
    MinOkres < 6.

oferta_dlugoterminowa(OID) :-
    oferta_wynajmu(OID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, MaxOkres),
    MaxOkres > 12.

oferta_dostepna_od_zaraz(OID) :-
    oferta_wynajmu(OID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, MinStart, _),
    get_time(Today),
    OneMonth is 30*24*60*60,
    Deadline is Today + OneMonth,
    MinStart =< Deadline.
