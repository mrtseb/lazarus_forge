Debut
Saisir(unite,Unité ? 1=°C 2=°F)
Si (|unite| = 1 )
Saisir(valeur,Entrez la température en °C)
//
Si (|unite| = 2 )
Saisir(valeur,Entrez la température en °F)
//
Affecter(FtoC, (|valeur| - 32) / 1,8)
Affecter(CtoF, |valeur|*1,8+32)
Si (|unite| = 1 )
Afficher( |valeur| °C =  |CtoF| °F)
Afficher( |valeur| °F =  |FtoC| °C)
Fin
