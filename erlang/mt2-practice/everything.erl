-module(everything).

-import(rand, [uniform/1]).

-export([rlist/2, count3s/1]).

rlist(0, _) ->
    [];
rlist(N, Lim) ->
    [rand:uniform(Lim) || _ <- lists:seq(N)].

count3s(A) ->
    count3s(A, 0).

count3s([], Acc) ->
    Acc;
count3s([Hd | Tl], Acc) ->
    case Hd =:= 3 of
        true ->
            count3s(Tl, Acc + 1);
        false ->
            count3s(Tl, Acc)
    end.

