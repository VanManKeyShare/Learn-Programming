
LỆNH EXCEL VBA -> LẤY DỮ LIỆU CLIPBOARD VÀO LISTBOX

	LST_DS_DATA_IN_CLIPBOARD.Clear

	Dim EXTRACT_DATA() As String
	Dim obClipBoard As Object
	Dim LngCounTer As Long
	Dim i As Integer

	Set obClipBoard = CreateObject("new:{1C3B4210-F441-11CE-B9EA-00AA006B1A69}")
	obClipBoard.GetFromClipboard

	For LngCounTer = 1 To UBound(Application.ClipboardFormats)
	If Application.ClipboardFormats(LngCounTer) = xlClipboardFormatText Then
		EXTRACT_DATA() = Split(Trim(obClipBoard.GetText(LngCounTer)), vbCrLf)
		For i = 0 To UBound(EXTRACT_DATA)
		LST_DS_DATA_IN_CLIPBOARD.AddItem Trim(EXTRACT_DATA(i))
		Next i
	End If
	Next LngCounTer
