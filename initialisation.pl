partie(_):-
	%netoyage base de faits dynamique
	retractall(joueurs(_,_)),
	retractall(plateauJoueurs(_,_)),
	retractall(grainesRamasseesJoueurs(_,_)),
	retractall(finJoueurs(_,_)),
	retractall(ordinateur(_,_)),

	choixModeJeu(X),
	choixJoueurDebut(X, JD, JF),%JD=Joueur qui joue, JF= joueur qui ne joue pas � ce tour.

	%initialisation bas de faits dynamique
	asserta(joueurs(JD,JF)),
	asserta(plateauJoueurs([4,4,4,4,4,4],[4,4,4,4,4,4])),%[0,0,0,0,0,0],[4,4,4,4,4,4]
	asserta(grainesRamasseesJoueurs(0,0)),
	asserta(finJoueurs(0,0)),
	jouer(X).

choixModeJeu(Z):-%menu pour choisir le mode de jeu
	repeat,
	write('Entrez le mode de jeu : '),nl,
	write('1. 1 joueur'),nl,
	write('2. 2 joueurs'), nl,
	write('3. ordi vs. ordi'), nl,
	read(Y),%mettre un point � la fin de l'input
	Y>0,
	Y<4,
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
		;
		(
			Y is 3,
			nl,
			write('Vous etes en mode ordinateur vs. ordinateur.'),
			nl
		)
	),
	Z is Y.

choixJoueurDebut(X,JD,JF):-
	X=3,
	repeat,
	nl,
	write('Entrez le num�ro du joueur qui commence : '),nl,
	write('1. ordi1'),nl,
	write('2. ordi2'), nl,
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
			JD = humain1,
			JF = humain2
		)
	),
	retractall(ordinateur(_,_)),
	asserta(ordinateur("true","true")).
choixJoueurDebut(X,JD,JF):-
	X=2,
	repeat,
	nl,
	write('Entrez le num�ro du joueur qui commence : '),nl,
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
	),
	retractall(ordinateur(_,_)),
	asserta(ordinateur("false","false")).

choixJoueurDebut(X,JD,JF):-
	X=1,
	repeat,
	nl,
	write('Entrez le num�ro du joueur qui commence : '),nl,
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
			JF = humain2,
			retractall(ordinateur(_,_)),
			asserta(ordinateur("false","true"))
		)
		;
		(
			Y is 2,
			JD = humain2,
			JF = humain1,
			retractall(ordinateur(_,_)),
			asserta(ordinateur("true","false"))
		)
	)
	.


jouer(_):-%appel le pr�dicat de jeu correspondant au mode de Jeu choisi
	repeat,
	%r�cup�re les valeurs dans la base de faits dynamiques
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

