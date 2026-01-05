
LỆNH EXCEL VBA -> REGEX CHECK IS ALLOW STRING

	If CCEXCEL_IS_ALLOW_STRING(Trim(T1.Text), "[a-zA-Z0-9]") = False Then
		T1.Text = "": T1.SetFocus
		MsgBox "Only Allow Alpha And Numeric", , "THÔNG BÁO"
		Exit Sub
	End If

	Private Function CCEXCEL_IS_ALLOW_STRING(sValue As String, RegEx As String) As Boolean
		CCEXCEL_IS_ALLOW_STRING = sValue Like WorksheetFunction.Rept(RegEx, Len(sValue))
	End Function
