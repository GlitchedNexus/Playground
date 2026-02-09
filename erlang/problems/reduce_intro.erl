-module(reduce_intro).

-export([count3s/2, count3s_test/0, count3s_test/2]).

count3s(WorkerTree, Key) ->
    wtree:reduce(WorkerTree,
                 fun(ProcState) -> count3s_leaf(ProcState, Key) end,   % Leaf function
                 fun(Left, Right) -> count3s_combine(Left, Right) end).  % Combine function}

count3s_leaf(ProcState, Key) ->
    MyList = wtree:get(ProcState, Key), % fetch my part of the list from ProcState
    length([E || E <- MyList, E =:= 3]).  % select the 3s and return the length of that list

count3s_combine(Left, Right) ->
    Left + Right.

count3s_test(N_workers, N_values)
    when is_integer(N_workers), N_workers >= 0, is_integer(N_values), N_values >= 0 ->
    WorkerTree = wtree:create(N_workers),
    % create a random list of N_values integers chosen in [1, 10], distribute
    %   it across the workers of WorkerTree and associate it with the key 'data'.
    wtree:rlist(WorkerTree, N_values, 10, data),
    Par3s = count3s(WorkerTree, data),

    % count the 3s sequentially and check the result
    Seq3s =
        length([E
                || E
                       <- lists:append(
                              wtree:retrieve(WorkerTree, data)),
                   E == 3]),

    case Par3s =:= Seq3s of
        true ->
            io:format("passed: N_values = ~b, Par3s = ~b~n", [N_values, Par3s]),
            ok;
        false ->
            io:format("failed: N_values = ~b, Par3s = ~b, Seq3s = ~b~n", [N_values, Par3s, Seq3s]),
            fail
    end.

% try a simple test.  Throw an exception if it fails
count3s_test() ->
    ok = count3s_test(10, 1234).
