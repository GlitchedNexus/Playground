-module(hhfuns).
-export([add/2, one/0, two/0,
        increment/1, decrement/1, incr/1, decr/1,
        map/2, base/1
    ]).

one() -> 1.
two() -> 2.

add(X,Y) -> X() + Y().
% call add after compiling using
% hhfuns:add(fun hhfuns:one/0, fun hhfuns:two/0).

increment([]) -> [];
increment([H|T]) -> [H+1|increment(T)].

decrement([]) -> [];
decrement([H|T]) -> [H-1|decrement(T)].

map(_, []) -> [];
map(F, [H|T]) -> [F(H)| map(F,T)].

incr(X) -> X + 1.
decr(X) -> X - 1.

% Anonymous functions
% fun(Args1) ->
%         Expression One, Expression Two, Expression, ..,. Expression N;
%    (Args2) ->
%        Expression One, Expression Two, Expression, ..,. Expression N;
%    (Args3) ->
%        Expression One, Expression Two, Expression, ..,. Expression N
%    end

base(A) ->
    B = A + 1,
    F = fun() -> A * B end,
    F().
