﻿Debut
Saisir(Age,Quel est votre age?)
Aller(13)
Si (|Age| > 100 )
Afficher('Vantard!')

Si (|Age| > 40 )
Afficher('Cà devient sérieux!')

Si (|Age| <= 30 )
Afficher('Vous avez êtes jeune! Vous avez |Age| ans!')

Si (|Age| > 30 )
Afficher('Vous avez êtes moins jeune! Vous avez |Age| ans!')

Affecter(ap,|Age| + 1)
Afficher('Vous aurez |ap| ans l'année prochaine!')
Afficher('Le programme est terminé!')
Fin
