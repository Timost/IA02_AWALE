%%%%%%% Prédicats de Vérifications %%%%%%%%%

caseValide(A):-
	A=<0,
	nl,
	write('case vide'),
	nl,
	fail.

caseValide(A):-
	A>0,
	nl,
	write('case remplie'),
	nl.

caseRemplie(PJ,X):-%retourne vrai si la case à l'indice X dans la liste PJ est remplie.
	indexL(PJ,X,A),
	!,%empeche le backtracking
	caseValide(A).%affiche un message si la case est invalide

verifierCase(PJ,X) :-
	%nonvar(X),%vérifie si X est lié
	X>0,%vérifie si l'index est valide
	X<7,
	caseRemplie(PJ,X).%vérifie si la case n'est pas vide.