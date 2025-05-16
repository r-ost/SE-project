:- set_prolog_flag(encoding, utf8). %polskie znaki
:- encoding(utf8). %polskie znaki
:- consult('wnioskowanie.pl'). % Wczytanie pliku z regułami
:- consult('baza_wiedzy.pl').
:- consult('rozmyte.pl').
:- consult('pomocnicze.pl'). 



% -------------------------------
% jak odpalić
% cd nieruchomosci
% swipl
% ?- [start].
% ?- start. 


% jak coś zmieniacie musicie na nowo załadować plik (obie linijki)

%jak tworzycie nowe zapytania to odp wczytujcie poprzez read_char
% bo do read potrzebna jest kropka (trzeba podawac t./n. a nie t/n)
% -------------------------------






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
