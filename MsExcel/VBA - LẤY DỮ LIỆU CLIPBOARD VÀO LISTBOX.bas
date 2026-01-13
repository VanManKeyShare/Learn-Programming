
''' LỆNH EXCEL VBA -> LẤY DỮ LIỆU CLIPBOARD VÀO LISTBOX

	Sub IMPORT_CLIPBOARD_TO_LISTBOX()

		LISTBOX_DATA.Clear

		Dim EXTRACT_DATA() As String
		Dim obClipBoard As Object
		Dim LngCOUNTER As Long
		Dim I As Integer

		Set obClipBoard = CreateObject("new:{1C3B4210-F441-11CE-B9EA-00AA006B1A69}")
		obClipBoard.GetFromClipboard

		For LngCOUNTER = 1 To UBound(Application.ClipboardFormats)
			If Application.ClipboardFormats(LngCOUNTER) = xlClipboardFormatText Then
				EXTRACT_DATA() = Split(Trim(obClipBoard.GetText(LngCOUNTER)), vbCrLf)
				For I = 0 To UBound(EXTRACT_DATA)
					LISTBOX_DATA.AddItem Trim(EXTRACT_DATA(I))
				Next I
			End If
		Next LngCOUNTER

	End Sub
