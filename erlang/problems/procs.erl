-module(procs).

% functions presented in the lecture
-export([hello/1, add_proc/1, adder/0, acc_proc/1, accumulator/0, acc_stack/1]).
-export([acc_proc2/1, accumulator2/0, acc_stack2/1]).
-export([c3s_v1/1, c3s_v2/1, c3s_proc/1, c3s_send_data/2, c3s_get_data/1, c3s_help/2]).
-export([sum_hr/1, sum_tr/1, sum_tr/2, sum_q/1, rand_permute/1]).
% timing measurements
-export([xor_n/1, time_xor/0, xor_plus_n/1, time_xor_plus/0]).
-export([spawn_n/2, time_spawn/0]).
% another tail-recursion demo
-export([get_color/1, bad_color/1, color_list/1]).

% hello(N): create N processes that print 'hello world' and their process indices.
hello(N) when is_integer(N), N >= 0 ->
    [spawn(fun() -> io:format("hello world from process ~b~n", [I]) end)
     || I <- lists:seq(1, N)].

add_proc(ParentPid) when is_pid(ParentPid) ->
    receive
        A ->
            receive
                B ->
                    ParentPid ! A + B
            end
    end.

adder() ->
    MyPid = self(),
    spawn(fun() -> add_proc(MyPid) end).

acc_proc(Tally) when is_integer(Tally) ->
    receive
        N when is_integer(N) ->
            [acc_proc(Tally + N)];
        {Pid, total} ->
            Pid ! Tally,
            {acc_proc(Tally)};
        exit ->
            Tally
    end.

accumulator() ->
    spawn(fun() -> acc_proc(0) end).

acc_stack(N) ->
    AccPid = accumulator(),
    [AccPid ! I || I <- lists:seq(1, N)],
    AccPid ! {self(), total},
    receive
        Tally ->
            Tally
    end,
    {stack_size, Size} = process_info(AccPid, stack_size),
    AccPid ! exit,
    io:format("N=~b, stack size = ~b, Tally=~b~n", [N, Size, Tally]).

% now, we'll delete the useless '+3' and '/2' stuff
acc_proc2(Tally) when is_integer(Tally) ->
    receive
        N when is_integer(N) ->
            acc_proc2(Tally + N);
        {Pid, total} ->
            Pid ! Tally,
            acc_proc2(Tally);
        exit ->
            ok
    end.

% revised version of accumulator and acc_stack to use acc_proc2
accumulator2() ->
    spawn(fun() -> acc_proc2(0) end).

acc_stack2(N) ->
    AccPid = accumulator2(),
    [AccPid ! I || I <- lists:seq(1, N)],
    AccPid ! {self(), total},
    receive
        Tally ->
            Tally
    end,
    {stack_size, Size} = process_info(AccPid, stack_size),
    AccPid ! exit,
    io:format("N=~b, stack size = ~b, Tally=~b~n", [N, Size, Tally]).

% Functions from the review questions

% creating random lists
% rlist(N, M) -> a list of N random integers, where each element is
% uniformly distributed in [1, M]
rlist(0, _M) ->
    [];
rlist(N, M) ->
    [rand:uniform(M) | rlist(N - 1, M)].

c3s_proc(ParentPid) ->
    receive
        {ParentPid, element, 3} ->
            ParentPid ! {self(), got_one, 3},
            c3s_proc(ParentPid);
        {ParentPid, element, _} ->
            c3s_proc(ParentPid);
        {ParentPid, done} ->
            ParentPid ! {self(), done}
    after 5000 ->
        io:format("~w c3s_helper: receive timed out~n", [self()]),
        failed
    end.

c3s_send_data(ChildPid, []) ->
    ChildPid ! {self(), done};
c3s_send_data(ChildPid, [Hd | Tl]) ->
    ChildPid ! {self(), element, Hd},
    c3s_send_data(ChildPid, Tl).

c3s_get_data(ChildPid) ->
    receive
        {ChildPid, got_one, 3} ->
            1 + c3s_get_data(ChildPid);
        {ChildPid, done} ->
            0
    after 5000 ->
        io:format("~w c3s_get_data: receive timed out~n", [self()]),
        failed
    end.

c3s_help(N, ChildPid) ->
    R = rlist(N, 10),
    c3s_send_data(ChildPid, R),
    case c3s_get_data(ChildPid) of
        N3s when is_integer(N3s) ->
            N3s;
        failed ->
            failed
    end.

c3s_v1(N) ->
    ChildPid = spawn(fun() -> c3s_proc(self()) end),
    c3s_help(N, ChildPid).

c3s_v2(N) ->
    MyPid = self(),
    ChildPid = spawn(fun() -> c3s_proc(MyPid) end),
    c3s_help(N, ChildPid).

sum_hr([]) ->  % head recursive implementation
    {stack_size, Size} = process_info(self(), stack_size),
    io:format("sum_hr: stack size = ~b.~n", [Size]),
    0;
sum_hr([Hd | Tl]) ->
    sum_hr(Tl) + Hd.

sum_tr([], Acc) ->
    {stack_size, Size} = process_info(self(), stack_size),
    io:format("sum_hr: stack size = ~b.~n", [Size]),
    Acc;
sum_tr([Hd | Tl], Acc) ->
    sum_tr(Tl, Acc + Hd).

sum_tr(List) ->
    sum_tr(List, 0).

% is sum_q head or tail recursive?
sum_q([]) ->
    0;
sum_q([Hd | Tl]) ->
    Hd + sum_q(Tl).

% timing measurements

% time for a trivial tail-recursive function
%   I do an xor at each call so the compile can't
%   optimize the function out of existence.
xor_n(0, Acc) ->
    Acc;
xor_n(N, Acc) ->
    xor_n(N - 1, Acc bxor N).  % bxor is Erlang for bit-wise exclusive or

xor_n(N) ->
    xor_n(N, 0).

time_xor() ->
    M1 = 1000000, % one million
    M2 = 2 * M1,
    {mean, T1M} = lists:keyfind(mean, 1, time_it:t(fun() -> xor_n(M1) end)),
    {mean, T2M} = lists:keyfind(mean, 1, time_it:t(fun() -> xor_n(M2) end)),
    TimePerCall = (T2M - T1M) / (M2 - M1),
    io:format("xor_n: time per call = ~10.3e seconds~n", [TimePerCall]),
    TimePerCall.  % might as well return something informative.

% I'll add an addition at each call to see how long it takes to do one ALU
%   operation.
xor_plus_n(0, Acc) ->
    Acc;
xor_plus_n(N, Acc) ->
    xor_n(N - 1, Acc + 5 bxor N).  % bxor is Erlang for bit-wise exclusive or

xor_plus_n(N) ->
    xor_plus_n(N, 0).

time_xor_plus() ->
    M1 = 1000000, % one million
    M2 = 2 * M1,
    {mean, T1M} = lists:keyfind(mean, 1, time_it:t(fun() -> xor_plus_n(M1) end)),
    {mean, T2M} = lists:keyfind(mean, 1, time_it:t(fun() -> xor_plus_n(M2) end)),
    TimePerCall = (T2M - T1M) / (M2 - M1),
    io:format("xor_plus_n: time per call = ~10.3e seconds~n", [TimePerCall]),
    TimePerCall.  % might as well return something informative.

% spawn_n(N, F) -> Pids
%   spawn N processes that execute F and return their pids
spawn_n(0, _, Pids) ->
    Pids;
spawn_n(N, F, Pids) ->
    spawn_n(N - 1, F, [spawn(F) | Pids]).

spawn_n(N, F) ->
    spawn_n(N, F, []).

% measure the time to spawn a process by spawing a lot of processes that do nothing.
time_spawn() ->
    K1 = 1000, % one thousand
    K2 = 2 * K1,
    FunIsOK = fun() -> ok end,
    {mean, T1K} = lists:keyfind(mean, 1, time_it:t(fun() -> spawn_n(K1, FunIsOK) end)),
    {mean, T2K} = lists:keyfind(mean, 1, time_it:t(fun() -> spawn_n(K2, FunIsOK) end)),
    TimePerCall = (T2K - T1K) / (K2 - K1),
    io:format("spawn_n: time per call = ~10.3e seconds~n", [TimePerCall]),
    TimePerCall.  % might as well return something informative.

% rand_permute(N) -> RandomPermutationOf_1_to_N

% This code is called outside of the timing measurement, and I'm
%   not expecting LengthOfList to be really large.  So, I can get
%   away with an O(N^2) implementation (for now).
rand_permute([]) ->
    [];
rand_permute(List) when is_list(List) ->
    M = rand:uniform(length(List)),
    {Prefix, [Hd | Tl]} = lists:split(M - 1, List),
    [Hd | rand_permute(Prefix ++ Tl)];
rand_permute(N) when is_integer(N), N > 0 ->
    list_to_tuple(rand_permute(lists:seq(1, N))).

% an example of tail-call elimination when throwing exceptions

% get_color(C)
%   C should be an atom.  If we know the RGB encoding for that color, we
%     return it as a tuple {Red, Green, Blue} where each of Red, Green, and
%     Blue is a float in [0.0, 1.0].  If C is not an atom, or if we don't
%     know an RGB mapping for it, we throw an exception.
get_color(C) ->
    % I know that I could have just given a separate function clasue for
    % each color, but
    case C of
        red ->
            {1.0, 0.0, 0.0};
        green ->
            {0.0, 1.0, 0.0};
        blue ->
            {0.0, 0.0, 1.0};
        yellow ->
            {1.0, 1.0, 0.0};
        magenta ->
            {1.0, 0.0, 1.0};
        cyan ->
            {0.0, 1.0, 1.0};
        black ->
            {0.0, 0.0, 0.0};
        white ->
            {1.0, 1.0, 1.0};
        orange ->
            {1.0, 0.6, 0.0};
        pink ->
            {1.0, 0.75, 0.75};
        purple ->
            {0.7, 0.0, 0.7};
        _ ->
            bad_color(C)
    end.

bad_color(A) when is_atom(A) ->
    throw({"unknown color", A});
bad_color(X) ->
    throw({"color must be an atom", X}).

color_list(C) ->
    tuple_to_list(get_color(C)).
