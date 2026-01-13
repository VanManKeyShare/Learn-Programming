
''' LỆNH EXCEL VBA -> CHECK WORKBOOK IS READY

    Public Function CHECK_WORKBOOK_IS_READY(Optional Show_Error As Boolean = True) As Boolean
        On Error Resume Next
        Dim WS As Worksheet
        Set WS = Sheets
        If Err.Number = 1004 Then
            If Show_Error = True Then MsgBox "PLEASE CREATE WORKBOOK", , "Message"
            CHECK_WORKBOOK_IS_READY = False
        Else
            CHECK_WORKBOOK_IS_READY = True
        End If
    End Function
