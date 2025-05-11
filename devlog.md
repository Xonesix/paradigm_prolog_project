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

## 2:10PM
- Added a basic cell/3 function that takes the Map, a coordinate, and returns the value at that position.

Map will be represented as a list of lists (row major).

Tried writing cell(M, coord(R,C), V) using nth0. It throws an error when the index is out of bounds.

I need to write a bounds checker too. Otherwise Prolog just fails silently or crashes.

## 2:25 PM
- Added in_bounds/2. It checks that the row and column are within the list bounds.

- Tested with some dummy maps; it seems to work.

- Next: Need to combine move/3, in_bounds/2, and cell/3 to make a move_safe_if_bound/4 that only lets you move into valid non-wall tiles.

- After that, maybe a simulate function that goes through a list of actions?

## 2:50PM
- Ok so I’ve got safe movement and basic map bounds checks.
- Now I want to simulate moving through a list of actions. Like simulate([up, right, right]) and see if I end up at the exit.
- I’ll assume for now that I know the start point — just want to see if my movement logic works.


## 3:15PM
- Cool, simulate works!
- Now I want a top-level entry point, like find_exit(Map, Actions)
- If I give it a list of Actions, it should tell me if those lead to the exit.
- But if I leave Actions unbound, I want it to search for a valid sequence using DFS.
- Not gonna worry about infinite loops yet, just getting something that works.
- Took me 10 minutes because I forgot find_symbol returns Row/Col, not a coord/2 structure. lol
- Also forgot i don't need to check for the start in `simulate` so i had to change the structure of it a bit


## 5:30PM
- Wrote the DFS-style search.
- It recursively tries all directions, skips visited nodes, and builds up a list of actions.
- Crude but surprisingly works.
Bugs hit:  
- First I accidentally added the wrong position to the visited list — it was Pos not NextPos.
- Then I realized that if you allow infinite recursion, it never terminates on bad mazes.


# May 11th 2025
## 11:00AM
- Ok so the DFS works…
- But now I want to make it not get stuck on impossible mazes.
- Infinite loops suck, and right now, search_actions just goes forever if there’s no exit.
- Plan: Add a depth limit to the DFS to cap recursion.
- Forgot to decrement depth → infinite loop still happened :( 
- Used same predicate name for both arities, which broke things


## 11:55AM
- Ok now that it doesn’t loop forever, I want better visibility.
Like, I want to see the solution path when it works.
Maybe a pretty printer or just showing the coordinates visited.
- Solution:
    - Track coordinates instead of just the actions.
    - Or… simpler: print the path once found.
- I'm gonna try to add `write(Actions)` temporarily after `find_exit/2` finds a path.
- Refactor safe_move into move_safe_in_bound for more clarity


## 12:20PM
- printing looks ok but debugging this is a pain
- try to make path look better
