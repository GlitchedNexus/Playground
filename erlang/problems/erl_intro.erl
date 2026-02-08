-module(erl_intro).

% functions presented in the lecture
-export([count3s/1, factorial/1, sum/1, max/1, prod/1, fold/3]).
-export([sum_using_fold/1, prod_using_fold/1, max_using_fold/1]).
-export([fold_v1/2, sum_using_fold_v1/1]).
-export([longest_0_run/1, longest_run/2, longest_ascending/1]).
-export([msg_proc/1, msg_demo/0]).
% some handy utilities
-export([rlist/0, rlist/1, rlist/2, count/1, you_need_to_write_this/1]).
% functions from the review questions
-export([non_decreasing/1, non_decreasing_too_many_ifs/1, neighbours/1, flatten/1,
         flatten_too_many_ifs/1, calc_help/2, calc_l/2, calc_r/2, divisible_drop/2]).
-export([worst_flat/1]).

% you_need_to_write_this() -> error(...).  A place-holder so this module
%   will compile cleanly.  You should replace calls to you_need_to_write_this
%   with the solutions for in-class exercises.
you_need_to_write_this(Details) ->
    error(incomplete_code, Details).

% creating random lists
% rlist(N, M) -> a list of N random integers, where each element is
% uniformly distributed in [1, M]
rlist(0, _M) ->
    [];
rlist(N, M) ->
    [rand:uniform(M) | rlist(N - 1, M)].

rlist(N) ->
    rlist(N, 10).  % the default value for M is 10.

rlist() ->
    rlist(100).     % the default value for N is 100.

% The count3s example from the September 6 lecture
count3s([]) ->
    0;
count3s([3 | Tl]) ->
    1 + count3s(Tl);
count3s([_ | Tl]) ->
    count3s(Tl).

% the obligatory factorial example
factorial(0) ->
    1;
factorial(N) when is_integer(N), N > 0 ->
    N * factorial(N - 1).

% sum(List): code to write in class.
%   This file provides a template.  Replace you_need_to_write_this() with
%   expressions that implement list sum.  I wrote _Hd and _Tl for the
%   argument in the second pattern so that the Erlang compiler won't issue
%   warnings about unused variables.  Change their names to Hd and Tl when
%   you actually with _, but it's sloppy style.:1

sum([]) ->
    0;
sum([Hd | Tl]) ->
    Hd + sum(Tl).

% use the pattern from sum and count3s to implement prod and max:
prod([]) ->
    1;
prod([Hd | Tl]) ->
    Hd * prod(Tl).

% max(List) -> the greatest element of List, or 'neg_infinity' if List is empty.
%   Note that max/2 is an Erlang built-in function.  Because we are defining
%   max/1 there is no conflict.  Attempting to override an Erlang BIF will
%   provoke a warning from the compiler.
max([]) ->
    neg_infinity;
max([X]) ->
    X;
max([Hd | Tl]) ->
    case Hd > max(Tl) of
        true ->
            Hd;
        false ->
            max(Tl)
    end.

% fold_v1(Op, List) -> combine the elements of List using Op
fold_v1(_Op, [E]) ->
    E;
fold_v1(Op, [Hd | Tl]) ->
    Op(Hd, fold_v1(Op, Tl)).

% Now, we'll implement sum using fold_v1
sum_using_fold_v1(List) ->
    fold_v1(fun(E, Acc) -> E + Acc end, List).

% Fold with an initial accumulator.
% This function is equivalent to lists:foldr.
fold(_Op, Acc0, []) ->
    Acc0;
fold(Op, Acc0, [Hd | Tl]) ->
    Op(Hd, fold(Op, Acc0, Tl)).

% Simple examples of fold: sum_using_fold, prod_using_fold, max_using_fold.
%   I'm appending "_using_fold" to each function name so they won't conflict
%   with sum, prod, and max defined above.

sum_using_fold(List) ->
    fold(fun(E, Acc) -> E + Acc end, 0, List).

prod_using_fold(List) ->
    fold(fun(E, Acc) -> E * Acc end, 1, List).

max_using_fold([]) ->
    neg_infinity;
max_using_fold(List) ->
    fold(fun is_greater/2, hd(List), tl(List)).

is_greater(A, B) ->
    case A > B of
        true ->
            A;
        false ->
            B
    end.

% longest_0_run(List) -> the length of the longest sequence of consecutive 0s in List.
%   example: longest_0_run([0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1]) -> 4.
longest_0_run(_List) ->
    you_need_to_write_this("body of longest_0_run (using fold)").

% longest_run(Key, List) -> the length of the longest sequence elements with value Key in List.
%   example: longest_run(0, [0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1]) -> 4.
longest_run(_Key, _List) ->
    you_need_to_write_this("body of longest_run (using fold)").

% longest_ascending(List) -> the length of the longest sequence of
%   consecutive ascending value in list.  Examples:
%     longest_ascending([]) -> 0.
%     longest_ascending([banana]) -> 1.
%     longest_ascending([42, banana, sandwiches]) -> 3.
%     longest_ascending([0, 1, 2, 0, -5, 7, 42, banana, sandwiches, 2, 3, 4]) -> 5.
longest_ascending(_List) ->
    you_need_to_write_this("body of longest_ascending (using fold)").

% The message passing example
msg_proc(ParentPid) ->
    io:format("~w (worker process):  ParentPid = ~w~n", [self(), ParentPid]),
    Msg = receive
              {ParentPid, X} ->
                  X
          end,
    io:format("~w (worker process):  received ~s~n", [self(), Msg]).

msg_demo() ->
    MyPid = self(),
    io:format("~w (parent process):  starting~n", [MyPid]),
    WorkerPid = spawn(fun() -> msg_proc(MyPid) end),
    io:format("~w (parent process):  WorkerPid = ~w~n", [MyPid, WorkerPid]),
    WorkerPid ! {MyPid, "Hello World"},
    io:format("~w (parent process):  done~n", [MyPid]).

% code from the review questions

non_decreasing_too_many_ifs(X) ->
    if is_list(X) ->
           if X == [] ->
                  true;       % an empty list is non-decreasing
              tl(X) == [] ->
                  true; % a singleton list is non-decreasing
              true ->
                  (hd(X) =< hd(tl(X))) and non_decreasing_too_many_ifs(tl(X))
           end;
       not is_list(X) ->
           error("non_decreasing_too_many_ifs(X): X is not a list")
    end.

% non_decreasing(List) -> true iff the each element of list is greater thna
%   or equal to its predecessor.  non_decreasing should compute the same
%   result as non_decreasing_too_many_ifs, but it should be written using
%   pattern matching, and the code should be simpler and easier to read.
%     If you cut-and-paste any code from non_decreasing_too_many_ifs, make
%   sure that you change calls of non_decreasing_too_many_ifs to calls of
%   non_decreasing.
non_decreasing(_List) ->
    you_need_to_write_this("body of non_decreasing (hint: my solution uses four patterns)").

% neighbours(List) -> a list of tuples, where each tuple is an element of
%   the list and its successor.  neighbours([]) -> [].  If length(List) > 0,
%   then length(neigbours(List)) == length(List) - 1.  As an example,
%   neighbours([1,2,3,a,b,c]) -> [{1,2}, {2,3}, {3,a}, {a,b}, {b,c}].
neighbours(_List) ->
    you_need_to_write_this("body_of neigbours (hint: my solution uses three patterns)").

flatten_too_many_ifs(X) ->
    if is_list(X) ->
           if X == [] ->
                  X;
              true ->
                  FlatHead =
                      if is_list(hd(X)) ->
                             flatten_too_many_ifs(hd(X));
                         true ->
                             [hd(X)]
                      end,
                  FlatTail = flatten_too_many_ifs(tl(X)),
                  FlatHead ++ FlatTail
           end;
       not is_list(X) ->
           error("flatten_too_many_ifs(X): X is not a list")
    end.

% flatten(List): flatten a nested list.
%   flatten should compute the same result as flatten_too_many_ifs, but it
%   should be written using pattern matching, and the code should be simpler
%   and easier to read.  My solution use three patterns.
%     If you cut-and-paste any code from flatten_too_many_ifs, make sure
%   that you change calls of flatten_too_many_ifs to calls of flatten.
flatten(_List) ->
    you_need_to_write_this("body of flatten").

count([Hd | Tl]) ->
    count(Hd) + count(Tl);
count(Tuple) when is_tuple(Tuple) ->
    count(tuple_to_list(Tuple));
count(_) ->
    1.

% worst_flat(N) -> X.
%   X is a list that satisfies count(X) == N and has the property that
%   the run time for flatten(List) is quadratic in count(X).
%   My solution uses three patterns.  The code for two of the patterns
%   is simple.  The expression to return when the last pattern matches
%   is a single line (< 50 characters), but it takes more thinking.
worst_flat(N) when is_integer(N), N >= 1 ->
    you_need_to_write_this("body worst_flat").

calc_help(Acc, {'+', Val}) ->
    Acc + Val;
calc_help(Acc, {'-', Val}) ->
    Acc - Val;
calc_help(Acc, {'\ttilde', Val}) ->
    Val - Acc;
calc_help(Acc, {'*', Val}) ->
    Acc * Val;
calc_help(Acc, {'/', Val}) ->
    Acc / Val;
calc_help(Acc, {'\\', Val}) ->
    Val / Acc.

calc_l(Acc0, Ops) ->
    lists:foldl(fun(Op, Acc) -> calc_help(Acc, Op) end, Acc0, Ops).

calc_r(Acc0, Ops) ->
    lists:foldr(fun(Op, Acc) -> calc_help(Acc, Op) end, Acc0, Ops).

% divisible_drop: delete all elements from a list that are divisible by N
divisible_drop(_N, []) ->
    [];
divisible_drop(N, [A, Tail]) ->
    if A rem N == 0 ->
           divisible_drop(N, Tail);
       A rem N /= 0 ->
           [A | divisible_drop(N, Tail)]
    end.
