-module(test).
-export([start/0]).


start()->
 manager:start(),
 W1 = worker:init("gri",1000,0),
 W2 = worker:init("vero",2000,0),
 W3 = worker:init("juan",3000,0),
 W4 = worker:init("pepe",4000,0).
