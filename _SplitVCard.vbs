' (c) C:Amie. All Rights Reserved 1996 - 2017.
' http://www.c-amie.co.uk/
' SplitVCard.vbs | Version 1.0.1
' This program takes a monolithic .vcf file and splits it into individual .vcf files for
' each countact found inside the source vCard file
' Usage: cscript.exe SplitVCard.vbs "C:\Bla\Bla\Bla\Contacts.vcf"
' Source : http://www.c-amie.co.uk/technical/android-vcf-outlook-import/
' Modified by boissonnfive@hotmail.com to read UTF-8 VCF file

Option Explicit
Dim i
Dim x
Dim iRows
Dim strSource
Dim strPwd
Dim strTargetPath
Dim strText
Dim strContactName
Dim strDestFile
Dim arrContacts
Dim arrLines

Dim file
Dim fso
set fso = CreateObject("Scripting.FileSystemObject")

if (WScript.Arguments.Count > 0) then
	strSource = WScript.Arguments(0)
	strPwd = CreateObject("WScript.Shell").CurrentDirectory

	if (fso.FileExists(strSource)) then
		wscript.echo "Source: " & strSource
		' Check to see if a new output folder exists
		strTargetPath = strPwd & "\" & year(now()) & Right("0" & Month(now()), 2) & Right("0" & Day(now()), 2) & "_vcf"
		WScript.Echo "Destination Folder: " & strTargetPath
		if (NOT fso.FolderExists(strTargetPath)) then
			fso.CreateFolder(strTargetPath)
		end if


		' Scan the source file and split the VCF
		Dim objStream

		Set objStream = CreateObject("ADODB.Stream")
		
		objStream.CharSet = "utf-8"
		objStream.Open
		objStream.LoadFromFile(strSource)
		
		strText = objStream.ReadText()
		
		objStream.Close
		Set objStream = Nothing


		' set file = fso.OpenTextFile(strSource, 1)
		' strText = file.ReadAll()
		' call file.close()
		' set file = nothing

		arrContacts = Split(strText, "END:VCARD")
		if (IsArray(arrContacts)) then
			iRows = UBound(arrContacts,1)
			if (iRows > -1) then
				for i = 0 to iRows
					strContactName = ""
					' Try and locate the contact name
					arrLines = Split(arrContacts(i), vbcrlf)
					for x = 0 to UBound(arrLines,1)
						if (Left(arrLines(x), 3) = "FN:") then
							strContactName = Right(arrLines(x), (Len(arrLines(x)) - 3))
							Exit For
						end if
					next
					' Sanitise the Contact Name
					strContactName = Trim(strContactName)
					if (Len(strContactName) = 0) then
						strContactName = "Unknown Contact " & i
					else
						strContactName = Replace(strContactName, ">", "--")
						strContactName = Replace(strContactName, "<", "--")
						strContactName = Replace(strContactName, ":", "--")
						strContactName = Replace(strContactName, "\", "--")
						strContactName = Replace(strContactName, "?", "--")
						strContactName = Replace(strContactName, "/", "--")
					end if

					strDestFile = strTargetPath & "\" & strContactName & ".vcf"
					wscript.echo "Writing File" & strDestFile

					set file = fso.CreateTextFile(strDestFile, true)
						file.Write(arrContacts(i) & vblf & "END:VCARD")
						file.close()
				next
				set file = nothing
			end if
		end if
	else
		wscript.echo strSource & " does not exist"
	end if
else
	WScript.Echo "Drag the Source VCF onto the script file or specify the path to the source file"
end if
