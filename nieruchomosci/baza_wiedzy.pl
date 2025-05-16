% Nieruchomość: nieruchomosc(ID, Typ, Lokalizacja, Ulica, Miasto, Region, KodPocztowy, Kraj,
% Lat, Long, Odleglosc, Powierzchnia, Standard, Pokoje, Lazienki, Rok, Konstrukcja, Pietra, NrPietra,
% Winda, Parking, TypParking, Umeblowane, Ogrzewanie, Energia, Powodz, Stan, Opis, Dostepnosc, OstatniRemont, Utworzono, Zaktualizowano)

nieruchomosc(n1, mieszkanie, miasto, 'Ul. Kwiatowa 1', warszawa, mazowieckie, '00-001', polska,
52.2297, 21.0122, 2.5, 85, wysoki, 4, 2, 2018, cegla, 4, 3, tak, tak, garaz, tak, gazowe, a, niskie, 5, 'Opis n1', 2024-06-01, 2022-01-01, 2022-06-01).

% Pośrednik: posrednik(ID, Lokalizacja, ImieNazwisko, Email, Telefon, Licencja, Specjalizacja)
posrednik(p1, warszawa, 'Anna Kowalska', 'anna@example.com', '123456789', 'L12345', mieszkania).

% Oferta sprzedaży: oferta_sprzedazy(ID, PropertyID, AgentID, Status, Cena, Negocjacja, CenaMax, CenaMin, DataWystawienia, DataWygasniecia, Platnosc)
oferta_sprzedazy(o1, n1, p1, aktywna, 480000, tak, 500000, 450000, 2025-04-01, 2025-08-01, gotowka).

% Oferta wynajmu: oferta_wynajmu(ID, PropertyID, AgentID, Status, Cena, KosztyDodatkowe, OpisKosztow, Kaucja,
% Negocjacja, MaxCena, MinCena, Wystawienie, Wygasniecie, MinStart, MaxStart, MinOkres, MaxOkres,
% Umowa, TypNajmu, Lokatorzy, OpisLokatorow, PreferowanyNajemca, Zwierzeta, PolitykaZwierzat, Opis, TypWlasciciela)

oferta_wynajmu(w1, n1, p1, aktywna, 1800, 300, 'media', 2000, tak, 2000, 1500, 2025-04-01, 2025-07-01,
2025-06-01, 2025-06-15, 3, 12, 'najem okazjonalny', calkowity, 0, 'brak', student, tak, 'możliwe małe zwierzęta', 'opis oferty', osoba_prywatna).


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
