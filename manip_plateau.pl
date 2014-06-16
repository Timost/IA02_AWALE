afficherPlateau(_):-
	plateauJoueurs(PJ1,PJ2),
	grainesRamasseesJoueurs(G1,G2),
	afficherPlateau(PJ1,PJ2,G1,G2).

afficherPlateau(PJ1,PJ2,G1,G2) :- %affiche la disposition du plateau
	nl,
	write('Joueur 2 : '),write(G2),write(' graines'),nl,
	format('           * %2d * %2d * %2d * %2d * %2d * %2d *',[6,5,4,3,2,1]),nl,
	write('            -----------------------------'),nl,
	 write('Joueur 2 : '),
	 reverse(PJ2,NewPJ2,[]),
	format('|%3d |%3d |%3d |%3d |%3d |%3d |',NewPJ2),nl,
	write('           |-----------------------------|'),nl,
	write('Joueur 1 : '),
	format('|%3d |%3d |%3d |%3d |%3d |%3d |',PJ1),nl,
	write('            -----------------------------'),nl,
	format('           * %2d * %2d * %2d * %2d * %2d * %2d *',[1,2,3,4,5,6]),nl,
	write('Joueur 1 : '),write(G1),write(' graines'),nl.

choisirCaseOrdi(PJ,1):-
	verifierCase(PJ,1),!.
choisirCaseOrdi(PJ,2):-
	verifierCase(PJ,2),!.
choisirCaseOrdi(PJ,3):-
	verifierCase(PJ,3),!.
choisirCaseOrdi(PJ,4):-
	verifierCase(PJ,4),!.
choisirCaseOrdi(PJ,5):-
	verifierCase(PJ,5),!.
choisirCaseOrdi(PJ,6):-
	verifierCase(PJ,6),!.

choisirCaseOrdi2(PJ,X):-
	repeat,
	randomize,
	random(Double),
	NewDouble is Double*6,
	Integer is floor(NewDouble)+1,
	verifierCase(PJ,Integer),!,
	X is Integer.

choisirCase(PJ,X) :-
	repeat,
	write('Entrez le numero de la case (entre 1 et 6): '),
	nl,
	read(X),%mettre un point à la fin de l'input
	verifierCase(PJ,X),%cf vefirications.pl
	!.

choisirCaseDebut(J,CaseDebut,NewCaseDebut,NewJ):- %retourne la première case du plateau dans lequel on met une graine
	J=humain1,
	CaseDebut=6,
	NewJ = humain2,
	NewCaseDebut is 1.

choisirCaseDebut(J,CaseDebut,NewCaseDebut,NewJ):- %retourne la première case du plateau dans lequel on met une graine
	J=humain2,
	CaseDebut=6,
	NewJ = humain1,
	NewCaseDebut is 1.

choisirCaseDebut(J,CaseDebut,NewCaseDebut,NewJ):- %retourne la première case du plateau dans lequel on met une graine
	CaseDebut<6,
	NewJ = J,
	NewCaseDebut is CaseDebut+1.




choisirCaseFin(J,CaseFin,NewCaseFin,NewJ):- %retourne la case et le joueur précédant la case fin.
	J=humain1,
	CaseFin=1,
	NewJ = humain2,
	NewCaseFin is 6.

choisirCaseFin(J,CaseFin,NewCaseFin,NewJ):- 
	J=humain2,
	CaseFin=1,
	NewJ = humain1,
	NewCaseFin is 6.

choisirCaseFin(J,CaseFin,NewCaseFin,NewJ):- 
	CaseFin>1,
	NewJ = J,
	NewCaseFin is CaseFin-1.


donnerGraines(J,PJ1,PJ2,CaseDebut,0,CaseOrigine, JoueurDebut,PJ1,PJ2,Y,Joueur):-
	choisirCaseFin(J,CaseDebut, Y, Joueur).
	%nl,write(Y),nl,write(Joueur).
	


donnerGraines(J,PJ1,PJ2,CaseDebut,StockGraines,CaseOrigine, JoueurDebut,NPJ1,NPJ2,CaseFin,JoueurFin):-%J indique sur quel plateau commencer la distribution
	J=humain1,
	(different(J,JoueurDebut) ; different(CaseDebut,CaseOrigine)),
	ajouterGraine(PJ1,NewPJ1,CaseDebut,1),
	choisirCaseDebut(J,CaseDebut,NewCaseDebut,NewJ),
	NewStockGraines is StockGraines-1,
	donnerGraines(NewJ,NewPJ1,PJ2,NewCaseDebut,NewStockGraines,CaseOrigine, JoueurDebut,NPJ1,NPJ2,CaseFin,JoueurFin),!.

donnerGraines(J,PJ1,PJ2,CaseDebut,StockGraines,CaseOrigine, JoueurDebut,NPJ1,NPJ2,CaseFin,JoueurFin):-%gère les cas ou on a plus de 12 graines, on saute la case d'origine
	J=JoueurDebut , 
	CaseDebut =CaseOrigine,
	choisirCaseDebut(J,CaseDebut,NewCaseDebut,NewJ),
	donnerGraines(NewJ,PJ1,PJ2,NewCaseDebut,StockGraines,CaseOrigine, JoueurDebut,NPJ1,NPJ2,CaseFin,JoueurFin),!.

donnerGraines(J,PJ1,PJ2,CaseDebut,StockGraines,CaseOrigine, JoueurDebut,NPJ1,NPJ2,CaseFin,JoueurFin):- %J indique sur quel plateau commencer la distribution
	J=humain2,
	(different(J,JoueurDebut) ; different(CaseDebut,CaseOrigine)),
	ajouterGraine(PJ2,NewPJ2,CaseDebut,1),
	choisirCaseDebut(J,CaseDebut,NewCaseDebut,NewJ),
	NewStockGraines is StockGraines-1,
	donnerGraines(NewJ,PJ1,NewPJ2,NewCaseDebut,NewStockGraines,CaseOrigine, JoueurDebut,NPJ1,NPJ2,CaseFin,JoueurFin),!.

prendreGraines(JoueurTour,JoueurTour,CaseDebut,PJ1,PJ2,PJ1,PJ2,NbGrainesRamassees,NbGrainesRamassees).%condition d'arrêt si on arrive sur le plateau du joueur qui joue

prendreGraines(JoueurTour,JoueurDebut,CaseDebut,PJ1,PJ2,NPJ1,NPJ2,NbGrainesRamassees,TotalGrainesRamassees):- %condition d'arrêt si on ne peut pas prendre les graines
	JoueurTour=humain1,%joueur à qui c'est le tour
	JoueurDebut=humain2,%plateau du joueur où les graines sont à PrendreGraines
	indexL(PJ2,CaseDebut,NbGrainesCases),%cherche le nombre de graines dans la case
	((NbGrainesCases=<1);(NbGrainesCases>=4)),
	NPJ1 = PJ1,
	NPJ2 = PJ2,
	TotalGrainesRamassees is NbGrainesRamassees.

prendreGraines(JoueurTour,JoueurDebut,CaseDebut,PJ1,PJ2,NPJ1,NPJ2,NbGrainesRamassees,TotalGrainesRamassees):- %condition d'arrêt si on ne peut pas prendre les graines
	JoueurTour=humain2,%joueur à qui c'est le tour
	JoueurDebut=humain1,%plateau du joueur où les graines sont à PrendreGraines	
	indexL(PJ1,CaseDebut,NbGrainesCases),%cherche le nombre de graines dans la case
	((NbGrainesCases=<1);(NbGrainesCases>=4)),
	NPJ1 = PJ1,
	NPJ2 = PJ2,
	TotalGrainesRamassees is NbGrainesRamassees.

prendreGraines(JoueurTour,JoueurDebut,CaseDebut,PJ1,PJ2,NPJ1,NPJ2,NbGrainesRamassees,TotalGrainesRamassees):- %ramasses les graines si besoin, on ne peut rammasser des graines que dans le camp adverse et si il y'a deux ou trois graines
	JoueurTour=humain1,%joueur à qui c'est le tour
	JoueurDebut=humain2,%plateau du joueur où les graines sont à PrendreGraines
	indexL(PJ2,CaseDebut,NbGrainesCases),%cherche le nombre de graines dans la case
	NbGrainesCases>1,
	NbGrainesCases<4,
	enleverGraine(PJ2,NewPJ2,CaseDebut,NbGrainesCases),
	NewNbGrainesRamassees is NbGrainesRamassees + NbGrainesCases,
	choisirCaseFin(JoueurDebut,CaseDebut, NewCaseDebut, NewJoueurDebut),%recule d'une case
	prendreGraines(JoueurTour,NewJoueurDebut,NewCaseDebut,PJ1,NewPJ2,NPJ1,NPJ2,NewNbGrainesRamassees,TotalGrainesRamassees). %appel récursif

prendreGraines(JoueurTour,JoueurDebut,CaseDebut,PJ1,PJ2,NPJ1,NPJ2,NbGrainesRamassees,TotalGrainesRamassees):- %ramasses les graines si besoin, on ne peut rammasser des graines que dans le camp adverse et si il y'a deux ou trois graines
	JoueurTour=humain2,%joueur à qui c'est le tour
	JoueurDebut=humain1,%plateau du joueur où les graines sont à PrendreGraines
	indexL(PJ1,CaseDebut,NbGrainesCases),%cherche le nombre de graines dans la case
	NbGrainesCases>1,
	NbGrainesCases<4,
	enleverGraine(PJ1,NewPJ1,CaseDebut,NbGrainesCases),
	NewNbGrainesRamassees is NbGrainesRamassees + NbGrainesCases,
	choisirCaseFin(JoueurDebut,CaseDebut, NewCaseDebut, NewJoueurDebut),%recule d'une case
	prendreGraines(JoueurTour,NewJoueurDebut,NewCaseDebut,NewPJ1,PJ2,NPJ1,NPJ2,NewNbGrainesRamassees,TotalGrainesRamassees). %appel récursif


repartirGraines(J,PJ1,PJ2,CaseDebut,NPJ1,NPJ2,GrainesRamasseesJ1,GrainesRamasseesJ2,NGRJ1,NGRJ2):- %reparti les graines a partir de la position CaseDebut du plateau du joueur 1
	J = humain1,
	\+listeNulle(PJ1),
	indexL(PJ1,CaseDebut,NbGraines),
	enleverGraine(PJ1,NewPJ1, CaseDebut, NbGraines),
	choisirCaseDebut(J,CaseDebut,NewCaseDebut,NewJ),
	donnerGraines(NewJ,NewPJ1, PJ2, NewCaseDebut,NbGraines, CaseDebut, J,New2PJ1,New2PJ2,CaseFin,JoueurFin),
	%afficherPlateau(New2PJ1,New2PJ2),
	prendreGraines(J,JoueurFin,CaseFin,New2PJ1,New2PJ2,New3PJ1,New3PJ2,0,NewGrainesRamasseesJ1),
	(
		(
			listeNulle(New3PJ2),
			nl,write('Vous ne pouvez pas affamer le joueur 2'),
			NPJ1 =New2PJ1,
			NPJ2 =New2PJ2,
			NGRJ1 is GrainesRamasseesJ1,
			NGRJ2 is GrainesRamasseesJ2
		)
		;
		(
			\+	listeNulle(New3PJ2),
			NGRJ1 is NewGrainesRamasseesJ1+GrainesRamasseesJ1,
			NGRJ2 is GrainesRamasseesJ2,
			nl,write('Le joueur 1 prend : '),write(NewGrainesRamasseesJ1),write(' Graines.'),nl,
			NPJ1 = New3PJ1,
			NPJ2 = New3PJ2
		)
	)
	.

repartirGraines(J,PJ1,PJ2,CaseDebut,NPJ1,NPJ2,GrainesRamasseesJ1,GrainesRamasseesJ2,NGRJ1,NGRJ2):- %reparti les graines a partir de la position CaseDebut du plateau du joueur 1
	J = humain2,
	\+listeNulle(PJ2),
	indexL(PJ2,CaseDebut,NbGraines),
	enleverGraine(PJ2,NewPJ2, CaseDebut, NbGraines),
	choisirCaseDebut(J,CaseDebut,NewCaseDebut,NewJ),
	donnerGraines(NewJ,PJ1, NewPJ2, NewCaseDebut,NbGraines, CaseDebut, J,New2PJ1,New2PJ2,CaseFin,JoueurFin),
	%afficherPlateau(New2PJ1,New2PJ2),
	prendreGraines(J,JoueurFin,CaseFin,New2PJ1,New2PJ2,New3PJ1,New3PJ2,0,NewGrainesRamasseesJ2),
	(
		(
			listeNulle(New3PJ1),
			nl,write('Vous ne pouvez pas affamer le joueur 1'),
			NPJ1 =New2PJ1,
			NPJ2 =New2PJ2,
			NGRJ1 is GrainesRamasseesJ1,
			NGRJ2 is GrainesRamasseesJ2
		)
		;
		(
			\+	listeNulle(New3PJ1),
			NGRJ1 is GrainesRamasseesJ1,
			NGRJ2 is NewGrainesRamasseesJ2+GrainesRamasseesJ2,
			nl,write('Le joueur 2 prend : '),write(NewGrainesRamasseesJ2),write(' Graines.'),nl,
			NPJ1 = New3PJ1,
			NPJ2 = New3PJ2
		)
	).
	




tourPlateau(J1,J2,PJ1,PJ2,PJ1Fin,1,GrainesRamasseesJ1,GrainesRamasseesJ2):- %si le joueur 1 gagne
	nl,
	write('Le joueur 1 gagne la partie avec le nombre graines suivant :'),write(GrainesRamasseesJ2),nl,afficherPlateau(_).
tourPlateau(J1,J2,PJ1,PJ2,1,PJ2Fin,GrainesRamasseesJ1,GrainesRamasseesJ2):- %si le Joueur 2 gagne
	nl,
	write('Le joueur 2 gagne la partie avec le nombre graines suivant :'),write(GrainesRamasseesJ1),nl,afficherPlateau(_).

tourPlateau(J1,J2,PJ1,PJ2,PJ1Fin,PJ2Fin,GrainesRamasseesJ1,GrainesRamasseesJ2):-%condition d'arrêt si il reste moins de 6 graines
	GrainesRamasseesJ1+GrainesRamasseesJ2>=48-6,
	GrainesRamasseesJ1>GrainesRamasseesJ2,
	nl,
	write('Il reste moins de 6 graines.'),nl,
	tourPlateau(J1,J2,PJ1,PJ2,1,PJ2Fin,GrainesRamasseesJ1,GrainesRamasseesJ2).

tourPlateau(J1,J2,PJ1,PJ2,PJ1Fin,PJ2Fin,GrainesRamasseesJ1,GrainesRamasseesJ2):-
	GrainesRamasseesJ1+GrainesRamasseesJ2>=48-6,
	GrainesRamasseesJ2>GrainesRamasseesJ1,
	nl,
	write('Il reste moins de 6 graines.'),nl,
	tourPlateau(J1,J2,PJ1,PJ2,PJ1Fin,1,GrainesRamasseesJ1,GrainesRamasseesJ2).
	
tourPlateau(J1,J2,PJ1,PJ2,PJ1Fin,PJ2Fin,GrainesRamasseesJ1,GrainesRamasseesJ2):-% le joueur 1 gagne la partie
	GrainesRamasseesJ1 >= 25,
	nl,
	write('Le joueur 1 a plus de 25 graines'),nl,
	tourPlateau(J1,J2,PJ1,PJ2,1,PJ2Fin,GrainesRamasseesJ1,GrainesRamasseesJ2).

tourPlateau(J1,J2,PJ1,PJ2,PJ1Fin,PJ2Fin,GrainesRamasseesJ1,GrainesRamasseesJ2):-% le joueur 2 gagne la partie
	GrainesRamasseesJ2 >= 25,
	nl,
	write('Le joueur 2 a plus de 25 graines'),nl,
	tourPlateau(J1,J2,PJ1,PJ2,PJ1Fin,1,GrainesRamasseesJ1,GrainesRamasseesJ2).

tourPlateau(J1,J2,PJ1,PJ2,PJ1Fin,PJ2Fin,GrainesRamasseesJ1,GrainesRamasseesJ2) :- %tour de jeu pour une partie humain vs humain, tour du joueur 1, J1 contient le joueur qui joue1
	PJ1Fin<1,
	PJ2Fin<1,
	J1 = humain1,
	afficherPlateau(_),
	nl, write('Au joueur 1 de jouer :'), nl,
	(
		(
			ordinateur("true",_),
			choisirCaseOrdi2(PJ1,X)
		)
		;
		(
			ordinateur("false",_),
			choisirCase(PJ1,X)
		)
	),nl,
	write('Le joueur 1 choisit la case : '),write(X),nl,
	repartirGraines(humain1,PJ1,PJ2,X,NPJ1,NPJ2,GrainesRamasseesJ1,GrainesRamasseesJ2,NGRJ1,NGRJ2),
	%afficherPlateau(NPJ1,NPJ2),
	%tourPlateau(humain2,humain1,NPJ1,NPJ2,0,0,NGRJ1,NGRJ2).

	retractall(joueurs(_,_)),
	retractall(plateauJoueurs(_,_)),
	retractall(grainesRamasseesJoueurs(_,_)),
	retractall(finJoueurs(_,_)),

	asserta(joueurs(humain2,humain1)),
	asserta(plateauJoueurs(NPJ1,NPJ2)),
	asserta(grainesRamasseesJoueurs(NGRJ1,NGRJ2)),
	asserta(finJoueurs(0,0)),

	!,fail.

tourPlateau(J1,J2,PJ1,PJ2,PJ1Fin,PJ2Fin,GrainesRamasseesJ1,GrainesRamasseesJ2) :- %tour de jeu pour une partie humain vs humain, tour du joueur 1, J1 contient le joueur qui joue1
	PJ1Fin<1,
	PJ2Fin<1,
	J1 = humain2,
	afficherPlateau(_),
	nl, write('Au joueur 2 de jouer :'), nl,
	(
		(
			ordinateur(_,"true"),
			choisirCaseOrdi2(PJ2,X)
		)
		;
		(
			ordinateur(_,"false"),
			choisirCase(PJ2,X)
		)
	),nl,
	write('Le joueur 2 choisit la case : '),write(X),nl,
	repartirGraines(humain2,PJ1,PJ2,X,NPJ1,NPJ2,GrainesRamasseesJ1,GrainesRamasseesJ2,NGRJ1,NGRJ2),
	%afficherPlateau(NPJ1,NPJ2),
	%tourPlateau(humain1,humain2,NPJ1,NPJ2,0,0,NGRJ1,NGRJ2).

	retractall(joueurs(_,_)),
	retractall(plateauJoueurs(_,_)),
	retractall(grainesRamasseesJoueurs(_,_)),
	retractall(finJoueurs(_,_)),

	asserta(joueurs(humain1,humain2)),
	asserta(plateauJoueurs(NPJ1,NPJ2)),
	asserta(grainesRamasseesJoueurs(NGRJ1,NGRJ2)),
	asserta(finJoueurs(0,0)),

	!,fail.
	
/*tourPlateau(J1,J2,PJ1,PJ2,Case,PJ1Fin,PJ2Fin,GrainesRamasseesJ1,GrainesRamasseesJ2) :- %tour de jeu pour une partie humain vs ordinateur
	PJ1Fin<1,
	PJ2Fin<1,
	J1 = ordinateur,
	J2= humain1.*/