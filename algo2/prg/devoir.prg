Debut
Saisir(nomArticle,'Entrez le nom du produit')
Saisir(prixHT,'Entrez le prixHT en €')
Saisir(typeArticle,'Entrez le type pour votre article 0:Alimentaire 1:Autre')
Si (|typeArticle| = 0)
Affecter(tva,|prixHT|* 5,5 / 100)
Affecter(tva,|prixHT|* 19,6 / 100)
Affecter(ttc,|prixHT|+|tva|)
Afficher('Voici les résultats pour votre article |nomArticle|')
Afficher(HT = |prixHT| €  TVA = |tva| € Prix TTC = |ttc| €)
Afficher('Le programme est terminé!')
Fin
