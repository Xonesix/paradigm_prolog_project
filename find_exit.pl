/*
Ok we need coordinates

so i guess it would be like coord(X,Y) something like that

then maybe a move function.
That will move the coordinates, if it's not a wall etc. etc.



*/


/*
The coordinates must start at the start coordinate
So find a value that has [s] in it i guess

WAIT A MINUTE THIS IS JSUT DFS IN PROLOG

IF I CAN IMPLEMENT DFS INTO PROLOG AND STOP WHEN I FIND THE EXIT
AND BACKTRACK THE COORDINATES I CAN SOLVE THE MAZE
i need to figure out how to do DFS
*/


% these are the moves, but i don't understand how to actualyl move through the maze.
% Movement rules using coord(Row, Col) representation
move(left,coord(R,C),coord(R, C1)) :- C1 is C - 1.
move(right,coord(R,C),coord(R, C1)) :- C1 is C + 1.
move(up, coord(R,C),coord(R1, C)) :- R1 is R - 1.
move(down, coord(R,C),coord(R1, C)) :- R1 is R + 1.

% Retrieve cell value from a 2D map
cell(Map, coord(R, C), Value) :-
    nth0(R, Map, Row),
    nth0(C, Row, Value).
% THIS IS SO PAINFUL WHYYYYYYYYYYYYY
% i should've done this earlier lmao
% it's ok prolog is kind of a cool language once you get the hang of it
% but there are so many weird conventions. Like I guess we just know that Map exists...?
% 
% Check if a coordinate is within bounds of the maze
in_bounds(Map, coord(R, C)) :-
    R >= 0,
    nth0(R, Map, Row),   % will fail if R is out of bounds
    C >= 0,
    nth0(C, Row, _).     % will fail if C is out of bounds

% Only allow movement into bounds and non-wall cells
move_safe_if_bound(Map, Pos, Action, NextPos) :-
    move(Action, Pos, NextPos),
    in_bounds(Map, NextPos),
    cell(Map, NextPos, V),
    V \= w.  % w = wall

%
% Base case: If on exit then you leave
simulate(Map, Pos, [], exit) :-
    cell(Map, Pos, e).
simulate(Map, Pos, [], noexit) :-
    cell(Map, Pos, V),
    V \= e.

% Step case
simulate(Map, Pos, [A|AS], Result) :-
    move_safe_if_bound(Map, Pos, A, NextPos),
    simulate(Map, NextPos, AS, Result).

% defenitely needed a helper function for seeing the path and backtracking
replay_path(Map, (R,C), [], [(R,C)]).
replay_path(Map, (R,C), [A|AS], [(R,C)|Path]) :-
    move_safe_if_bound(Map, (R,C), A, Next),
    replay_path(Map, Next, AS, Path).

% printing path
print_path(Map, PathCoords) :-
    length(Map, Rows),
    nth0(0, Map, FirstRow),
    length(FirstRow, Cols),
    forall(between(0, Rows-1, R),
        (forall(between(0, Cols-1, C),
            ( (member((R,C), PathCoords) -> write('*') ;
               cell(Map, (R,C), V), write(V))),
         nl))
    ).


find_exit(Map, Actions) :-
    find_symbol(Map, s, Row, Col),
    ( nonvar(Actions) ->
        simulate(Map, (Row,Col), Actions, exit)
    ;   MaxDepth = 100, % random depth for checking
        search_actions(Map, (Row,Col), [], Actions, MaxDepth),
        write('Found path: '), writeln(Actions)
    ).


% Overloaded search_actions with a depth limit
search_actions(Map, Pos, Visited, [], 0) :- 
    cell(Map, Pos, e).

search_actions(Map, Pos, Visited, [A|AS], Depth) :-
    Depth > 0,
    member(A, [up, down, left, right]),
    move_safe_if_bound(Map, Pos, A, NextPos),
    \+ member(NextPos, Visited),
    D1 is Depth - 1,
    search_actions(Map, NextPos, [NextPos|Visited], AS, D1).