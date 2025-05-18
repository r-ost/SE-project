:- use_module(library(record)).
:- use_module(library(csv)).
:- consult('utils.pl').

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

read_oferty_sprzedazy_from_csv(Filename, Oferty) :-
    csv_read_file(Filename, AllRows, [functor(row)]),
    % Skip header row (first row)
    (AllRows = [_HeaderRow|DataRows] -> 
        maplist(row_to_oferta_sprzedazy, DataRows, Oferty)
    ; 
        % Handle empty file case
        Oferty = []
    ).

% Convert a CSV row to an oferta_sprzedazy record
row_to_oferta_sprzedazy(Row, OfertaSprzedazy) :-
    Row =.. [row|Values],
    % Assuming the CSV has headers and values in the same order as the record definition
    [Id, PropertyId, Status, CenaVal, Negocjacja, CenaMaxVal, CenaMinVal, 
     DataWystawienia, DataWygasniecia, Platnosc] = Values,
    
    % Convert values to appropriate types with proper error handling
    safe_number_conversion(CenaVal, Cena),
    safe_number_conversion(CenaMaxVal, CenaMax),
    safe_number_conversion(CenaMinVal, CenaMin),
    
    make_oferta_sprzedazy([
        id(Id),
        property_id(PropertyId),
        status(Status),
        cena(Cena),
        negocjacja(Negocjacja),
        cena_max(CenaMax),
        cena_min(CenaMin),
        data_wystawienia(DataWystawienia),
        data_wygasniecia(DataWygasniecia),
        platnosc(Platnosc)
    ], OfertaSprzedazy).

