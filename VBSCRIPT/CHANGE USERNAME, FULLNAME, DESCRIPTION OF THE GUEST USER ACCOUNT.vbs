
''' VBSCRIPT -> CHANGE USERNAME, FULLNAME, DESCRIPTION OF THE GUEST USER ACCOUNT -> Version 2023.12.16
'''
''' THIS SCRIPT ALLOWS YOU TO CHANGE THE USERNAME, FULL NAME, AND DESCRIPTION OF THE GUEST USER ACCOUNT ON A WINDOWS SYSTEM.
''' IT PROMPTS FOR THE NEW VALUES AND APPLIES THE CHANGES USING WMIC AND NET USER COMMANDS.

Option Explicit

Dim TITLE, COMPUTER
TITLE = "Change UserName + FullName - Version 2023.12.16"
COMPUTER = "."

Function DOUBLE_QUOTES(STR)
    DOUBLE_QUOTES = Chr(34) & STR & Chr(34)
End Function

If Not WScript.Arguments.Named.Exists("elevate") Then
    CreateObject("Shell.Application").ShellExecute DOUBLE_QUOTES(WScript.FullName), DOUBLE_QUOTES(WScript.ScriptFullName) & " /elevate", "", "runas", 1
    WScript.Quit
End If

Call CHANGE_FULLNAME_FOR_USERNAME()
Call CHANGE_DESCRIPTION_FOR_USERNAME()
Call RENAME_USERNAME()

Function GET_CURRENT_USERNAME()
	Dim WSH_SHELL
	Set WSH_SHELL = CreateObject( "WScript.Shell" )
	GET_CURRENT_USERNAME = WSH_SHELL.ExpandEnvironmentStrings("%USERNAME%")
End Function

Sub RENAME_USERNAME()
	Dim New_UserName

    New_UserName = InputBox("PLEASE ENTER THE NEW USERNAME" & vbCrlf & vbCrlf & "FOR GUEST USER", TITLE, "")
    If New_UserName = "" Then Exit Sub

	Dim WS, COMMAND, RESULT
	Set WS = CreateObject("Wscript.Shell")
	COMMAND = "WMIC USERACCOUNT where name='GUEST' rename " & DOUBLE_QUOTES(New_UserName)
	RESULT = WS.run(COMMAND,0,True)
End Sub

Sub CHANGE_FULLNAME_FOR_USERNAME()
	Dim New_FullName

    New_FullName = InputBox("PLEASE ENTER THE NEW FULL NAME" & vbCrlf & vbCrlf & "FOR GUEST USER", TITLE, "")
    If New_FullName = "" Then Exit Sub

	Dim WS, COMMAND, RESULT
	Set WS = CreateObject("Wscript.Shell")
	COMMAND = "WMIC USERACCOUNT where name='GUEST' set FullName=" & DOUBLE_QUOTES(New_FullName)
	RESULT = WS.run(COMMAND,0,True)
End Sub

Sub CHANGE_DESCRIPTION_FOR_USERNAME()
	Dim New_DESCRIPTION

    New_DESCRIPTION = InputBox("PLEASE ENTER THE NEW DESCRIPTION" & vbCrlf & vbCrlf & "FOR GUEST USER", TITLE, "")
    If New_DESCRIPTION = "" Then Exit Sub

	Dim WS, COMMAND, RESULT
	Set WS = CreateObject("Wscript.Shell")
	COMMAND = "NET USER " & DOUBLE_QUOTES("GUEST") & " /comment:" & DOUBLE_QUOTES(New_DESCRIPTION)
	RESULT = WS.run(COMMAND,0,True)
End Sub
