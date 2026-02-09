-module(message_passing).

-export([add_proc/1, adder/0, acc_proc/1, accumulator/0, acc_stack/1]).

add_proc(PPid) ->
    receive
        A ->
            receive
                B ->
                    PPid ! A + B
            end
    end.

adder() ->
    MyPid = self(),
    spawn(fun() -> add_proc(MyPid) end).

acc_proc(Tally) when is_integer(Tally) ->
    receive
        N when is_integer(N) ->
            acc_proc(Tally + N);
        {Pid, total} ->
            Pid ! Tally,
            acc_proc(Tally);
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
    io:format("N=~b, stack size = ~b, Tally = ~b~n", [N, Size, Tally]).
