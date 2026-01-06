
LỆNH EXCEL VBA -> CTRL + A -> SELECT ALL ITEM IN LISTBOX

	Private Sub LISTBOX_DATA_KeyPress(ByVal KeyAscii As MSForms.ReturnInteger)
		If KeyAscii = 1 Then
			Dim I As Integer
			For I = 0 To LISTBOX_DATA.ListCount - 1
				LISTBOX_DATA.Selected(I) = True
			Next I
		End If
	End Sub
