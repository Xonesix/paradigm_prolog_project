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
move(left,  coord(R,C), coord(R, C1)) :- C1 is C - 1.
move(right, coord(R,C), coord(R, C1)) :- C1 is C + 1.
move(up,    coord(R,C), coord(R1, C)) :- R1 is R - 1.
move(down,  coord(R,C), coord(R1, C)) :- R1 is R + 1.

% Retrieve cell value from a 2D map
cell(Map, coord(R, C), Value) :-
    nth0(R, Map, Row),
    nth0(C, Row, Value).

% Check if a coordinate is within bounds of the maze
in_bounds(Map, coord(R, C)) :-
    R >= 0,
    nth0(R, Map, Row),   % will fail if R is out of bounds
    C >= 0,
    nth0(C, Row, _).     % will fail if C is out of bounds

% Only allow movement into bounds and non-wall cells
safe_move(Map, Pos, Action, NextPos) :-
    move(Action, Pos, NextPos),
    in_bounds(Map, NextPos),
    cell(Map, NextPos, V),
    V \= w.  % w = wall