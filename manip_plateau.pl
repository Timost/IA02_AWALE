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




choisirCaseFin(J,CaseFin,NewCaseFin,NewJ):- %retourne la première case du plateau dans lequel on met une graine
	J=humain1,
	CaseFin=1,
	NewJ = humain2,
	NewCaseFin is 6.

choisirCaseFin(J,CaseFin,NewCaseFin,NewJ):- %retourne la première case du plateau dans lequel on met une graine
	J=humain2,
	CaseFin=1,
	NewJ = humain1,
	NewCaseFin is 6.

choisirCaseFin(J,CaseFin,NewCaseFin,NewJ):- %retourne la première case du plateau dans lequel on met une graine
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

donnerGraines(J,PJ1,PJ2,CaseDebut,StockGraines,CaseOrigine, JoueurDebut,NPJ1,NPJ2,CaseFin,JoueurFin):-%J indique sur quel plateau commencer la distribution
	J=humain2,
	(different(J,JoueurDebut) ; different(CaseDebut,CaseOrigine)),
	ajouterGraine(PJ2,NewPJ2,CaseDebut,1),
	choisirCaseDebut(J,CaseDebut,NewCaseDebut,NewJ),
	NewStockGraines is StockGraines-1,
	donnerGraines(NewJ,PJ1,NewPJ2,NewCaseDebut,NewStockGraines,CaseOrigine, JoueurDebut,NPJ1,NPJ2,CaseFin,JoueurFin).

repartirGraines(J,PJ1,PJ2,CaseDebut,NPJ1,NPJ2):- %reparti les graines a partir de la position CaseDebut du plateau du joueur 1
	J = humain1,
	indexL(PJ1,CaseDebut,NbGraines),
	enleverGraine(PJ1,NewPJ1, CaseDebut, NbGraines),
	choisirCaseDebut(J,CaseDebut,NewCaseDebut,NewJ),
	donnerGraines(NewJ,NewPJ1, PJ2, NewCaseDebut,NbGraines, CaseDebut, J,New2PJ1,New2PJ2,CaseFin,JoueurFin),
	afficherPlateau(New2PJ1,New2PJ2),
	write(CaseFin),nl,
	write(JoueurFin).



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
	
