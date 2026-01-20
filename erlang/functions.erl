-module(functions).
-export([right_age/1]).

right_age(X) when X >= 16, X =< 104 -> true;
right_age(_) -> false.
