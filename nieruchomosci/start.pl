:- use_module(library(record)).

:- set_prolog_flag(encoding, utf8). %polskie znaki
:- encoding(utf8). %polskie znaki
:- consult('reguly/reguly_nieruchomosci.pl'). % Wczytanie pliku z regułami
:- consult('reguly/reguly_sprzedaz.pl'). % Wczytanie pliku z regułami
:- consult('reguly/reguly_wynajem.pl'). % Wczytanie pliku z regułami
:- consult('rozmyte.pl').
:- consult('pomocnicze.pl'). 
:- consult('baza_wiedzy/nieruchomosc.pl').
:- consult('baza_wiedzy/oferta_sprzedazy.pl').
:- consult('baza_wiedzy/oferta_wynajmu.pl').


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
    read_nieruchomosci_from_csv('baza_wiedzy/csv/nieruchomosci.csv', Nieruchomosci),
    read_oferty_sprzedazy_from_csv('baza_wiedzy/csv/oferty_sprzedazy.csv', OfertySprzedazy),
    read_oferty_wynajmu_from_csv('baza_wiedzy/csv/oferty_wynajmu.csv', OfertyWynajmu),
    nl,
    write('Witaj w systemie rekomendacji nieruchomości!'), nl,
    write('Odpowiadaj na pytania wpisując: t (tak) lub n (nie).'), nl, nl,

    % Atrakcyjne mieszkanie
    write('Czy zależy Ci na atrakcyjnym mieszkaniu (dużym, blisko centrum, w dobrym stanie)? (t/n)'), nl,
    czytaj_odpowiedz(Odp1),
    ( Odp1 == t ->
        findall(ID1, (
            member(Nieruchomosc, Nieruchomosci),
            nieruchomosc_id(Nieruchomosc, ID1),
            atrakcyjne_mieszkanie(Nieruchomosc)
        ), Lista1),
        write('Znalezione atrakcyjne mieszkania:'), nl,
        wypisz_wyniki(Lista1)
    ;
        write('Pominięto filtr atrakcyjności.'), nl
    ),

    write('Czy zależy Ci na ofercie sprzedaży dla rodziny (więcej pokoi, większy metraż)? (t/n)'), nl,
    czytaj_odpowiedz(Odp2),
    ( Odp2 == t ->
        findall(ID2, (
            member(OfertaSprzedazy, OfertySprzedazy),
            oferta_sprzedazy_id(OfertaSprzedazy, ID2),
            sprzedaz_oferta_rodzinna(OfertaSprzedazy, Nieruchomosci)
        ), Lista2),
        write('Znalezione oferty sprzedaży odpowiednie dla rodziny:'), nl,
        wypisz_wyniki(Lista2)
    ;
        write('Pominięto filtr oferty sprzedaży dla rodziny.'), nl
    ).

    % % Dla rodziny, ale tylko jeśli nie zaznaczono już atrakcyjności
    % nl,
    % ( Odp1 == t ->
    %     nl
    % ;
    %     write('Czy szukasz mieszkania dla rodziny (więcej pokoi, większy metraż)? (t/n)'), nl,
    %     czytaj_odpowiedz(Odp2),
    %     ( Odp2 == t ->
    %         findall(ID2, dla_rodziny(ID2), Lista2),
    %         write('Znalezione mieszkania odpowiednie dla rodziny:'), nl,
    %         wypisz_wyniki(Lista2)
    %     ;
    %         write('Pominięto filtr rodzinny.'), nl
    %     )
    % ),

    % % Dla seniora tylko jeśli nie dla rodziny
    % nl,
    % ( (Odp1 == t ; Odp2 == t) ->
    %     nl
    % ;
    %     write('Czy szukasz mieszkania dla seniora (parter/winda, spokojna okolica)? (t/n)'), nl,
    %     czytaj_odpowiedz(Odp3),
    %     ( Odp3 == t ->
    %         findall(ID3, dla_seniora(ID3), Lista3),
    %         write('Znalezione mieszkania przyjazne dla seniorów:'), nl,
    %         wypisz_wyniki(Lista3)
    %     ;
    %         write('Pominięto filtr senioralny.'), nl
    %     )
    % ),

    % nl,
    % write('Dziękujemy za skorzystanie z systemu rekomendacji.').

    % nl,
    % write('Czy chcesz zobaczyć nieruchomości z wysoką atrakcyjnością rozmytą? (t/n)'), nl,
    % read_char(Odp3),
    % ( Odp3 = 't' ->
    %     findall(ID-Ocena,
    %         (nieruchomosc(ID, _, _, _, _, _, _, _, _, _, _, _),
    %          atrakcyjnosc(ID, Ocena),
    %          Ocena > 0.6),
    %         Lista3),
    %     wypisz_rozmyte(Lista3)
    % ;   write('Pominięto pytanie.'), nl
    % ).
