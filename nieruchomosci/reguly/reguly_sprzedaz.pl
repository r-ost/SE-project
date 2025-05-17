:- consult('../baza_wiedzy.pl').

% --- Reguły S: sprzedaż ---
sprzedaz_oferta_rodzinna(OID) :-
    oferta_sprzedazy(OID, PID, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, Typ, _, _, _, _, _, _, _, _, Odleglosc, Pow, _, Pokoje, Lazienki, _, _, _, _, _, _, _, _, _, _, _, _, Stan, _, _, _),
    member(Typ, [mieszkanie, dom]),
    Pokoje > 3, Lazienki > 2, Pow > 80, Odleglosc < 10, Stan > 3.

sprzedaz_oferta_singlowa(OID) :-
    oferta_sprzedazy(OID, PID, _, _, Cena, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, Pow, _, Pokoje, Lazienki, _, _, _, _, _, _, _, _, _, _, _, _, Stan, _, _, _),
    Pokoje = 1, Lazienki = 1, Pow < 40, Stan > 3, Cena < 500000.

sprzedaz_oferta_inwestycyjna(OID) :-
    oferta_sprzedazy(OID, PID, _, _, Cena, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, Odl, Pow, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Stan, _, _, _),
    CenaZaM2 is Cena / Pow,
    CenaZaM2 < 5000,
    (Stan > 3 ; Stan =< 3),
    Odl < 5.

sprzedaz_oferta_luksusowa(OID) :-
    oferta_sprzedazy(OID, PID, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, Pow, wysoki, _, Lazienki, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    Pow > 150, Lazienki >= 3, umeblowane(PID).

sprzedaz_oferta_ekologiczna(OID) :-
    oferta_sprzedazy(OID, PID, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Energia, _, _, _, _, _, _),
    member(Energia, ['a','a+', 'a++', 'a+++']).
