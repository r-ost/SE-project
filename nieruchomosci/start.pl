:- set_prolog_flag(encoding, utf8).
:- encoding(utf8).
:- consult('wnioskowanie.pl').
:- consult('baza_wiedzy.pl').
:- consult('rozmyte.pl').


% Czyta pojedynczy znak i ignoruje znak nowej linii
read_char(Char) :-
    get_char(Char),
    get_char(_).  % odczytuje znak nowej linii i ignoruje go


start :-
    
    write('Czy szukasz mieszkania atrakcyjnego? (t/n)'), nl,
    read_char(Odp),
    write('Wczytano odpowiedź: '), write(Odp), nl,
    ( Odp == t -> 
        findall(ID, atrakcyjne_mieszkanie(ID), Lista),
        wypisz_wyniki(Lista)
    ;   
        write('Pominięto pytanie.'), nl
    ),
    nl,
    write('Czy szukasz mieszkania dla rodziny? (t/n)'), nl,
    read_char(Odp2),
    ( Odp2 == t ->
        findall(ID2, dobre_dla_rodziny(ID2), Lista2),
        wypisz_wyniki(Lista2)
    ;   write('Pominięto pytanie.'), nl
    ),
    nl,
    write('Czy chcesz zobaczyć nieruchomości z wysoką atrakcyjnością rozmytą? (t/n)'), nl,
    read_char(Odp3),
    ( Odp3 = 't' ->
        findall(ID-Ocena,
            (nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _),
             atrakcyjnosc(ID, Ocena),
             Ocena > 0.6),
            Lista3),
        wypisz_rozmyte(Lista3)
    ;   write('Pominięto pytanie.'), nl
    ).

wypisz_wyniki([]) :-
    write('Nie znaleziono więcej pasujących nieruchomości.'), nl.
wypisz_wyniki([H|T]) :-
    write('Znaleziono: '), write(H), nl,
    wypisz_wyniki(T).

wypisz_rozmyte([]) :-
    write('Brak więcej pasujących nieruchomości.'), nl.
wypisz_rozmyte([ID-Ocena | T]) :-
    format('Znaleziono: ~w (atrakcyjność: ~2f)~n', [ID, Ocena]),
    wypisz_rozmyte(T).