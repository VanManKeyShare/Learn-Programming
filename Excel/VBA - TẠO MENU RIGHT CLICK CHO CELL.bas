
LỆNH EXCEL VBA -> TẠO MENU RIGHT CLICK CHO CELL

	+ Module

		Option Explicit

		Const SHEET_DATA = "DATA"
		Const COLUMN_INSERT_MENU = 9
		Const ROW_BEGIN_INSERT_MENU = 3
		Const ROW_END_INSERT_MENU = 10000

		Private Sub PROCESS_MENU_RIGHT_CLICK()

			If Selection.Count < 1 Then Exit Sub

			If UCase(Selection.Worksheet.Name) <> UCase(SHEET_DATA) Then
				MsgBox "ONLY WORK ON SHEET " & SHEET_DATA, , "Message"
				Exit Sub
			End If

			If Selection.Column <> COLUMN_INSERT_MENU Then
				MsgBox "ONLY WORK ON COLUMN " & COLUMN_INSERT_MENU, , "Message"
				Exit Sub
			End If

			If Selection.Row >= ROW_BEGIN_INSERT_MENU And Selection.Row <= ROW_END_INSERT_MENU Then
				Dim Cell As Range
				Dim Value_From_Cell As String
				Set Cell = Selection
				Value_From_Cell = Trim(Cell.Value)
				If Value_From_Cell <> "" Then
					MsgBox Value_From_Cell, , "Message"
				Else
					MsgBox "Null", , "Message"
				End If
			Else
				MsgBox "ONLY WORK ON ROW " & ROW_BEGIN_INSERT_MENU & " TO " & ROW_END_INSERT_MENU, , "Message"
				Exit Sub
			End If

		End Sub

		Private Sub CREATE_MENU_RIGHT_CLICK()
			Dim CBCONTROL As CommandBarControl
			Set CBCONTROL = Application.CommandBars("Cell").Controls.Add(Type:=msoControlButton, Before:=1)
			CBCONTROL.Tag = "VMK"
			CBCONTROL.Caption = "TEST MENU RIGHT CLICK"
			CBCONTROL.OnAction = "PROCESS_MENU_RIGHT_CLICK"
		End Sub

		Private Sub REMOVE_MENU_RIGHT_CLICK()
			Dim CBCONTROL As CommandBarControl
			For Each CBCONTROL In Application.CommandBars("Cell").Controls
				If CBCONTROL.Tag = "VMK" Then CBCONTROL.Delete
			Next
		End Sub

	+ ThisWorkbook

		Private Sub Workbook_BeforeClose(Cancel As Boolean)
			Run ("REMOVE_MENU_RIGHT_CLICK")
		End Sub

		Private Sub Workbook_SheetBeforeRightClick(ByVal Sh As Object, ByVal Target As Range, Cancel As Boolean)
			Run ("REMOVE_MENU_RIGHT_CLICK")
			Run ("CREATE_MENU_RIGHT_CLICK")
		End Sub
