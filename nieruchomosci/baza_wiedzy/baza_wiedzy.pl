:- use_module(library(record)).

:- record nieruchomosc(
    id,
    typ,
    lokalizacja,
    ulica,
    miasto,
    region,
    kod_pocztowy,
    kraj,
    lat,
    long,
    odleglosc,
    powierzchnia,
    standard,
    pokoje,
    lazienki,
    rok,
    konstrukcja,
    pietra,
    nr_pietra,
    winda,
    parking,
    typ_parking,
    umeblowane,
    ogrzewanie,
    energia,
    powodz,
    stan,
    opis,
    dostepnosc,
    ostatni_remont,
    utworzono,
    zaktualizowano
).

:- record oferta_sprzedazy(
    id,
    property_id,
    status,
    cena,
    negocjacja,
    cena_max,
    cena_min,
    data_wystawienia,
    data_wygasniecia,
    platnosc
).

% Oferta wynajmu: oferta_wynajmu(ID, PropertyID, AgentID, Status, Cena, KosztyDodatkowe, OpisKosztow, Kaucja,
% Negocjacja, MaxCena, MinCena, Wystawienie, Wygasniecie, MinStart, MaxStart, MinOkres, MaxOkres,
% Umowa, TypNajmu, Lokatorzy, OpisLokatorow, PreferowanyNajemca, Zwierzeta, PolitykaZwierzat, Opis, TypWlasciciela)

oferta_wynajmu(w1, n1, p1, aktywna, 1800, 300, 'media', 2000, tak, 2000, 1500, 2025-04-01, 2025-07-01,
2025-06-01, 2025-06-15, 3, 12, 'najem okazjonalny', calkowity, 0, 'brak', student, tak, 'możliwe małe zwierzęta', 'opis oferty', osoba_prywatna).
