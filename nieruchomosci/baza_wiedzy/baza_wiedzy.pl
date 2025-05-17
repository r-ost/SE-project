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

% Oferta sprzedaży: oferta_sprzedazy(ID, PropertyID, Status, Cena, Negocjacja, CenaMax, CenaMin, DataWystawienia, DataWygasniecia, Platnosc)
oferta_sprzedazy(o1, n1, aktywna, 480000, tak, 500000, 450000, 2025-04-01, 2025-08-01, gotowka).
oferta_sprzedazy(o2, n2, aktywna, 620000, tak, 650000, 600000, 2025-05-10, 2025-09-10, przelew).
oferta_sprzedazy(o3, n3, nieaktywna, 315000, nie, 315000, 315000, 2025-01-15, 2025-04-15, gotowka).
oferta_sprzedazy(o4, n4, aktywna, 890000, tak, 920000, 860000, 2025-03-20, 2025-07-20, kredyt).
oferta_sprzedazy(o5, n5, aktywna, 755000, nie, 755000, 755000, 2025-02-01, 2025-06-01, gotowka).
oferta_sprzedazy(o6, n6, nieaktywna, 270000, tak, 290000, 250000, 2024-11-05, 2025-03-05, przelew).
oferta_sprzedazy(o7, n7, aktywna, 1200000, tak, 1250000, 1150000, 2025-04-25, 2025-08-25, kredyt).
oferta_sprzedazy(o8, n8, aktywna, 510000, nie, 510000, 510000, 2025-05-01, 2025-09-01, gotowka).


% Oferta wynajmu: oferta_wynajmu(ID, PropertyID, AgentID, Status, Cena, KosztyDodatkowe, OpisKosztow, Kaucja,
% Negocjacja, MaxCena, MinCena, Wystawienie, Wygasniecie, MinStart, MaxStart, MinOkres, MaxOkres,
% Umowa, TypNajmu, Lokatorzy, OpisLokatorow, PreferowanyNajemca, Zwierzeta, PolitykaZwierzat, Opis, TypWlasciciela)

oferta_wynajmu(w1, n1, p1, aktywna, 1800, 300, 'media', 2000, tak, 2000, 1500, 2025-04-01, 2025-07-01,
2025-06-01, 2025-06-15, 3, 12, 'najem okazjonalny', calkowity, 0, 'brak', student, tak, 'możliwe małe zwierzęta', 'opis oferty', osoba_prywatna).
