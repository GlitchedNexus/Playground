-module(final_2025).

-export([foo/1, foo_tail/1]).

foo([]) ->
    -4;
foo([Hd | Tl]) ->
    Hd * Hd + 2 * foo(Tl) + 5.

foo_tail(L) ->
    foo_tail(lists:reverse(L), -4).

foo_tail([], Acc) ->
    Acc;
foo_tail([Hd | Tl], Acc) ->
    foo_tail(Tl, Hd * Hd + 2 * Acc + 5).
