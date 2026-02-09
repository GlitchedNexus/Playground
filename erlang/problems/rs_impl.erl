-module(rs_impl).  % implement reduce and scan

-export([create/2, test_create/1]).
-export([reduce/3, test_reduce/1]).
% export our "internal" functions for debugging and demos.
% delete (or comment out) this export for "release" version.
-export([create/4, reduce/4]).

create(N, Task) when is_integer(N), 0 < N, is_function(Task, 1) ->
    spawn(fun() -> create(N, none, [], Task) end).

create(1, Parent, ChildPids, Task) ->
    Task({Parent, ChildPids});
create(N, Parent, ChildPids, Task) when is_integer(N), 1 < N ->
    NLeft = N div 2,
    NRight = N - NLeft,
    MyPid = self(),
    RightPid = spawn(fun() -> create(NRight, MyPid, [], Task) end),
    create(NLeft, Parent, [RightPid | ChildPids], Task).

test_create(N) when is_integer(N), 0 < N ->
    create(N, fun(_) -> io:format("~w: hello world~n", [self()]) end).

% Lin & Snyder style reduce:
%   called by the leaves.
%   returns the GrandTotal to each leaf.
reduce({ParentPid, ChildPids}, CombineFun, Value) ->
    reduce(ParentPid, ChildPids, CombineFun, Value).

reduce(none, [], _, GrandTotal) ->
    GrandTotal;
reduce(ParentPid, [], _, MyTotal) ->
    ParentPid ! {self(), reduce_up, MyTotal},
    receive
        {ParentPid, reduce_down, GrandTotal} ->
            GrandTotal
    end;
% maybe we should have an after clause to check for time-outs
reduce(Parent, [ChildHd | ChildTl], CombineFun, LeftTotal) ->
    receive
        {ChildHd, reduce_up, RightTotal} ->
            GrandTotal = reduce(Parent, ChildTl, CombineFun, CombineFun(LeftTotal, RightTotal)),
            ChildHd ! {self(), reduce_down, GrandTotal},
            GrandTotal
    end.

% find out how many processes we have
test_reduce(N) when is_integer(N), 0 < N ->
    create(N,
           fun(ProcInfo) ->
              NProcs = reduce(ProcInfo, fun(Left, Right) -> Left + Right end, 1),
              io:format("~w: I am one of ~w happy processes!~n", [self(), NProcs])
           end).
