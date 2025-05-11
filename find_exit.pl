/*
Ok we need coordinates

so i guess it would be like coord(X,Y) something like that

then maybe a move function.
That will move the coordinates, if it's not a wall etc. etc.



*/


/* vc 
The coordinates must start at the start coordinate
So find a value that has [s] in it i guess

WAIT A MINUTE THIS IS JSUT DFS IN PROLOG

IF I CAN IMPLEMENT DFS INTO PROLOG AND STOP WHEN I FIND THE EXIT
AND BACKTRACK THE COORDINATES I CAN SOLVE THE MAZE
i need to figure out how to do DFS
*/


% these are the moves, but i don't understand how to actualyl move through the maze.
% Movement rules using coord(Row, Col) representation
move(left, coord(R,C), coord(R,C1)) :- C1 is C - 1.
move(right, coord(R,C), coord(R,C1)) :- C1 is C + 1.
move(up, coord(R,C), coord(R1,C)) :- R1 is R - 1.
move(down, coord(R,C), coord(R1,C)) :- R1 is R + 1.

% Retrieve cell value from a 2D map
cell(Map, coord(R,C), Value) :-
    nth0(R, Map, Row),
    nth0(C, Row, Value).


% Check if a coordinate is within bounds of the maze
in_bounds(Map, coord(R,C)) :-
    R >= 0,
    nth0(R, Map, Row),
    C >= 0,
    nth0(C, Row, _).

% Only allow movement into bounds and non-wall cells
move_safe_if_bound(Map, Pos, Action, NextPos) :-
    move(Action, Pos, NextPos),
    in_bounds(Map, NextPos),
    cell(Map, NextPos, V),
    V \= w.  % w = wall

%
% Base case: If on exit then you leave

% case if we step into an action. Then we can move safely
simulate(Map, Pos, [], exit) :-
    cell(Map, Pos, e).
simulate(Map, Pos, [], noexit) :-
    cell(Map, Pos, V),
    V \= e.
simulate(Map, Pos, [A|AS], Result) :-
    move_safe_if_bound(Map, Pos, A, NextPos),
    simulate(Map, NextPos, AS, Result).

% defenitely needed a helper function for seeing the path and backtracking
% replay_path(Map, (R,C), [], [(R,C)]).
% replay_path(Map, (R,C), [A|AS], [(R,C)|Path]) :-
%     move_safe_if_bound(Map, (R,C), A, Next),
%     replay_path(Map, Next, AS, Path).

% % printing path
% print_path(Map, PathCoords) :-
%     length(Map, Rows),
%     nth0(0, Map, FirstRow),
%     length(FirstRow, Cols),
%     forall(between(0, Rows-1, R),
%         (forall(between(0, Cols-1, C),
%             ( (member((R,C), PathCoords) -> write('*') ;
%                cell(Map, (R,C), V), write(V))),
%          nl))
%     ).
find_symbol(Map, Sym, Row, Col) :-
    nth0(Row, Map, RowList),
    nth0(Col, RowList, Sym).

find_exit(Map, Actions) :-
    find_symbol(Map, s, Row, Col),
    Pos = coord(Row, Col),
    ( nonvar(Actions) ->
        simulate(Map, Pos, Actions, exit)
    ;   % Search for solution if Actions is unbound
        search_actions(Map, Pos, [], Actions)
    ).


search_actions(Map, Pos, _, []) :-
    cell(Map, Pos, e).
search_actions(Map, Pos, Visited, [A|AS]) :-
    member(A, [up, down, left, right]),
    move_safe_if_bound(Map, Pos, A, NextPos),
    \+ member(NextPos, Visited),
    search_actions(Map, NextPos, [NextPos|Visited], AS).

% Helper function for seeing backtracking added again
replay_path(Map, Pos, [], [Pos]).
replay_path(Map, Pos, [A|AS], [Pos|Path]) :-
    move_safe_if_bound(Map, Pos, A, Next),
    replay_path(Map, Next, AS, Path).