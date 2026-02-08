-module(prod).

-export([prod/1]).

prod([Hd | Tl]) ->
    prod([Hd | Tl], 1).

prod([], Acc) ->
    Acc;
prod([Hd | Tl], Acc) ->
    prod(Tl, Acc * Hd).
