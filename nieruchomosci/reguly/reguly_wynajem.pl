:- consult('../baza_wiedzy.pl').

% --- Reguły W: wynajem ---
wynajem_oferta_dla_studentow(OID) :-
    oferta_wynajmu(OID, PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, _, _, Pokoje, Lazienki, _, _, _, _, _, _, _, _, _, _, _, _, Stan, _, _, _),
    Pokoje > 2,
    Lazienki > 1,
    Stan > 3.

wynajem_oferta_dla_rodzin(OID) :-
    oferta_wynajmu(OID, PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, Pow, _, Pokoje, Lazienki, _, _, _, _, _, _, _, _, _, _, _, _, Stan, _, _, _),
    Pokoje > 3,
    Lazienki > 2,
    Pow > 80,
    Stan > 3.

wynajem_oferta_ekonomiczna(OID) :-
    oferta_wynajmu(OID, PID, _, _, Cena, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Stan, _, _, _),
    Cena < 2000,
    Stan > 3.

wynajem_oferta_luksusowa(OID) :-
    oferta_wynajmu(OID, PID, _, _, Cena, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, Pow, wysoki, _, _, Lazienki, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    Pow > 150,
    Lazienki >= 3,
    umeblowane(PID),
    Cena > 5000.

wynajem_oferta_przyjazna_zwierzetom(OID) :-
    oferta_wynajmu(OID, PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, Typ, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, PolitykaZwierzat, _),
    member(Typ, [dom, mieszkanie]),
    PolitykaZwierzat \= 'nie',
    (parter(PID) ; budynek_z_winda(PID)).

wynajem_oferta_dla_seniorow(OID) :-
    oferta_wynajmu(OID, PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, NrP, _, Winda, _, _, _, _, _, _, _, _, _, _, _),
    (NrP = 0 ; Winda = tak),
    w_dobrym_stanie(PID),
    \+ blisko_centrum(PID),
    oferta_ekonomiczna(OID).

wynajem_oferta_ekologiczna(OID) :-
    oferta_wynajmu(OID, PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _),
    nieruchomosc(PID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, Energia, _, _, _, _, _, _),
    member(Energia, ['a','a+', 'a++', 'a+++']).

wynajem_oferta_krotkoterminowa(OID) :-
    oferta_wynajmu(OID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, MinOkres, _),
    MinOkres < 6.

wynajem_oferta_dlugoterminowa(OID) :-
    oferta_wynajmu(OID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, MaxOkres),
    MaxOkres > 12.

wynajem_oferta_dostepna_od_zaraz(OID) :-
    oferta_wynajmu(OID, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, MinStart, _),
    get_time(Today),
    OneMonth is 30*24*60*60,
    Deadline is Today + OneMonth,
    MinStart =< Deadline.