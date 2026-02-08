-module(sum).

-export([sum/1]).

sum([Hd | Tl]) ->
    sum([Hd | Tl], 0).

sum([], Acc) ->
    Acc;
sum([Hd | Tl], Acc) ->
    sum(Tl, Acc + Hd).
