%%%%%%% Prédicats outils %%%%%%%%%


listeNulle([0]):-!.
listeNulle([0|X]):-listeNulle(X).

different(X,X) :- !,fail.
different(_,_).

size([],0).
size([_|T],S):-%retourne la taille d'une liste
	size(T,M),
	S is M+1.

indexL([X|_],1,X).
indexL([_|L],I,A):- %ndexL(L,I,A) met dans A l'élément de la liste à l'index I
	I>0,
	size(L,Si),
	I=<Si+1, 
	I1 is I-1, 
	indexL(L,I1,A).

 reverse([],Z,Z).
 reverse([H|T],Z,Acc) :- reverse(T,Z,[H|Acc]).

ajouterGraine([X|L],[Y|L],1,N):- Y is X+N.
ajouterGraine([X|L],[X|L1],I,N):- %ajoute N graine dans la case du plateau PJ, a l'index I	size(L,Si),
	I>0,
	size(L,Si),
	I=<Si+1, 
	I1 is I-1, 
	ajouterGraine(L,L1,I1,N).

enleverGraine([X|L],[Y|L],1,N):- 
	N=<X,
	Y is X-N.
enleverGraine([X|L],[X|L1],I,N):- %enleve N graine dans la case du plateau PJ, a l'index I	size(L,Si),
	I>0,
	size(L,Si),
	I=<Si+1, 
	I1 is I-1, 
	enleverGraine(L,L1,I1,N).

%ViderCase([X|L],[X|L1],I,N) :-

