:- use_module(library(record)).
:- use_module(library(csv)).
:- consult('utils.pl').

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

read_nieruchomosci_from_csv(Filename, Nieruchomosci) :-
    csv_read_file(Filename, AllRows, [functor(row)]),
    % Skip header row (first row)
    (AllRows = [_HeaderRow|DataRows] -> 
        maplist(row_to_nieruchomosc, DataRows, Nieruchomosci)
    ; 
        % Handle empty file case
        Nieruchomosci = []
    ).

% Convert a CSV row to a nieruchomosc record
row_to_nieruchomosc(Row, Nieruchomosc) :-
    Row =.. [row|Values],
    % Assuming the CSV has headers and values in the same order as the record definition
    [Id, Typ, Lokalizacja, Ulica, Miasto, Region, KodPocztowy, Kraj, 
     LatVal, LongVal, OdlegloscVal, PowierzchniaVal, Standard, 
     PokojeVal, LazienkaVal, RokVal, Konstrukcja, PietraVal, NrPietraVal, 
     Winda, Parking, TypParking, Umeblowane, Ogrzewanie, Energia, 
     Powodz, Stan, Opis, Dostepnosc, OstatniRemontVal, Utworzono, Zaktualizowano] = Values,
    
    % Convert values to appropriate types with proper error handling
    safe_number_conversion(LatVal, Lat),
    safe_number_conversion(LongVal, Long),
    safe_number_conversion(OdlegloscVal, Odleglosc),
    safe_number_conversion(PowierzchniaVal, Powierzchnia),
    safe_number_conversion(PokojeVal, Pokoje),
    safe_number_conversion(LazienkaVal, Lazienki),
    safe_number_conversion(RokVal, Rok),
    safe_number_conversion(PietraVal, Pietra),
    safe_number_conversion(NrPietraVal, NrPietra),
    safe_number_conversion(OstatniRemontVal, OstatniRemont),
    
    make_nieruchomosc([
        id(Id),
        typ(Typ),
        lokalizacja(Lokalizacja),
        ulica(Ulica),
        miasto(Miasto),
        region(Region),
        kod_pocztowy(KodPocztowy),
        kraj(Kraj),
        lat(Lat),
        long(Long),
        odleglosc(Odleglosc),
        powierzchnia(Powierzchnia),
        standard(Standard),
        pokoje(Pokoje),
        lazienki(Lazienki),
        rok(Rok),
        konstrukcja(Konstrukcja),
        pietra(Pietra),
        nr_pietra(NrPietra),
        winda(Winda),
        parking(Parking),
        typ_parking(TypParking),
        umeblowane(Umeblowane),
        ogrzewanie(Ogrzewanie),
        energia(Energia),
        powodz(Powodz),
        stan(Stan),
        opis(Opis),
        dostepnosc(Dostepnosc),
        ostatni_remont(OstatniRemont),
        utworzono(Utworzono),
        zaktualizowano(Zaktualizowano)
    ], Nieruchomosc).

    