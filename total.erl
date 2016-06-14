-module(total).

%Estados
%-------

%Next: el siguiente valor a proponer

%Nodes: todos los nodos de la red

%Cast: un conjunto de referencias a los mensajes que han sido enviados pero
%aún no se le ha asignado un número de secuencia final.

%Queue: los mensajes recibidos pero aún no entregados

%Jitter: el parámetro jitter que introduce algún delay en la red

server(Master,Next,Nodes,Cast,Queue,Jitter)->
receive
	{send, Msg} ->
		Ref = make_ref(),
		request(?, ?, ?, ?),
		Cast2 = cast(Ref, ?, ?), %{Ref, L, Sofar}
		server(Master, Next, Nodes, Cast2, Queue, Jitter);


	{request, From, Ref, Msg} ->
		From ! {proposal, ?, ?},
		Queue2 = insert(?, ?, ?, ?),
		Next2 = increment(?),
		server(Master, Next2, Nodes, Cast, Queue2, Jitter);


	{proposal, Ref, Proposal} ->
		case proposal(?, ?, ?) of
			{agreed, Seq, Cast2} ->
				agree(?, ?, ?),
				server(Master, Next, Nodes, Cast2, Queue, Jitter);
			Cast2 ->
				server(Master, Next, Nodes, Cast2, Queue, Jitter)
		end;

	{agreed, Ref, Seq} ->
		Updated = update(?, ?, ?),
		{Agreed, Queue2} = agreed(?, ?),
		deliver(?, ?),
		Next2 = increment(?, ?),
		server(Master, Next2, Nodes, Cast, Queue2, Jitter);

end.

