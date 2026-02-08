-module(maximum).

-export([maximum/1]).

maximum([Hd | Tl]) ->
    maximum(Tl, Hd).

maximum([], Acc) ->
    Acc;
maximum([Hd | Tl], Acc) ->
    case Hd > Acc of
        true ->
            maximum(Tl, Hd);
        false ->
            maximum(Tl, Acc)
    end.
