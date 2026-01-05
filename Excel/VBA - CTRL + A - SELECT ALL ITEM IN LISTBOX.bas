
LỆNH EXCEL VBA -> CTRL + A -> SELECT ALL ITEM IN LISTBOX

	Private Sub LisDSHS_KeyPress(ByVal KeyAscii As MSForms.ReturnInteger)
		If KeyAscii = 1 Then
			Dim I As Integer
			For I = 0 To LisDSHS.ListCount - 1
				LisDSHS.Selected(I) = True
			Next I
		End If
	End Sub
