% --- Reguły S: sprzedaż ---
sprzedaz_oferta_rodzinna(OfertaSprzedazy, Nieruchomosci) :-
    oferta_sprzedazy_property_id(OfertaSprzedazy, PropertyId),
    member(Nieruchomosc, Nieruchomosci),
    nieruchomosc_id(Nieruchomosc, PropertyId),
    nieruchomosc_typ(Nieruchomosc, Typ),
    nieruchomosc_pokoje(Nieruchomosc, Pokoje),
    nieruchomosc_lazienki(Nieruchomosc, Lazienki),
    nieruchomosc_powierzchnia(Nieruchomosc, Pow),
    nieruchomosc_odleglosc(Nieruchomosc, Odleglosc),
    nieruchomosc_stan(Nieruchomosc, Stan),
    member(Typ, [mieszkanie, dom]),
    Pokoje > 3,
    Lazienki > 2,
    Pow > 80,
    Odleglosc < 10,
    Stan > 3.

sprzedaz_oferta_singlowa(OfertaSprzedazy, Nieruchomosci) :-
    oferta_sprzedazy_property_id(OfertaSprzedazy, PropertyId),
    member(Nieruchomosc, Nieruchomosci),
    nieruchomosc_id(Nieruchomosc, PropertyId),
    nieruchomosc_typ(Nieruchomosc, Typ),
    nieruchomosc_pokoje(Nieruchomosc, Pokoje),
    nieruchomosc_lazienki(Nieruchomosc, Lazienki),
    nieruchomosc_powierzchnia(Nieruchomosc, Pow),
    nieruchomosc_odleglosc(Nieruchomosc, Odleglosc),
    nieruchomosc_stan(Nieruchomosc, Stan),
    member(Typ, [mieszkanie, dom]),
    Pokoje = 1,
    Lazienki = 1,
    Pow < 40,
    Odleglosc < 10,
    Stan > 3.

sprzedaz_oferta_inwestycyjna(OID) :-
    oferta_sprzedazy(OID, PID, _, _, Cena, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, Odl, Pow, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Stan, _, _, _),
    CenaZaM2 is Cena / Pow,
    CenaZaM2 < 5000,
    (Stan > 3 ; Stan =< 3),
    Odl < 5.

sprzedaz_oferta_inwestycyjna(OfertaSprzedazy, Nieruchomosci) :-
    oferta_sprzedazy_property_id(OfertaSprzedazy, PropertyId),
    oferta_sprzedazy_cena(OfertaSprzedazy, Cena),
    member(Nieruchomosc, Nieruchomosci),
    nieruchomosc_id(Nieruchomosc, PropertyId),
    nieruchomosc_powierzchnia(Nieruchomosc, Pow),
    nieruchomosc_odleglosc(Nieruchomosc, Odl),
    nieruchomosc_stan(Nieruchomosc, Stan),
    CenaZaM2 is Cena / Pow,
    CenaZaM2 < 5000,
    (Stan > 3 ; Stan =< 3),
    Odl < 5.

sprzedaz_oferta_luksusowa(OfertaSprzedazy, Nieruchomosci) :-
    oferta_sprzedazy_property_id(OfertaSprzedazy, PropertyId),
    member(Nieruchomosc, Nieruchomosci),
    nieruchomosc_id(Nieruchomosc, PropertyId),
    nieruchomosc_powierzchnia(Nieruchomosc, Pow),
    nieruchomosc_standard(Nieruchomosc, Standard),
    nieruchomosc_lazienki(Nieruchomosc, Lazienki),
    nieruchomosc_umeblowane(Nieruchomosc, Umeblowane),
    Pow > 150,
    Lazienki >= 3,
    Standard = wysoki,
    Umeblowane = tak.

sprzedaz_oferta_ekologiczna(OfertaSprzedazy, Nieruchomosci) :-
    oferta_sprzedazy_property_id(OfertaSprzedazy, PropertyId),
    member(Nieruchomosc, Nieruchomosci),
    nieruchomosc_id(Nieruchomosc, PropertyId),
    nieruchomosc_energia(Nieruchomosc, Energia),
    member(Energia, ['a','a+', 'a++', 'a+++']).