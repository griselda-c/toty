-module(worker).
-export([init/3,cambiarEstado/3]).

init(Name,Sleep,Jitter)->
  Color = {0,0,0},
  Gui = spawn(gui, init, [Name,Color]),
  random:seed(37, 37, 37),
  Gui ! begin_color,
  manager ! {register,self()}, 
  Gui ! stop,
  receive
  	{peer,Lista}->server(Lista,Sleep,Jitter,Color,Gui)
  end.
  



server(Lista,Sleep,Jitter,Color,Gui)->
	receive
		{cambiarEstado,N}-> New_Color = cambiarEstado(Color,N,Gui),
							server(Lista,Sleep,Jitter,New_Color,Gui)

		after Sleep ->
			New_msj = random:uniform(20),
			multicast(Lista,New_msj),
			server(Lista,Sleep,Jitter,Color,Gui)
	end.

cambiarEstado(Color,N,Gui)->
	{A,B,C} = Color,
	New_Color = {B,C,(A+N)rem 256},
	Gui ! {change,New_Color},
	New_Color.


multicast(Lista,N)->
    lists:foreach(fun(Worker) ->
        Worker ! {cambiarEstado,N}
    end,
    Lista).

