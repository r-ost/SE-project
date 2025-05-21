:- use_module(library(record)).
:- use_module(library(csv)).
:- consult('utils.pl').

:- record oferta_wynajmu(
    id,
    property_id,
    status,
    cena,
    koszty_dodatkowe,
    opis_kosztow,
    kaucja,
    negocjacja,
    cena_max,
    cena_min,
    data_wystawienia,
    data_wygasniecia,
    min_start,
    max_start,
    min_okres,
    max_okres,
    umowa,
    typ_najmu,
    lokatorzy,
    opis_lokatorow,
    preferowany_najemca,
    zwierzeta,
    polityka_zwierzat,
    opis,
    typ_wlasciciela
).

read_oferty_wynajmu_from_csv(Filename, Oferty) :-
    csv_read_file(Filename, AllRows, [functor(row)]),
    % Skip header row (first row)
    (AllRows = [_HeaderRow|DataRows] -> 
        maplist(row_to_oferta_wynajmu, DataRows, Oferty)
    ; 
        % Handle empty file case
        Oferty = []
    ).

% Convert a CSV row to an oferta_wynajmu record
row_to_oferta_wynajmu(Row, OfertaWynajmu) :-
    Row =.. [row|Values],
    % Assuming the CSV has headers and values in the same order as the record definition
    [Id, PropertyId, Status, CenaVal, KosztyDodatkoweVal, OpisKosztow, KaucjaVal, 
     Negocjacja, CenaMaxVal, CenaMinVal, DataWystawienia, DataWygasniecia, 
     MinStartVal, MaxStartVal, MinOkresVal, MaxOkresVal, Umowa, TypNajmu, 
     Lokatorzy, OpisLokatorow, PreferowanyNajemca, Zwierzeta, 
     PolitykaZwierzat, Opis, TypWlasciciela] = Values,
    
    % Convert values to appropriate types with proper error handling
    safe_number_conversion(CenaVal, Cena),
    safe_number_conversion(KosztyDodatkoweVal, KosztyDodatkowe),
    safe_number_conversion(KaucjaVal, Kaucja),
    safe_number_conversion(CenaMaxVal, CenaMax),
    safe_number_conversion(CenaMinVal, CenaMin),
    safe_number_conversion(MinStartVal, MinStart),
    safe_number_conversion(MaxStartVal, MaxStart),
    safe_number_conversion(MinOkresVal, MinOkres),
    safe_number_conversion(MaxOkresVal, MaxOkres),
    
    make_oferta_wynajmu([
        id(Id),
        property_id(PropertyId),
        status(Status),
        cena(Cena),
        koszty_dodatkowe(KosztyDodatkowe),
        opis_kosztow(OpisKosztow),
        kaucja(Kaucja),
        negocjacja(Negocjacja),
        cena_max(CenaMax),
        cena_min(CenaMin),
        data_wystawienia(DataWystawienia),
        data_wygasniecia(DataWygasniecia),
        min_start(MinStart),
        max_start(MaxStart),
        min_okres(MinOkres),
        max_okres(MaxOkres),
        umowa(Umowa),
        typ_najmu(TypNajmu),
        lokatorzy(Lokatorzy),
        opis_lokatorow(OpisLokatorow),
        preferowany_najemca(PreferowanyNajemca),
        zwierzeta(Zwierzeta),
        polityka_zwierzat(PolitykaZwierzat),
        opis(Opis),
        typ_wlasciciela(TypWlasciciela)
    ], OfertaWynajmu).
