-module(count3s).
-export([count3s/1]).

count3s([]) -> 0.
count3s([3 | Tail]) -> 1 + count3s(Tail).
count3s([_Other | Tail]) -> count3s(Tail).
