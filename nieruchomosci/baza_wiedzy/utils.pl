safe_number_conversion(Value, Number) :-
    (number(Value) -> 
        Number = Value
    ; atom(Value) -> 
        (atom_number(Value, Number) -> true ; Number = 0)
    ; Number = 0).