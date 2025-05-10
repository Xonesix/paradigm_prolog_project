# Prolog Project

# Date: 5/10/2025 12:25PM
- Notes
- I just finished reading like half the chapter on prolog and i think i got the gist of it,
- i think i want to start a test prolog project using some examples before i start coding up the main thing


## 12:38 PM
- I tried some basic prolog it seemd to work
- Now I guess I'll try to start the project

## 12:48 PM
- I added some other file for the project and I can see that the test file provides a way to create a made and example.pl displays the maze in a different way. 
- OK, now I need to create a function that traverses the mazE
- My first idea is to see what kind of rules I would need
- I think it would be like If left is blocked, go right
- If right blocked go up.
- Repeat until maze solved?
- Totally brute force but i don't have that much time and it should solve it for me


## 1:00PM
- After some research I realized that it's just DFS in prolog
- and we have like an adjacency matrix
- So so far my algorithm will be like this
- DFS -> find exit -> backtrack steps. -> answer in A

## 1:13PM 
- I think i figured out some moves but I don't know how to apply this into the maze...


## 1:50 PM
- I added a move code with directions left, right, up, and down. Just trying to understand how movement will work in a 2D grid.

- Using coord(R, C) to represent positions. Looks readable.

- I think my first bug is that there's no way to check if we're inside the bounds of the maze.

- Also not sure how I'm supposed to access the maze. Right now it's not even passed as a parameter, so not testable.

## 2:10
- Added a basic cell/3 function that takes the Map, a coordinate, and returns the value at that position.

Map will be represented as a list of lists (row major).

Tried writing cell(M, coord(R,C), V) using nth0. It throws an error when the index is out of bounds.

I need to write a bounds checker too. Otherwise Prolog just fails silently or crashes.

## 2:25 PM
- Added in_bounds/2. It checks that the row and column are within the list bounds.

- Tested with some dummy maps; it seems to work.

- Next: Need to combine move/3, in_bounds/2, and cell/3 to make a safe_move/4 that only lets you move into valid non-wall tiles.

- After that, maybe a simulate function that goes through a list of actions?
