CLS REM On efface l'�cran
@echo off
echo +-----------------------------------------------------------------------------+
echo ^| Fichier     : Mot_de_passe.bat                                              ^|
echo ^| Version     : 0.1                                                           ^|
echo ^| Auteur      : Bruno Boissonnet                                              ^|
echo ^| Date        : 17/06/2019                                                    ^|
echo ^| Description : Ouvre les fen�tres pour d�sactiver le mot de passe Windows.   ^|
echo +-----------------------------------------------------------------------------+
echo(
echo Faites Ctrl+C pour quitter le programme ou appuyez sur une touche pour continuer.

REM On fait une pause pour que la fen�tre reste affich�e
pause>nul

REM +--DEBUT-DU-PROGRAMME---------------------------------------------------------+

echo(

echo 1- Ouverture de la fen�tre pour d�sactiver le mot de passe � l'ouverture de la session
echo (Appuyez sur une touche pour afficher la fen�tre)
pause>nul

netplwiz

echo(

echo 2- Ouverture de la fen�tre pour d�sactiver le mot de passe pour la sortie de veille
echo (Appuyez sur une touche pour afficher la fen�tre)
pause>nul

start ms-settings:signinoptions


REM +--FIN-DU-PROGRAMME-----------------------------------------------------------+

echo(
REM On fait une pause pour que la fen�tre reste affich�e
echo Appuyez sur une touche pour quitter le programme.
pause>nul 