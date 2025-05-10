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
move(left,  coord(R,C), coord(R, C1)) :- C1 is C-1.
move(right, coord(R,C), coord(R, C1)) :- C1 is C+1.
move(up,    coord(R,C), coord(R1, C)) :- R1 is R-1.
move(down,  coord(R,C), coord(R1, C)) :- R1 is R+1.
