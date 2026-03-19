-module(bitonic).

-export([data/3, b/1, b/2, b/3, b/4, cas_demo/3, cas_demo/2, pr1/1, pr1/2]).
-export([merge_step/1, merge/1, sort/1, sort/2]).

% bool_to_int(B) -> Integer  %% the obvious
bool_to_int(true) ->
    1;
bool_to_int(false) ->
    0.

% data(N, NX, NY) -- create 0-1 sequences X and Y
%   X has N elements, the last NX are 1s, and the rest are 0s.
%   Y has N elements, the first NY are 1s, and the rest are 0s.
data(N, NX, NY) ->
    X = [bool_to_int(I > N - NX) || I <- lists:seq(1, N)],
    Y = [bool_to_int(I =< NY) || I <- lists:seq(1, N)],
    [X, Y].

% b(...) various ways to create random, bitonic lists
%   b(N) -> random bitonic list of length N, whose elements are from [0,1]
%   b(N,M) -> random bitonic list of length N, whose elements are from [1,M]
%   b(N1,N2,N3) -> a bitonic list of length N1+N2+N3 where the first N1
%                    elements are 0, the next N2 are 1, and the last N3 are 0.
%   b(N1,N2,N3,[A,B]) -> a bitonic list of length N1+N2+N3 where the first N1
%                    elements are A, the next N2 are B, and the last N3 are A.
b(N1, N2, N3, [A, B]) ->
    [A || _ <- lists:seq(1, N1)]
    ++ [B || _ <- lists:seq(1, N2)]
    ++ [A || _ <- lists:seq(1, N3)].

b(N1, N2, N3) ->
    b(N1, N2, N3, [0, 1]).

b(N, M) ->
    {X, Y} = lists:split(N div 2, misc:rlist(N, M)),
    lists:sort(X)
    ++ lists:reverse(
           lists:sort(Y)).

b(N) ->
    {X, Y} = lists:split(N div 2, [R - 1 || R <- misc:rlist(N, 2)]),
    lists:sort(X)
    ++ lists:reverse(
           lists:sort(Y)).

% map_cas(X,Y) -> {Min, Max}
%   Map the compare-and-swap operation over the elements of X and Y.
%   X and Y must be lists of the same length
%   Min and Max are lists of the same length of X and Y.
%   The Nth element of Min is min(lists:nth(N, X), lists:nth(N, Y)).
%   The Nth element of Max is max(lists:nth(N, X), lists:nth(N, Y)).
map_cas(X, Y) ->
    lists:unzip([{min(XX, YY), max(XX, YY)} || {XX, YY} <- lists:zip(X, Y)]).

% cas_demo: show what cas does when X and Y are lists sorted in opposite directions.
cas_demo(N, NX, NY) ->
    [X, Y] = data(N, NX, NY),  % create X and Y, sorted in opposite directions
    {Min, Max} = map_cas(X, Y),  % apply map_cas
    pr1([{"X", X}, {"Y", Y}, br, {"Min", Min}, {"Max", Max}]), % display the data
    {Min, Max}.

cas_demo(N, M) ->
    X = lists:sort(
            misc:rlist(N, M)),
    Y = lists:reverse(
            lists:sort(
                misc:rlist(N, M))),
    {Min, Max} = map_cas(X, Y),  % apply map_cas
    pr1([{"X", X}, {"Y", Y}, br, {"Min", Min}, {"Max", Max}]), % display the data
    {Min, Max}.

% pr1/1 and pr1/2: functions of doing the formatted printing for cas_demo
pr1(Stuff) ->
    NameWidth = lists:max([length(Name) || {Name, _Data} <- Stuff]),
    pr1(NameWidth, Stuff).

pr1(NameWidth, [br | Tl]) ->
    io:format("~n"),
    pr1(NameWidth, Tl);
pr1(NameWidth, [{Name, Data} | Tl]) ->
    io:format([$~ | integer_to_list(NameWidth) ++ "s:  ~w~n"], [Name, Data]),
    pr1(NameWidth, Tl);
pr1(_, []) ->
    ok.

% merge_step(X): perform one step of a bitonic merge
%   X should be list of bitonic lists, and each such list should have
%      even length.
%   For each element of E, we split E into two halves, and perform
%     compare-and-swap operations to obtain lists Min_E and Max_E.
%   We construct a new list where each element E is replaced by
%   two new elements Min_E and Max_E.
%
%   And we print lots of stuff along the way so you can see how the merge
%   progresses.
merge_step(X) ->
    io:format("~8s: ~w~n", ["Start", X]),
    {X1, Y1} = lists:unzip(Z1 = [lists:split(length(XX) div 2, XX) || XX <- X]),
    io:format("~8s: ~w~n", ["X1", X1]),
    io:format("~8s: ~w~n", ["Y1", Y1]),
    {Min, Max} = lists:unzip(Z2 = [map_cas(XX, YY) || {XX, YY} <- Z1]),
    io:format("~8s: ~w~n", ["Min", Min]),
    io:format("~8s: ~w~n", ["Max", Max]),
    F = fun LineUp([]) ->
                [];
            LineUp([{MinHd, MaxHd} | Tl]) ->
                [MinHd, MaxHd | LineUp(Tl)]
        end(Z2),
    io:format("~8s: ~w~n", ["Finish", F]),
    F.

% merge(X): bitonic merge
%   Parameter:
%     X: a bitonic list.  length(X) must be a power of 2 (because I'm keeping the code simple)
%   Result
%     Y: the elements of X, but sorted.
merge([A]) ->
    [A];
merge(X) when is_list(X) ->
    lists:append(merge_help([X]));
% To make demos easier, merge(N) creates a random, bitonic list of 0s and 1s and
%   performs bitonic merge to get a monotonic sequence.
merge(N) when is_integer(N) ->
    merge(b(N)).

% merge_help(X): where the merge really happens
%   X: a list of lists.
%        Each element of X be a list.
%        Each of these lists must be bitonic.
%        Each of these lists must be of the same length.
%        This length must be a power of 2.
%        If 1 =< I =< J =< length(X),
%          then every element of lists:nth(I, X) must be less than or
%          equal to every element of lists:nth(J, X).
%   Return value:
%     A list of singleton lists in ascending order.
%   The requirements for X may seem restrictive, but they're not actually that bad.
%   Let's say that BL is a bitonic list whose length is a power of two.  Then
%   [BL] is a valid value for X.  merge/1 calls us with such a list.  The other
%   calls to merge_help are our own recursive calls, and we guarantee that all
%   all of the requirements for X are satisfied on these recursive calls.
merge_help(X = [[_] | _]) ->
    X;  % done
merge_help(X) ->
    Y = merge_step(X),
    io:format("~s~n", [["-*-" || _ <- lists:seq(1, 24)]]),
    merge_help(Y).

% sort(X): bitonic sort.  The length of X must be a power of 2.
sort(X) when is_list(X) ->
    case is_pow2(length(X)) of
        true ->
            sort(2, X)
    end;
% sort(N): generate a list of 2^N random integers.  Sort it with bitonic sort.
sort(N) when is_integer(N), N >= 0 ->
    sort([X - 1 || X <- misc:rlist(pow2(N), 2)]).

% sort(M, X): the recursive core of bitonic sort.
%   M should be a power of 2.
%   length(X) should be a power of two.
%   X consists of a sequences of segments of length M/2 that are sorted
%   into ascending order.
%   We use bitonic:merge to sort segments of length M into ascending order.
%   Then, we call ourselves to complete the sort.
sort(M, X) when is_list(X), length(X) >= M ->
    Segs =
        fun S([]) ->
                [];  % partition X into segments of length M/2.
            S(List) ->
                {Up, Rest} = lists:split(M div 2, List), % Up is in ascending order
                {Down, Tl} = lists:split(M div 2, Rest), % Down is in ascending order
                [Up ++ lists:reverse(Down) | S(Tl)]  % Up ++ reverse(Down) is bitonic
        end(X),
    % Segs is a list, where each element of Segs is a bitonic list of length M.
    io:format("M=~w, Segs=~w~n", [M, Segs]),
    Y = merge_help(Segs),
    % Each element of Y is a list in ascending order.
    io:format("~s~n", [["/\\" || _ <- lists:seq(1, 36)]]),
    sort(2 * M, lists:append(Y));  % flatten Y and recurse
sort(_, Y) when is_list(Y) ->
    Y;
% sort(N, M) generate a random list
sort(N, M) when is_integer(N), N >= 0, is_integer(M), M > 0 ->
    sort(misc:rlist(pow2(N), M)).

% Yikes, Mark is using bitwise boolean operations to get a one-line functions.
% Shameful.
pow2(N) when is_integer(N), N >= 0 ->
    1 bsl N.

is_pow2(N) when is_integer(N), N > 0 ->
    N band (N - 1) == 0.
