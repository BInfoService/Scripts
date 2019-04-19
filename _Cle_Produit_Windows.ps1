# La clé d'activation de Windows (8 et 8.1) peut également être affichée sans utiliser un programme tiers :
#
# 1) Ouvrir "Invite de commande" en tan qu'administrateur.
# 2) Entrer la commande suivante :

powershell "(Get-WmiObject -query ‘select * from SoftwareLicensingService’).OA3xOriginalProductKey"