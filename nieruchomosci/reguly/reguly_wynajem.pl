% --- Reguły W: wynajem ---
wynajem_oferta_dla_studentow(_OfertaWynajmu, Nieruchomosc) :-
    nieruchomosc_pokoje(Nieruchomosc, Pokoje),
    nieruchomosc_lazienki(Nieruchomosc, Lazienki),
    nieruchomosc_stan(Nieruchomosc, Stan),
    Pokoje > 2,
    Lazienki > 1,
    Stan > 3.

wynajem_oferta_dla_rodzin(_OfertaWynajmu, Nieruchomosc) :-
    nieruchomosc_pokoje(Nieruchomosc, Pokoje),
    nieruchomosc_lazienki(Nieruchomosc, Lazienki),
    nieruchomosc_powierzchnia(Nieruchomosc, Pow),
    nieruchomosc_stan(Nieruchomosc, Stan),
    Pokoje > 3,
    Lazienki > 2,
    Pow > 80,
    Stan > 3.

wynajem_oferta_ekonomiczna(OfertaWynajmu, Nieruchomosc) :-
    oferta_wynajmu_cena(OfertaWynajmu, Cena),
    nieruchomosc_stan(Nieruchomosc, Stan),
    Cena < 2000,
    Stan > 3.

wynajem_oferta_luksusowa(OfertaWynajmu, Nieruchomosc) :-
    oferta_wynajmu_cena(OfertaWynajmu, Cena),
    nieruchomosc_powierzchnia(Nieruchomosc, Pow),
    nieruchomosc_standard(Nieruchomosc, Standard),
    nieruchomosc_lazienki(Nieruchomosc, Lazienki),
    nieruchomosc_umeblowane(Nieruchomosc, Umeblowane),
    Pow > 150,
    Lazienki >= 3,
    Standard = wysoki,
    Umeblowane = tak,
    Cena > 5000.

wynajem_oferta_przyjazna_zwierzetom(_OfertaWynajmu, Nieruchomosc) :-
    nieruchomosc_typ(Nieruchomosc, Typ),
    nieruchomosc_nr_pietra(Nieruchomosc, NrPietra),
    nieruchomosc_winda(Nieruchomosc, Winda),
    member(Typ, [dom, mieszkanie]),
    % Tu musisz mieć politykę zwierząt w nieruchomości lub ofercie!
    % nieruchomosc_polityka_zwierzat(Nieruchomosc, PolitykaZwierzat),
    % PolitykaZwierzat \= 'nie',
    (NrPietra = 0 ; Winda = tak).

wynajem_oferta_dla_seniorow(OfertaWynajmu, Nieruchomosc) :-
    nieruchomosc_nr_pietra(Nieruchomosc, NrPietra),
    nieruchomosc_winda(Nieruchomosc, Winda),
    nieruchomosc_odleglosc(Nieruchomosc, Odleglosc),
    w_dobrym_stanie(Nieruchomosc),
    Odleglosc >= 5,
    wynajem_oferta_ekonomiczna(OfertaWynajmu, Nieruchomosc).

wynajem_oferta_ekologiczna(_OfertaWynajmu, Nieruchomosc) :-
    nieruchomosc_energia(Nieruchomosc, Energia),
    member(Energia, ['a','a+', 'a++', 'a+++']).

wynajem_oferta_krotkoterminowa(OfertaWynajmu, _Nieruchomosc) :-
    oferta_wynajmu_min_okres(OfertaWynajmu, MinOkres),
    MinOkres < 6.

wynajem_oferta_dlugoterminowa(OfertaWynajmu, _Nieruchomosc) :-
    oferta_wynajmu_max_okres(OfertaWynajmu, MaxOkres),
    MaxOkres > 12.

wynajem_oferta_dostepna_od_zaraz(OfertaWynajmu, _Nieruchomosc) :-
    oferta_wynajmu_min_start(OfertaWynajmu, MinStart),
    get_time(Today),
    OneMonth is 30*24*60*60,
    Deadline is Today + OneMonth,
    MinStart =< Deadline.

wynajem_oferta_nowe(_OfertaWynajmu, Nieruchomosc) :-
    nowe(Nieruchomosc).