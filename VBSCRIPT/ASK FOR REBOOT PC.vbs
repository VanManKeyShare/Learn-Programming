
''' VBSCRIPT -> ASK FOR REBOOT PC -> Version 2023.12.16

Option Explicit

Dim TITLE, COMPUTER
TITLE = "ASK FOR REBOOT PC - Version 2023.12.16"
COMPUTER = "."

Function DOUBLE_QUOTES(STR)
    DOUBLE_QUOTES = Chr(34) & STR & Chr(34)
End Function

If Not WScript.Arguments.Named.Exists("elevate") Then
    CreateObject("Shell.Application").ShellExecute DOUBLE_QUOTES(WScript.FullName), DOUBLE_QUOTES(WScript.ScriptFullName) & " /elevate", "", "runas", 1
    WScript.Quit
End If

Call ASK_REBOOT_THIS_PC()

Sub ASK_REBOOT_THIS_PC()
	Dim QUESTION

	QUESTION = MsgBox("RESTART COMPUTER TO APPLY THESE CHANGES" & vbCrLf & vbCrLf _
	& "YES TO RESTART" & vbCrLf _
	& "NO TO CANCEL", vbYesNo + vbQuestion, TITLE)

    If QUESTION = vbYes Then
		Dim WS, COMMAND, RESULT
		Set WS = CreateObject("Wscript.Shell")
		COMMAND = "SHUTDOWN.EXE /r /t 30 /c " & DOUBLE_QUOTES("SAVE YOUR DOCUMENTS >> THIS PC WILL RESTARTS AFTER 30 SECONDS")
		RESULT = WS.run(COMMAND,0,True)
    Else
        WScript.Quit(1)
    End If
End Sub
