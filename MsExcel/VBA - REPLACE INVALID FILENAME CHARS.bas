
LỆNH EXCEL VBA -> REPLACE INVALID FILENAME CHARS

    Private Function Replace_Invalid_FileName_Chars(ByVal sFileName As String) As String

        Dim ArrCharNoAllow As Variant
        Dim I As Long

        ArrCharNoAllow = Array("<", ">", ":", Chr(34), "/", "\", "|", "?", "*", "[", "]")

        For I = LBound(ArrCharNoAllow) To UBound(ArrCharNoAllow)
            sFileName = Replace(sFileName, ArrCharNoAllow(I), "_")
        Next I

        Replace_Invalid_FileName_Chars = sFileName

    End Function
