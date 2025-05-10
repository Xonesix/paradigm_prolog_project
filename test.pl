% Parents
female(sally).
male(jake).
% daughter
female(alex).

% rule
father(jake, alex).
mother(sally, alex).

/*
Test 

Headed Horn Clause
consequence :- antecedent_expression

example
ancestor(mary, shelley) :- mother(mary, shelly).

, and
; or
not not
if :-

Basically alex's parents are jake and sally
*/
parent(X, Y) :- father(X, Y); mother(X,Y).

% now i will put this into swipl and see if 
% parent(jake, alex) and parent(sally, alex) hold


% UPDATE : It works..