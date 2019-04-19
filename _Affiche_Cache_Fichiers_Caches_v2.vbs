'+----------------------------------------------------------------------------+
'| Fichier     : AfficheCacheFichiersCaches.vbs                               |
'+----------------------------------------------------------------------------+
'| Version     : 0.2                                                          |
'+----------------------------------------------------------------------------+
'| Description :                                                              |
'|                                                                            |
'| Affiche/Cache les fichiers cach�s.                                         |
'|                                                                            |
'|    - On modifie des cl�s du registre (voir dans le code).                  |
'+----------------------------------------------------------------------------+



' Force la d�claration des variables : on est oblig� de faire : `Dim Variable`
Option Explicit

' Emp�che les erreurs de s'afficher (� supprimer lors du d�bogage)
' Doit �tre ajout� dans chaque routine
'On Error Resume Next

' D�claration des variables obligatoire
Dim result, strEnTeteScript, strTitre ' Ne pas toucher � ces variables
Dim strNomScript, strVersionScript, strDescription ' Ne pas toucher � ces variables

' Initialisation des variables
strNomScript               = "AfficheCacheFichiersCaches.vbs"
strVersionScript           = "0.2"
strDescription             = "Affiche/Cache les fichiers cach�s."
strTitre                   = "AfficheCacheFichiersCaches.vbs"
strEnTeteScript            = ""
strEnTeteScript            = strEnTeteScript & strNomScript & " - V" & strVersionScript & vbNewLine
strEnTeteScript            = strEnTeteScript & strDescription & vbNewLine





' Demande de validation pour l'ex�cution du script
'result = MsgBox ("Ce script va afficher le contenu du dossier " _
'                 & strFolder & " ." _
'                 & vbNewLine & "Voulez-vous continuer ?", _
'                 vbYesNo+vbQuestion, strTitre)

result = MsgBox (strEnTeteScript _
                 & vbNewLine & "Voulez-vous continuer ?", _
                 vbYesNo+vbQuestion, strTitre)

If result = 6 Then

  Call Main()

End If

' Message d'avertissement de fin de script.
result = MsgBox ("Script Termin�", vbOKOnly+vbInformation, strTitre)



'------------------------------------------------------------------------------
' Programme principal
'------------------------------------------------------------------------------

'- Cl�s du registre :
'     HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\Hidden
'         =1 (dword)
'         Afficher les fichiers, dossiers et lecteurs cach�s
'         =2 (dword)
'         Ne pas afficher les fichiers, dossiers ou lecteurs cach�s

'     HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\ShowSuperHidden*
'         =1 (dword) => d�coch�
'         Masquer les fichiers prot�g�s du syst�me d'exploitation
'         =0  (dword) ou cl� n'existe pas => coch�

'     HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\SuperHidden*
'         =1 (dword)
'         Affich�s
'         =0 (dword)
'         Cach�s


Sub Main()

  dim strRegistre, strCle1, str1, strCle2, str2, strCle3, str3, objShell
    
  strRegistre = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\"

  strCle1 = "Hidden"
  str1 = ReadFromRegistry(strRegistre & strCle1, "ha")
  strCle2 = "ShowSuperHidden"
  str2 = ReadFromRegistry(strRegistre & strCle2, "ha")
  strCle3 = "SuperHidden"
  str3 = ReadFromRegistry(strRegistre & strCle3, "ha")

  ' WScript.echo "Hidden = " & str1
  ' WScript.echo "ShowSuperHidden = " & str2

  Set objShell = CreateObject("WScript.Shell")


  If str1 = "1" Or str2 = "1"  Then 
    ' WScript.echo "Fichiers cach�s affich�s. On les cache."
    objShell.RegWrite strRegistre & strCle1,2,"REG_DWORD"
    objShell.RegWrite strRegistre & strCle2,0,"REG_DWORD"
    objShell.RegWrite strRegistre & strCle3,0,"REG_DWORD"
  Else
    ' WScript.echo "Fichiers cach�s PAS affich�s. On les affiche."
    objShell.RegWrite strRegistre & strCle1,1,"REG_DWORD"
    objShell.RegWrite strRegistre & strCle2,1,"REG_DWORD"
    objShell.RegWrite strRegistre & strCle3,1,"REG_DWORD"
  End If


  call RafraichitExplorateur()

  set objShell = Nothing

End Sub

'------------------------------------------------------------------------------
' Nom              : ReadFromRegistry.
' strRegistryKey   : Nom complet de la cl� du registre.
' strDefault       : Valeur � renvoyer si erreur.
' retour           : La valeur de la cl� ou strDefault si erreur.
'------------------------------------------------------------------------------
function ReadFromRegistry (strRegistryKey, strDefault )
	dim objShell, value
	
	'On Error Resume Next

	set objShell = CreateObject("WScript.Shell")
	value        = objShell.RegRead( strRegistryKey )
	
	If Err.number <> 0 Then
		ReadFromRegistry = strDefault
	Else
		ReadFromRegistry = value
	End If
	
	set objShell = nothing
end function


'------------------------------------------------------------------------------
' Nom              : RafraichitExplorateur.
' Description      : Actualise toutes les fen�tres ouvertes de l'explorateur windows.
'------------------------------------------------------------------------------
function RafraichitExplorateur() 
   dim WshShellX, objShell, objIE, objShellWindows
   
   set objShell        = CreateObject("Shell.Application")
   set WshShellX       = CreateObject("WScript.Shell")
   set objShellWindows = objShell.Windows
   
   ' Attention !
   ' Cet objet contient les fen�tres explorateur window + internet explorer
   If objShellWindows.Count <> 0 Then
   
      for each objIE in objShellWindows
      'For i = 0 to objShellWindows.Count - 1
      
          'Set objIE = objShellWindows.Item(i)
          
          'strURL = objIE.LocationURL
          ' WScript.Echo strURL & vbCrLf & objIE.Path
          
          ' Si l'URL commence par "file:///",
          ' alors c'est une fen�tre de l'explorateur windows
          'If InStr(strURL, "file:///") Then
         if InStr(objIE.LocationURL, "file:///") then
            objIE.Refresh
         end if
          
         'Set objIE = Nothing
      next

   end if

   ' Actualise le bureau
   call RafraichitBureau()
      
   set objShell  = nothing
   set WshShellX = nothing

end function

'------------------------------------------------------------------------------
' Nom              : RafraichitBureau.
' Description      : Actualise le bureau l'explorateur windows.
'------------------------------------------------------------------------------
function RafraichitBureau() 
   Dim WshShellX, objShell, objIE, objShellWindows
   
   set objShell        = CreateObject("Shell.Application")
   set WshShellX       = CreateObject("WScript.Shell")
   
   objShell.ToggleDesktop
   WScript.Sleep 100
   WshShellX.SendKeys "{F5}"
   WScript.Sleep 100
   objShell.ToggleDesktop
   
   set objShell  = nothing
   set WshShellX = nothing

end function
