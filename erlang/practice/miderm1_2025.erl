-module(miderm1_2025).

-export([take/2]).

take(L, P) when is_list(L), is_integer(P), P >= 0 ->
    take(L, P, []).

take([], _P, Acc) ->
    Acc;
take([Hd | Tl], P, Acc) ->
    take(Tl, P - 1, lists:append([Hd], Acc)).
