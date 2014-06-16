partie(_):-
	%netoyage base de faits dynamique
	retractall(joueurs(_,_)),
	retractall(plateauJoueurs(_,_)),
	retractall(grainesRamasseesJoueurs(_,_)),
	retractall(finJoueurs(_,_)),
	retractall(ordinateur(_,_)),

	choixModeJeu(X),
	choixJoueurDebut(X, JD, JF),%JD=Joueur qui joue, JF= joueur qui ne joue pas à ce tour.

	%initialisation bas de faits dynamique
	asserta(joueurs(JD,JF)),
	setOrdinateur(_),
	asserta(plateauJoueurs([4,4,4,4,4,4],[1,1,1,0,0,0])),%[0,0,0,0,0,0],[4,4,4,4,4,4]
	asserta(grainesRamasseesJoueurs(0,0)),
	asserta(finJoueurs(0,0)),
	jouer(X).

setOrdinateur(_):- %minitialise correctement le prédicat ordinateur de la base de faits dynamique.
	joueurs(JD,JF),
	(JF=humain2;JF=humain1),
	(JD=humain1;JD=humain2),
	retractall(ordinateur(_,_)),
	asserta(ordinateur("false","false")).

setOrdinateur(_):- %minitialise correctement le prédicat ordinateur de la base de faits dynamique.
	joueurs(JD,JF),
	(JF=humain2;JF=humain1),
	(JD=ordinateur1;JD=ordinateur2),
	retractall(ordinateur(_,_)),
	asserta(ordinateur("true","false")).
setOrdinateur(_):- %minitialise correctement le prédicat ordinateur de la base de faits dynamique.
	joueurs(JD,JF),
	(JD=humain2;JD=humain1),
	(JF=ordinateur1;JF=ordinateur2),
	retractall(ordinateur(_,_)),
	asserta(ordinateur("false","true")).

setOrdinateur(_):- %minitialise correctement le prédicat ordinateur de la base de faits dynamique.
	joueurs(JD,JF),
	(JF=ordinateur2;JF=ordinateur1),
	(JD=ordinateur2;JD=ordinateur1),
	retractall(ordinateur(_,_)),
	asserta(ordinateur("true","true")).

choixModeJeu(Z):-%menu pour choisir le mode de jeu
	repeat,
	write('Entrez le mode de jeu : '),nl,
	write('1. 1 joueur'),nl,
	write('2. 2 joueurs'), nl,
	read(Y),%mettre un point à la fin de l'input
	Y>0,
	Y<3,
	!,
	(
		(
			Y is 1,
			nl,
			write('Vous etes en mode 1 joueur.'),
			nl
		)
		;
		(
			Y is 2,
			nl,
			write('Vous etes en mode 2 joueurs.'),
			nl
		)
	),
	Z is Y.

choixJoueurDebut(X,JD,JF):-
	X=2,
	repeat,
	nl,
	write('Entrez le numéro du joueur qui commence : '),nl,
	write('1. joueur1'),nl,
	write('2. joueur2'), nl,
	read(Y),%
	Y>0,
	Y<3,
	!,
	(
		(
			Y is 1,
			JD = humain1,
			JF = humain2
		)
		;
		(
			Y is 2,
			JD = humain2,
			JF = humain1
		)
	).

choixJoueurDebut(X,JD,JF):-
	X=1,
	repeat,
	nl,
	write('Entrez le numéro du joueur qui commence : '),nl,
	write('1. joueur1'),nl,
	write('2. ordinateur1'), nl,
	read(Y),%
	Y>0,
	Y<3,
	!,
	(
		(
			Y is 1,
			JD = humain1,
			JF = ordinateur1
		)
		;
		(
			Y is 2,
			JD = ordinateur1,
			JF = humain1
		)
	).


jouer(X):-%appel le prédicat de jeu correspondant au mode de Jeu choisi
	repeat,
	%récupère les valeurs dans la base de faits dynamiques
	joueurs(JD,JF),
	plateauJoueurs(PJ1,PJ2),
	grainesRamasseesJoueurs(GRJ1,GRJ2),
	finJoueurs(FJ1,FJ2),

	%joue le tour du joueur JD

	/*write(JD),nl,
	write(JF),nl,
	write(PJ1),nl,
	write(PJ1),nl,
	write(PJ2),nl,
	write(GRJ1),nl,
	write(GRJ2),nl,
	write(FJ1),nl,
	write(FJ2),nl,*/
	


	tourPlateau(JD,JF,PJ1,PJ2,FJ1,FJ2,GRJ1,GRJ2),
	!.

