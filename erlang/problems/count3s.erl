-module(count3s).

-import(rand, [uniform/1]).

-export([count3s/2, rlist/2]).

count3s([], Acc) ->
    Acc;
count3s([3 | Tail], Acc) ->
    count3s(Tail, Acc + 1);
count3s([_Other | Tail], Acc) ->
    count3s(Tail, Acc).

rlist(0, _) ->
    [];
rlist(N, Lim) ->
    [rand:uniform(Lim) | rlist(N - 1, Lim)].
