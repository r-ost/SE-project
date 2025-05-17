% Reguły przynależności rozmytej do kategorii powierzchni

% Małe mieszkanie
przynaleznosc_male(Pow, W) :-
    ( Pow =< 40 -> W is 1.0
    ; Pow =< 50 -> W is (50 - Pow) / 10
    ; W is 0.0 ).

% Średnie mieszkanie
przynaleznosc_srednie(Pow, W) :-
    ( Pow >= 40, Pow =< 60 -> W is (Pow - 40) / 20
    ; Pow > 60, Pow =< 80 -> W is (80 - Pow) / 20
    ; W is 0.0 ).

% Duże mieszkanie
przynaleznosc_duze(Pow, W) :-
    ( Pow >= 80, Pow =< 90 -> W is (Pow - 80) / 10
    ; Pow > 90 -> W is 1.0
    ; W is 0.0 ).

% Blisko centrum (mniej = lepiej)
przynaleznosc_blisko_centrum(Odl, W) :-
    ( Odl =< 2 -> W is 1.0
    ; Odl > 2, Odl =< 5 -> W is (5 - Odl) / 3
    ; W is 0.0 ).

% Dobry stan
przynaleznosc_dobry_stan(Stan, W) :-
    ( Stan >= 5 -> W is 1.0
    ; Stan >= 3 -> W is (Stan - 3) / 2
    ; W is 0.0 ).

% Ocena atrakcyjności rozmytej
% atrakcyjnosc(ID, Ocena) :-
%     nieruchomosc(ID, mieszkanie, _, Pow, Pokoje, Lazienki, _, Stan, Odl, _, _, _),
%     przynaleznosc_duze(Pow, W1),
%     przynaleznosc_blisko_centrum(Odl, W2),
%     przynaleznosc_dobry_stan(Stan, W3),
%     (Pokoje > 2 -> W4 = 1.0 ; W4 = 0.0),
%     (Lazienki > 2 -> W5 = 1.0 ; W5 = 0.0),  
%     Ocena is (W1 + W2 + W3 + W4 + W5) / 5.
