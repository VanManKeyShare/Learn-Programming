
''' LỆNH EXCEL VBA -> TẠO VALIDATION LIST CHO VÙNG DỮ LIỆU ĐỘNG

    Function CREATE_VALIDATION( _
        SHEET_DATA As String, COLUMN_DATA As String, ROW_BEGIN As String, ROW_END As String, _
        SHEET_CREATE_VALIDATION As String, RANGE_CREATE_VALIDATION As String, _
        PWD_UNPROTECT_SHEET As String _
    )

        Dim zRange As Range, zCell As Range
        Dim zRange_OK_For_Valid As String
        Dim zRow_End As Integer: zRow_End = 0

        Set zRange = Worksheets(SHEET_DATA).Range(COLUMN_DATA & ROW_BEGIN & ":" & COLUMN_DATA & ROW_END)
        For Each zCell In zRange
            If Trim(zCell.Value) = "" Then Exit For
            zRow_End = zCell.Row
        Next zCell

        If zRow_End < ROW_BEGIN Then Exit Function

        zRange_OK_For_Valid = SHEET_DATA & "!$" & COLUMN_DATA & "$" & ROW_BEGIN & ":$" & COLUMN_DATA & "$" & zRow_End

        Application.ScreenUpdating = False
        Worksheets(SHEET_CREATE_VALIDATION).Unprotect PWD_UNPROTECT_SHEET

        With Worksheets(SHEET_CREATE_VALIDATION).Range(RANGE_CREATE_VALIDATION).Validation
            .Delete
            .Add Type:=xlValidateList, AlertStyle:=xlValidAlertStop, Operator:=xlEqual, Formula1:="=" & zRange_OK_For_Valid
            .IgnoreBlank = True
            .InCellDropdown = True
            .InputTitle = ""
            .ErrorTitle = "Error"
            .InputMessage = ""
            .ErrorMessage = "YOUR DATA IS NOT ACCEPTED"
            .ShowInput = False
            .ShowError = True
        End With

        Worksheets(SHEET_CREATE_VALIDATION).Protect PWD_UNPROTECT_SHEET
        Application.ScreenUpdating = True

    End Function
