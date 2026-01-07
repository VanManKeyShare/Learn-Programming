
''' VBSCRIPT -> END PROCESS USING TASKKILL.EXE AND WINMGMTS OBJECT

	'1. END PROCESS BY TASKKILL.EXE
		Dim Exec, oShell
		Dim INTWINDOWSTYLE, BWAITONRETURN
		INTWINDOWSTYLE = 0
		BWAITONRETURN = True
		Set oShell = CreateObject("Wscript.Shell")
		Exec = oShell.Run("%SYSTEMROOT%\SYSTEM32\TASKKILL.EXE /F /IM EXPLORER.EXE", INTWINDOWSTYLE, BWAITONRETURN)

	'2. END PROCESS BY OBJECT WINMGMTS
		Dim oServ, cProc, oProc
		Set oServ = GetObject("winmgmts:")
		Set cProc = oServ.ExecQuery("Select * from Win32_Process")
		For Each oProc In cProc
			If UCase(oProc.Name) = "EXPLORER.EXE" Then oProc.Terminate()
		Next
