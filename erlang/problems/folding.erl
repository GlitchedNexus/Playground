-module(folding).

-export([folding/3]).

folding(_Op, Acc, []) ->
    Acc;
folding(Op, Acc, [Hd | Tl]) ->
    folding(Op, Op(Hd, Acc), Tl).
