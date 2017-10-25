Debut
Afficher(Ce programme determine si une année est bisextile)
Saisir(a,Entrez une annee SVP)
Si (|a| < 2006 )
Aller(3)
//
Affecter(test, |a| mod 4)
Affecter(prochaine, |a| - |test| + 4)
Si( |test| = 0 )
Afficher( |a| est une année bisextile )
Afficher( |a| n'est pas bisextile |prochaine| le sera)
Fin
