
LỆNH EXCEL VBA -> KIỂM TRA VÀ THAY THẾ TÊN FILE

    Private Function CCEXCEL_CHECK_REPLACE_FILE_NAME(sFileName As String) As String

        Dim CharNoAllow As String

        CharNoAllow = "<"
        Do While InStr(1, sFileName, CharNoAllow, 0) > 0
            sFileName = Replace(sFileName, CharNoAllow, "_")
        Loop

        CharNoAllow = ">"
        Do While InStr(1, sFileName, CharNoAllow, 0) > 0
            sFileName = Replace(sFileName, CharNoAllow, "_")
        Loop

        CharNoAllow = ":"
        Do While InStr(1, sFileName, CharNoAllow, 0) > 0
            sFileName = Replace(sFileName, CharNoAllow, "_")
        Loop

        CharNoAllow = Chr(34)
        Do While InStr(1, sFileName, CharNoAllow, 0) > 0
            sFileName = Replace(sFileName, CharNoAllow, "_")
        Loop

        CharNoAllow = "/"
        Do While InStr(1, sFileName, CharNoAllow, 0) > 0
            sFileName = Replace(sFileName, CharNoAllow, "_")
        Loop

        CharNoAllow = "\"
        Do While InStr(1, sFileName, CharNoAllow, 0) > 0
            sFileName = Replace(sFileName, CharNoAllow, "_")
        Loop

        CharNoAllow = "|"
        Do While InStr(1, sFileName, CharNoAllow, 0) > 0
            sFileName = Replace(sFileName, CharNoAllow, "_")
        Loop

        CharNoAllow = "?"
        Do While InStr(1, sFileName, CharNoAllow, 0) > 0
            sFileName = Replace(sFileName, CharNoAllow, "_")
        Loop

        CharNoAllow = "*"
        Do While InStr(1, sFileName, CharNoAllow, 0) > 0
            sFileName = Replace(sFileName, CharNoAllow, "_")
        Loop

        CharNoAllow = "["
        Do While InStr(1, sFileName, CharNoAllow, 0) > 0
            sFileName = Replace(sFileName, CharNoAllow, "_")
        Loop

        CharNoAllow = "]"
        Do While InStr(1, sFileName, CharNoAllow, 0) > 0
            sFileName = Replace(sFileName, CharNoAllow, "_")
        Loop

        CCEXCEL_CHECK_REPLACE_FILE_NAME = sFileName

    End Function
