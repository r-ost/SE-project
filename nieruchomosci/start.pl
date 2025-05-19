:- use_module(library(record)).

:- set_prolog_flag(encoding, utf8).
:- encoding(utf8).

% Załaduj wszystkie niezbędne pliki z regułami i bazą wiedzy
:- consult('reguly/reguly_nieruchomosci.pl').
:- consult('reguly/reguly_sprzedaz.pl').
:- consult('reguly/reguly_wynajem.pl').
:- consult('rozmyte.pl').
:- consult('pomocnicze.pl'). 
:- consult('baza_wiedzy/nieruchomosc.pl').
:- consult('baza_wiedzy/oferta_sprzedazy.pl').
:- consult('baza_wiedzy/oferta_wynajmu.pl').

% -------------------------------
% Jak odpalić:
% cd nieruchomosci
% swipl
% ?- [start].
% ?- start.
% -------------------------------

start :-
    read_nieruchomosci_from_csv('baza_wiedzy/csv/nieruchomosci.csv', Nieruchomosci),
    read_oferty_sprzedazy_from_csv('baza_wiedzy/csv/oferty_sprzedazy.csv', OfertySprzedazy),
    read_oferty_wynajmu_from_csv('baza_wiedzy/csv/oferty_wynajmu.csv', OfertyWynajmu),

    nl,
    write('Witaj w systemie rekomendacji nieruchomości!'), nl,
    write('Czy chcesz kupić czy wynająć nieruchomość? (k - kupić, w - wynająć)'), nl,
    czytaj_wybor_k_w(Wybor),

    ( Wybor == k ->
        zbierz_filtry_sprzedaz(Filtry),
       
        filtruj_i_wypisz_sprzedaz(Filtry, Nieruchomosci, OfertySprzedazy, PasujaceNieruchomosci),
      
        % Możesz tutaj użyć PasujaceNieruchomosci do dalszej logiki lub zapisać
        true
    ; Wybor == w ->
        zbierz_filtry_wynajem(Filtry),
        filtruj_i_wypisz_wynajem(Filtry, Nieruchomosci, OfertyWynajmu, PasujaceNieruchomosci),
        % Możesz tutaj użyć PasujaceNieruchomosci do dalszej logiki lub zapisać
        true
    ; 
        write('Niepoprawny wybór. Spróbuj ponownie.'), nl,
        start
    ).




% --- Zbieranie filtrów dla wynajmu ---
zbierz_filtry_wynajem(filtry{
    dla_studenta: O1,
    dla_rodziny: O2,
    dla_seniora: O3,
    nowe: O4,
    energooszczedne: O5,
    ekonomiczne: O6,
    luksusowe: O7,
    przyjazne_zwierzetom: O8,
    krotkoterminowe: O9,
    dlugoterminowe: O10,
    dostepne_od_zaraz: O11
}) :-
    write('Czy szukasz mieszkania dla studenta (małe, blisko centrum)? (t/n)'), nl,
    czytaj_odpowiedz(O1),

    write('Czy szukasz mieszkania dla rodziny na wynajem? (t/n)'), nl,
    czytaj_odpowiedz(O2),

    write('Czy potrzebujesz mieszkania dostosowanego dla seniora? (t/n)'), nl,
    czytaj_odpowiedz(O3),

    write('Czy interesują Cię mieszkania nowe (po 2010 roku)? (t/n)'), nl,
    czytaj_odpowiedz(O4),

    write('Czy interesują Cię mieszkania energooszczędne? (t/n)'), nl,
    czytaj_odpowiedz(O5),

    write('Czy interesują Cię oferty ekonomiczne (niskie koszty)? (t/n)'), nl,
    czytaj_odpowiedz(O6),

    write('Czy interesują Cię oferty luksusowe? (t/n)'), nl,
    czytaj_odpowiedz(O7),

    write('Czy oferta ma być przyjazna zwierzętom? (t/n)'), nl,
    czytaj_odpowiedz(O8),

    write('Czy interesuje Cię najem krótkoterminowy? (t/n)'), nl,
    czytaj_odpowiedz(O9),

    write('Czy interesuje Cię najem długoterminowy? (t/n)'), nl,
    czytaj_odpowiedz(O10),

    write('Czy oferta ma być dostępna od zaraz? (t/n)'), nl,
    czytaj_odpowiedz(O11).

% --- Filtracja pojedynczej oferty wynajmu ---
filtruj_wynajem(Filtry, Nieruchomosc, Oferta) :-
    ( Filtry.dla_studenta == t        -> wynajem_oferta_dla_studentow(Oferta, Nieruchomosc) ; true ),
    ( Filtry.dla_rodziny == t         -> wynajem_oferta_dla_rodzin(Oferta, Nieruchomosc) ; true ),
    ( Filtry.dla_seniora == t         -> wynajem_oferta_dla_seniorow(Oferta, Nieruchomosc) ; true ),
    ( Filtry.nowe == t                -> wynajem_oferta_nowe(Oferta, Nieruchomosc) ; true ),
    ( Filtry.energooszczedne == t     -> wynajem_oferta_ekologiczna(Oferta, Nieruchomosc) ; true ),
    ( Filtry.ekonomiczne == t         -> wynajem_oferta_ekonomiczna(Oferta, Nieruchomosc) ; true ),
    ( Filtry.luksusowe == t           -> wynajem_oferta_luksusowa(Oferta, Nieruchomosc) ; true ),
    ( Filtry.przyjazne_zwierzetom == t-> wynajem_oferta_przyjazna_zwierzetom(Oferta, Nieruchomosc) ; true ),
    ( Filtry.krotkoterminowe == t     -> wynajem_oferta_krotkoterminowa(Oferta, Nieruchomosc) ; true ),
    ( Filtry.dlugoterminowe == t      -> wynajem_oferta_dlugoterminowa(Oferta, Nieruchomosc) ; true ),
    ( Filtry.dostepne_od_zaraz == t   -> wynajem_oferta_dostepna_od_zaraz(Oferta, Nieruchomosc) ; true ).

% --- Filtracja i wypisywanie wyników dla wynajmu ---
filtruj_i_wypisz_wynajem(Filtry, Nieruchomosci, OfertyWynajmu, PasujaceNieruchomosci) :-
    findall(Nieruchomosc, (
        member(Oferta, OfertyWynajmu),
        wynajem_oferta_nieruchomosc(Oferta, NieruchomoscID),
        member(Nieruchomosc, Nieruchomosci),
        nieruchomosc_id(Nieruchomosc, NieruchomoscID),
        filtruj_wynajem(Filtry, Nieruchomosc, Oferta)
    ), PasujaceNieruchomosci),

    ( PasujaceNieruchomosci == [] ->
        write('Nie znaleziono pasujących ofert wynajmu.'), nl
    ; write('Znalezione oferty wynajmu:'), nl,
      wypisz_wyniki(PasujaceNieruchomosci)
    ).

% --- Zbieranie filtrów dla sprzedaży ---
zbierz_filtry_sprzedaz(filtry{
    atrakcyjne: O1,
    dla_rodziny: O2,
    inwestycyjne: O3,
    wysoki_standard: O4,
    umeblowane: O5
}) :-
    write('Czy zależy Ci na atrakcyjnym mieszkaniu (dużym, blisko centrum, w dobrym stanie)? (t/n)'), nl,
    czytaj_odpowiedz(O1),

    write('Czy interesuje Cię oferta sprzedaży odpowiednia dla rodziny? (t/n)'), nl,
    czytaj_odpowiedz(O2),

    write('Czy interesują Cię oferty inwestycyjne (atrakcyjna cena za m2, dobra lokalizacja)? (t/n)'), nl,
    czytaj_odpowiedz(O3),

    write('Czy chcesz filtrować mieszkania ze standardem wysokim? (t/n)'), nl,
    czytaj_odpowiedz(O4),

    write('Czy interesują Cię mieszkania umeblowane? (t/n)'), nl,
    czytaj_odpowiedz(O5).


filtruj_sprzedaz(Filtry, Nieruchomosc, Oferta) :-    
    ( Filtry.atrakcyjne == t -> atrakcyjne_mieszkanie(Nieruchomosc) ; true ),
    ( Filtry.dla_rodziny == t -> sprzedaz_oferta_rodzinna(Oferta, Nieruchomosc) ; true ),
    ( Filtry.inwestycyjne == t -> sprzedaz_oferta_inwestycyjna(Oferta, Nieruchomosc) ; true ),
    ( Filtry.wysoki_standard == t -> wysoki_standard(Nieruchomosc) ; true ),
    ( Filtry.umeblowane == t -> umeblowane(Nieruchomosc) ; true ).


% --- Filtracja i wypisywanie wyników dla sprzedaży ---
filtruj_i_wypisz_sprzedaz(Filtry, Nieruchomosci, OfertySprzedazy, PasujaceNieruchomosci) :-
   
    findall(Nieruchomosc, (
        member(Oferta, OfertySprzedazy),
        sprzedaz_oferta_nieruchomosc(Oferta, NieruchomoscID),
        member(Nieruchomosc, Nieruchomosci),
        nieruchomosc_id(Nieruchomosc, NieruchomoscID),
        filtruj_sprzedaz(Filtry, Nieruchomosc, Oferta)

    ), PasujaceNieruchomosci),
       
    ( PasujaceNieruchomosci == [] ->
        write('Nie znaleziono pasujących ofert sprzedaży.'), nl
    ; write('Znalezione oferty sprzedaży:'), nl,
      wypisz_wyniki(PasujaceNieruchomosci)
    ).



% sprzedaz_oferta_nieruchomosc(+OfertaSprzedazy, -NieruchomoscID)
sprzedaz_oferta_nieruchomosc(OfertaSprzedazy, NieruchomoscID) :-
    oferta_sprzedazy_property_id(OfertaSprzedazy, NieruchomoscID).

% wynajem_oferta_nieruchomosc(+OfertaWynajmu, -NieruchomoscID)
wynajem_oferta_nieruchomosc(OfertaWynajmu, NieruchomoscID) :-
    oferta_wynajmu_property_id(OfertaWynajmu, NieruchomoscID).