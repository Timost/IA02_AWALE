%%%%%%% Prédicats de Vérifications %%%%%%%%%
plateauVide(_):-
	joueurs(J,NJ),
	plateauJoueurs(PJ1,PJ2),
	J=joueur1,
	listeNulle(PJ1).

plateauVide(_):-
	joueurs(J,NJ),
	plateauJoueurs(PJ1,PJ2),
	J=joueur2,
	listeNulle(PJ2).

listeNulle([0]).
listeNulle([0|Q]):-listeNulle(Q).

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