-module(manager).
-export([start/0,loop/1]).

loop(Lista)->
	receive
		{register, PID} -> NewList = Lista ++ [PID],
						   %falta que el pid reciba la lista de registrados
						   updateList(NewList),
						   loop(NewList)
    end.


start()->
	register(manager, spawn(manager, loop, [[]])).


updateList(Lista)->
    lists:foreach(fun(PID) ->
        PID ! {peer, Lista}
    end,
    Lista).


