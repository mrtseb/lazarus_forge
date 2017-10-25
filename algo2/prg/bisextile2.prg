Debut
Afficher(Ce programme determine si une année est bisextile)
Aller(7)
Aller(12)
Fin
// Déclarations par procedures
//  Procedure de saisie
Saisir(a,Entrez une annee SVP)
Si (|a| < 2006 )
Aller(7)
Aller(4)
//  Procedure de test
Affecter(test, |a| mod 4)
Affecter(prochaine, |a| - |test| + 4)
Si( |test| = 0 )
Afficher( |a| est une année bisextile )
Afficher( |a| n'est pas bisextile |prochaine| le sera)
Aller(5)
