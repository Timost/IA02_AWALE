%%%%%%% Prédicats de Vérifications %%%%%%%%%



affame(_) :- % il doit retourner vrai si le plateau du joueur qui ne joue pas est vide
	plateauNonJoueur(PNJ),
	listeNulle(PNJ).

plateauNonJoueur(P) :-% ce prédicat doit renvoyer le plateau du joueur qui ne joue pas
	joueurs(JD,_),
	plateauJoueurs(_,PJF),
	JD = humain1,
	P = PJF.

plateauNonJoueur(P) :-% ce prédicat doit renvoyer le plateau du joueur qui ne joue pas
	joueurs(JD,_),
	plateauJoueurs(PJD,_),
	JD = humain2,
	P = PJD.

plateauDuJoueur(P) :- % ce prédicat doit retourner le plateau du joueur qui joue
	%initialisation bas de faits dynamique
	joueurs(JD,_),
	plateauJoueurs(PJD,_),
	JD = humain1,
	P = PJD.

plateauDuJoueur(P) :- % ce prédicat doit retourner le plateau du joueur qui joue
	%initialisation bas de faits dynamique
	joueurs(JD,_),
	plateauJoueurs(_,PJF),
	JD = humain2,
	P = PJF.
nourritAdversaire(Case):- % ce prédicat retourne vrai si la case permet de nourrir l'nourrir l'nourritAdversaire
	plateauDuJoueur(PJ),
	indexL(PJ,Case,X),
	!,Case+X>6.

peutNourrirAdversaire(_):- % retourne vrai s'il existe une case qui nourrit l'adversaire
	nourritAdversaire(1);
	nourritAdversaire(2);
	nourritAdversaire(3);
	nourritAdversaire(4);
	nourritAdversaire(5);
	nourritAdversaire(6).


prendreToutPlateau(J):- % ramasse l'ensemble des graines du plateau et les donnes au joueur J
	J=humain1,
	plateauDuJoueur(PJ),
	grainesRamasseesJoueurs(GJ1,GJ2),
	list_adder(PJ,Graines),
	NewGJ1 is GJ1 + Graines,

	retractall(plateauJoueurs(_,_)),
	retractall(grainesRamasseesJoueurs(_,_)),

	asserta(plateauJoueurs([0,0,0,0,0,0],[0,0,0,0,0,0])),%[0,0,0,0,0,0],[4,4,4,4,4,4]
	asserta(grainesRamasseesJoueurs(NewGJ1,GJ2)),
	joueurs(J1,J2),
	plateauJoueurs(PJ1,PJ2),
	finJoueurs(PJ1Fin,PJ2Fin),
	grainesRamasseesJoueurs(GrainesRamasseesJ1,GrainesRamasseesJ2),
	tourPlateau(J1,J2,PJ1,PJ2,PJ1Fin,PJ2Fin,GrainesRamasseesJ1,GrainesRamasseesJ2).

prendreToutPlateau(J):- % ramasse l'ensemble des graines du plateau et les donnes au joueur J
	J=humain2,
	plateauDuJoueur(PJ),
	grainesRamasseesJoueurs(GJ1,GJ2),
	list_adder(PJ,Graines),
	NewGJ2 is GJ2 + Graines,

	retractall(plateauJoueurs(_,_)),
	retractall(grainesRamasseesJoueurs(_,_)),

	asserta(plateauJoueurs([0,0,0,0,0,0],[0,0,0,0,0,0])),%[0,0,0,0,0,0],[4,4,4,4,4,4]
	asserta(grainesRamasseesJoueurs(GJ1,NewGJ2)),

	joueurs(J1,J2),
	plateauJoueurs(PJ1,PJ2),
	finJoueurs(PJ1Fin,PJ2Fin),
	grainesRamasseesJoueurs(GrainesRamasseesJ1,GrainesRamasseesJ2),
	tourPlateau(J1,J2,PJ1,PJ2,PJ1Fin,PJ2Fin,GrainesRamasseesJ1,GrainesRamasseesJ2).

plateauVide(_):-
	joueurs(J,_),
	plateauJoueurs(PJ1,_),
	J=joueur1,
	listeNulle(PJ1).

plateauVide(_):-
	joueurs(J,_),
	plateauJoueurs(_,PJ2),
	J=joueur2,
	listeNulle(PJ2).


caseValide(A):-
	A=<0,
	%nl,
	%write('case vide'),
	%nl,
	fail.

caseValide(A):-
	A>0.
	%nl,
	%write('case remplie'),
	%nl.

caseRemplie(PJ,X):-%retourne vrai si la case à l'indice X dans la liste PJ est remplie.
	indexL(PJ,X,A),
	!,%empeche le backtracking
	caseValide(A).%affiche un message si la case est invalide

verifierCase(PJ,X) :-
	%nonvar(X),%vérifie si X est lié
	X>0,%vérifie si l'index est valide
	X<7,
	caseRemplie(PJ,X),%vérifie si la case n'est pas vide.
	affame(_),!,
	peutNourrirAdversaire(_),
	nourritAdversaire(X).

verifierCase(PJ,X) :-
	%nonvar(X),%vérifie si X est lié
	X>0,%vérifie si l'index est valide
	X<7,
	caseRemplie(PJ,X),%vérifie si la case n'est pas vide.
	affame(_),!,
	\+peutNourrirAdversaire(_),
	joueur(J1,_),
	prendreToutPlateau(J1).

verifierCase(PJ,X) :-
	%nonvar(X),%vérifie si X est lié
	X>0,%vérifie si l'index est valide
	X<7,
	caseRemplie(PJ,X),%vérifie si la case n'est pas vide.
	\+affame(_).
	/*
	si affame(adversaire)
		alors si peutNourrirAdversaire
			alors nourrirAdversaire(case)
		sinon le joueur capture les graines restante
	*/