% --- Reguły W: wynajem ---
wynajem_oferta_dla_studentow(OfertaWynajmu, Nieruchomosci) :-
    oferta_wynajmu_property_id(OfertaWynajmu, PropertyId),
    member(Nieruchomosc, Nieruchomosci),
    nieruchomosc_id(Nieruchomosc, PropertyId),
    nieruchomosc_pokoje(Nieruchomosc, Pokoje),
    nieruchomosc_lazienki(Nieruchomosc, Lazienki),
    nieruchomosc_stan(Nieruchomosc, Stan),
    Pokoje > 2,
    Lazienki > 1,
    Stan > 3.

wynajem_oferta_dla_rodzin(OfertaWynajmu, Nieruchomosci) :-
    oferta_wynajmu_property_id(OfertaWynajmu, PropertyId),
    member(Nieruchomosc, Nieruchomosci),
    nieruchomosc_id(Nieruchomosc, PropertyId),
    nieruchomosc_pokoje(Nieruchomosc, Pokoje),
    nieruchomosc_lazienki(Nieruchomosc, Lazienki),
    nieruchomosc_powierzchnia(Nieruchomosc, Pow),
    nieruchomosc_stan(Nieruchomosc, Stan),
    Pokoje > 3,
    Lazienki > 2,
    Pow > 80,
    Stan > 3.

wynajem_oferta_ekonomiczna(OfertaWynajmu, Nieruchomosci) :-
    oferta_wynajmu_property_id(OfertaWynajmu, PropertyId),
    oferta_wynajmu_cena(OfertaWynajmu, Cena),
    member(Nieruchomosc, Nieruchomosci),
    nieruchomosc_id(Nieruchomosc, PropertyId),
    nieruchomosc_stan(Nieruchomosc, Stan),
    Cena < 2000,
    Stan > 3.

wynajem_oferta_luksusowa(OfertaWynajmu, Nieruchomosci) :-
    oferta_wynajmu_property_id(OfertaWynajmu, PropertyId),
    oferta_wynajmu_cena(OfertaWynajmu, Cena),
    member(Nieruchomosc, Nieruchomosci),
    nieruchomosc_id(Nieruchomosc, PropertyId),
    nieruchomosc_powierzchnia(Nieruchomosc, Pow),
    nieruchomosc_standard(Nieruchomosc, Standard),
    nieruchomosc_lazienki(Nieruchomosc, Lazienki),
    nieruchomosc_umeblowane(Nieruchomosc, Umeblowane),
    Pow > 150,
    Lazienki >= 3,
    Standard = wysoki,
    Umeblowane = tak,
    Cena > 5000.

wynajem_oferta_przyjazna_zwierzetom(OfertaWynajmu, Nieruchomosci) :-
    oferta_wynajmu_property_id(OfertaWynajmu, PropertyId),
    oferta_wynajmu_polityka_zwierzat(OfertaWynajmu, PolitykaZwierzat),
    member(Nieruchomosc, Nieruchomosci),
    nieruchomosc_id(Nieruchomosc, PropertyId),
    nieruchomosc_typ(Nieruchomosc, Typ),
    nieruchomosc_nr_pietra(Nieruchomosc, NrPietra),
    nieruchomosc_winda(Nieruchomosc, Winda),
    member(Typ, [dom, mieszkanie]),
    PolitykaZwierzat \= 'nie',
    (NrPietra = 0 ; Winda = tak).

wynajem_oferta_dla_seniorow(OfertaWynajmu, Nieruchomosci) :-
    oferta_wynajmu_property_id(OfertaWynajmu, PropertyId),
    member(Nieruchomosc, Nieruchomosci),
    nieruchomosc_id(Nieruchomosc, PropertyId),
    nieruchomosc_nr_pietra(Nieruchomosc, NrPietra),
    nieruchomosc_winda(Nieruchomosc, Winda),
    nieruchomosc_odleglosc(Nieruchomosc, Odleglosc),
    (NrPietra = 0 ; Winda = tak),
    w_dobrym_stanie(Nieruchomosc),
    Odleglosc >= 5,
    wynajem_oferta_ekonomiczna(OfertaWynajmu, Nieruchomosci).

wynajem_oferta_ekologiczna(OfertaWynajmu, Nieruchomosci) :-
    oferta_wynajmu_property_id(OfertaWynajmu, PropertyId),
    member(Nieruchomosc, Nieruchomosci),
    nieruchomosc_id(Nieruchomosc, PropertyId),
    nieruchomosc_energia(Nieruchomosc, Energia),
    member(Energia, ['a','a+', 'a++', 'a+++']).

wynajem_oferta_krotkoterminowa(OfertaWynajmu, _) :-
    oferta_wynajmu_min_okres(OfertaWynajmu, MinOkres),
    MinOkres < 6.

wynajem_oferta_dlugoterminowa(OfertaWynajmu, _) :-
    oferta_wynajmu_max_okres(OfertaWynajmu, MaxOkres),
    MaxOkres > 12.

wynajem_oferta_dostepna_od_zaraz(OfertaWynajmu, _) :-
    oferta_wynajmu_min_start(OfertaWynajmu, MinStart),
    get_time(Today),
    OneMonth is 30*24*60*60,
    Deadline is Today + OneMonth,
    MinStart =< Deadline.