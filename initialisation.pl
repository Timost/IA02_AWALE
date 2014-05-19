modeJeu(_):-%menu pour choisir le mode de jeu
	repeat,
	write('Entrez le mode de jeu : '),nl,
	write('1. 2 joueurs'),nl,
	write('2. 1 joueur'), nl,
	read(Y),%mettre un point à la fin de l'input
	Y>0,
	Y<3,
	!,
	commencer(Y).

commencer(X):-%appel le prédicat de jeu correspondant au mode de Jeu choisi
	X = 1,
    nl,
	write('Vous etes en mode : 2 joueurs. Le joueur 1 commence.'),
	tourPlateau(humain1,humain2,[4,4,4,4,4,4],[4,4,4,4,4,4],0,0,0,0).

commencer(X):-
	X = 2,
    nl,
	write('Vous etes en mode : 1 joueur.'),
	tourPlateau(humain,ordinateur,[4,4,4,4,4,4],[4,4,4,4,4,4],0,0,0,0). 	