
% Czyta pojedynczy znak i ignoruje znak nowej linii
read_char(Char) :-
    get_char(Char),
    get_char(_).  % odczytuje znak nowej linii i ignoruje go

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

czytaj_odpowiedz(Odp) :-
    read_line_to_string(user_input, Str),
    string_lower(Str, Lower),
    ( member(Lower, ["t", "tak", "y"]) -> Odp = t
    ; member(Lower, ["n", "nie"])     -> Odp = n
    ; write('Niepoprawna odpowiedź. Wpisz t lub n.'), nl, czytaj_odpowiedz(Odp)
    ).
