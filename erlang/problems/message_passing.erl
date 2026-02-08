-module(message_passing).

-export([add_proc/1, adder/0, acc_proc/1, accumulator/0]).

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
            [acc_proc(Tally + N)];
        {Pid, total} ->
            Pid ! Tally,
            {acc_proc(Tally)};
        exit ->
            Tally
    end.

accumulator() ->
    spawn(fun() -> acc_proc(0) end).
