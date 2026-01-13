
''' LỆNH EXCEL VBA -> REGULAR EXPRESSIONS

	Const DATA As String = "Hello @"

	Sub TEST_REGEX()
		If EXCEL_TEST_REGEX(Trim(DATA), "[a-zA-Z0-9]") = True Then
			MsgBox "OK", , "ALERT"
		Else
			MsgBox "ONLY ALPHANUMERIC CHARACTERS ARE ALLOWED", , "ALERT"
			Exit Sub
		End If
	End Sub

	Private Function EXCEL_TEST_REGEX(sValue As String, RegEx As String) As Boolean
		EXCEL_TEST_REGEX = sValue Like WorksheetFunction.Rept(RegEx, Len(sValue))
	End Function
