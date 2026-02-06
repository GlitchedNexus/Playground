-module(recursion).
-export([fac/1, len/1, tail_fac/1, tail_len/1]).

fac(N) when N == 0 -> 1;
fac(N) when N > 0  -> N * fac(N-1).

tail_fac(N) -> tail_fac(N,1).
tail_fac(0,Acc) -> Acc;
tail_fac(N,Acc) when N > 0 -> tail_fac(N-1,N*Acc).

len([]) -> 0;
len([_ | T]) -> 1 + len(T).


tail_len(Arr) -> tail_len(Arr, 0).
tail_len([], Acc) -> Acc;
tail_len([_|T], Acc) -> tail_len(T, 1 + Acc).

duplicate(0, _) -> [];
duplicate(N, Term) -> [Term | duplicate(N-1, Term)].

duplicate_tail(N, Term) -> duplicate_tail(N, Term, []).
duplicate_tail(0, _, Acc) -> Acc
duplicate_tail(N, Term, Acc) -> duplicate_tail(N-1, Term, [Term | Acc])


reverse([]) -> [];
reverse([H|T]) -> reverse(T) ++ [H].

tail_reverse(L) -> tail_reverse(L, []).
tail_reverse([], Acc) -> Acc;
tail_reverse([H|T], Acc) -> tail_reverse(T, [H]++Acc).

tail_sublist(L, N) -> tail_sublist(L, N, []).
%  We need to reverse because if we simply append we will
% have to push elements onto the stack before they can be
% joined together.
tail_sublist(_, 0, SubList) -> reverse(tail_sublist(L, N, [])).
tail_sublist([], _, SubList) -> reverse(tail_sublist(L, N, [])).
tail_sublist([H|T], N, SubList) when N > 0 -> tail_sublist(T, N-1, [H|SubList]).
