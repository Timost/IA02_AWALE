afficherPlateau(PJ1,PJ2) :- %affiche la disposition du plateau
	nl,
	write('Joueur 2 : '),
	reverse(PJ2,NewPJ2,[]),
	write(NewPJ2),
	nl,
	write('Joueur 1 : '),
	write(PJ1),
	nl.

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
	choisirCaseFin(J,CaseDebut, Y, Joueur),
	nl,write(Y),nl,write(Joueur).


donnerGraines(J,PJ1,PJ2,CaseDebut,StockGraines,CaseOrigine, JoueurDebut,NPJ1,NPJ2,CaseFin,JoueurFin):-%J indique sur quel plateau commencer la distribution
	J=humain1,
	(different(J,JoueurDebut) ; different(CaseDebut,CaseOrigine)),
	ajouterGraine(PJ1,NewPJ1,CaseDebut,1),
	choisirCaseDebut(J,CaseDebut,NewCaseDebut,NewJ),
	NewStockGraines is StockGraines-1,
	donnerGraines(NewJ,NewPJ1,PJ2,NewCaseDebut,NewStockGraines,CaseOrigine, JoueurDebut,NPJ1,NPJ2,CaseFin,JoueurFin).

donnerGraines(J,PJ1,PJ2,CaseDebut,StockGraines,CaseOrigine, JoueurDebut,NPJ1,NPJ2,CaseFin,JoueurFin):-%gère les cas ou on a plus de 12 graines, on saute la case d'origine
	J=JoueurDebut , 
	CaseDebut =CaseOrigine,
	choisirCaseDebut(J,CaseDebut,NewCaseDebut,NewJ),
	donnerGraines(NewJ,PJ1,PJ2,NewCaseDebut,StockGraines,CaseOrigine, JoueurDebut,NPJ1,NPJ2,CaseFin,JoueurFin).

donnerGraines(J,PJ1,PJ2,CaseDebut,StockGraines,CaseOrigine, JoueurDebut,NPJ1,NPJ2,CaseFin,JoueurFin):- %J indique sur quel plateau commencer la distribution
	J=humain2,
	(different(J,JoueurDebut) ; different(CaseDebut,CaseOrigine)),
	ajouterGraine(PJ2,NewPJ2,CaseDebut,1),
	choisirCaseDebut(J,CaseDebut,NewCaseDebut,NewJ),
	NewStockGraines is StockGraines-1,
	donnerGraines(NewJ,PJ1,NewPJ2,NewCaseDebut,NewStockGraines,CaseOrigine, JoueurDebut,NPJ1,NPJ2,CaseFin,JoueurFin).

prendreGraines(JoueurTour,JoueurTour,CaseDebut,PJ1,PJ2,PJ1,PJ2,NbGrainesRamassees,NbGrainesRamassees).%condition d'arrêt si on arrive sur le plateau du joueur qui joue

prendreGraines(JoueurTour,JoueurDebut,CaseDebut,PJ1,PJ2,NPJ1,NPJ2,NbGrainesRamassees,TotalGrainesRamassees):- %condition d'arrêt si on ne peut pas prendre les graines
	different(JoueurTour,JoueurDebut),
	indexL(PJ2,CaseDebut,NbGrainesCases),%cherche le nombre de graines dans la case
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

prendreGraines(JoueurTour,JoueurDebut,CaseDebut,PJ1,PJ2,NPJ1,NPJ2,NbGrainesRamassees):- %ramasses les graines si besoin, on ne peut rammasser des graines que dans le camp adverse et si il y'a deux ou trois graines
	JoueurTour=humain2,%joueur à qui c'est le tour
	JoueurDebut=humain1,%plateau du joueur où les graines sont à PrendreGraines
	indexL(PJ1,CaseDebut,NbGrainesCases),%cherche le nombre de graines dans la case
	NbGrainesCases>1,
	NbGrainesCases<4,
	enleverGraine(PJ1,NewPJ1,CaseDebut,NbGrainesCases),
	NewNbGrainesRamassees is NbGrainesRamassees + NbGrainesCases,
	choisirCaseFin(JoueurDebut,CaseDebut, NewCaseDebut, NewJoueurDebut),%recule d'une case
	prendreGraines(JoueurTour,NewJoueurDebut,NewCaseDebut,NewPJ1,PJ2,NPJ1,NPJ2,NewNbGrainesRamassees,TotalGrainesRamassees). %appel récursif



repartirGraines(J,PJ1,PJ2,CaseDebut,NPJ1,NPJ2):- %reparti les graines a partir de la position CaseDebut du plateau du joueur 1
	J = humain1,
	indexL(PJ1,CaseDebut,NbGraines),
	enleverGraine(PJ1,NewPJ1, CaseDebut, NbGraines),
	choisirCaseDebut(J,CaseDebut,NewCaseDebut,NewJ),
	donnerGraines(NewJ,NewPJ1, PJ2, NewCaseDebut,NbGraines, CaseDebut, J,New2PJ1,New2PJ2,CaseFin,JoueurFin),
	afficherPlateau(New2PJ1,New2PJ2),
	prendreGraines(J,JoueurFin,CaseFin,New2PJ1,New2PJ2,New3PJ1,New3PJ2,0,NbGrainesRamassees).



tourPlateau(J1,J2,PJ1,PJ2,Case,PJ1Fin,PJ2Fin,GrainesRamassees) :- %tour de jeu pour une partie humain vs humain, tour du joueur 1, J1 contient le joueur qui joue
	J1 = humain1,
	J2 = humain2,
	afficherPlateau(PJ1,PJ2),
	nl, write('Au joueur 1 de jouer :'), nl,
	choisirCase(PJ1,X),
	repartirGraines(J,PJ1,PJ2,X,NPJ1,NPJ2),
	afficherPlateau(NPJ1,NPJ2).
	
tourPlateau(J1,J2,PJ1,PJ2,Case,PJ1Fin,PJ2Fin,GrainesRamassees) :- %tour de jeu pour une partie humain vs ordinateur
	J1 = humain,
	J2 = ordinateur.
	
