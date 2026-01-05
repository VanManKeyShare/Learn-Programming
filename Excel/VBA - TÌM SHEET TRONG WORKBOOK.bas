
LỆNH EXCEL VBA -> TÌM SHEET TRONG WORKBOOK

    Public Function Find_SHEET(NameSHEET As String) As Boolean
        On Error Resume Next
        Dim WS
        Find_SHEET = False
        For Each WS In Worksheets
            If LCase(Trim(NameSHEET)) = LCase(Trim(WS.Name)) Then
                Find_SHEET = True
                Exit Function
            End If
        Next WS
    End Function
