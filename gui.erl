-module(gui).
-export([start/2, init/2]).
-include_lib("wx/include/wx.hrl").

start(Name,Color) ->
	spawn(gui, init, [Name,Color]).

init(Name,Color) ->
	Width = 200,
	Height = 200,
	Server = wx:new(), %Server will be the parent for the Frame
	Frame = wxFrame:new(Server, -1, Name, [{size,{Width, Height}}]),
	wxFrame:show(Frame),
	loop(Frame,Color).

loop(Frame,Color)->
	receive
		begin_color ->
			wxFrame:setBackgroundColour(Frame,Color),
			wxFrame:refresh(Frame),
			loop(Frame,Color);

		{change,New_Color}->
			wxFrame:setBackgroundColour(Frame,New_Color),
			wxFrame:refresh(Frame),
			loop(Frame,New_Color);

		Error ->
			io:format("gui: strange message ~w~n", [Error]),
			loop(Frame,Color)
		end.
