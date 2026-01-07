
''' VBSCRIPT -> STRING TO HEX, BINARY SUPPORT UNICODE

        Function STRING_TO_HEX_UNICODE(STRING_UNICODE, BINARY)
                Dim HexTemp, Kq, I
                Kq = ""
                For I = 1 To Len(STRING_UNICODE)
                        HexTemp = Hex(AscW(Mid(STRING_UNICODE, I, 1)))
                        If Len(HexTemp) = 1 OR Len(HexTemp) = 3 Then HexTemp = "0" & HexTemp
                        If Len(HexTemp) = 4 Then
                                Dim A, B
                                A = Mid(HexTemp,1,2)
                                B = Mid(HexTemp,3,4)
                                HexTemp = B & A
                        End If
                        If Len(HexTemp) = 2 And BINARY = True And I <> Len(STRING_UNICODE) Then HexTemp = HexTemp & "00"
                        If BINARY <> True And I <> Len(STRING_UNICODE) Then HexTemp = HexTemp & "  "
                        Kq = Kq & HexTemp
                Next
                STRING_TO_HEX_UNICODE = Kq
        End Function

        ''' Example

        Dim STRING_UNICODE
        STRING_UNICODE = InputBox("PLEASE ENTER A UNICODE STRING","Hello","")

        Msgbox STRING_UNICODE & vbcrlf & vbcrlf & "HEX = " & STRING_TO_HEX_UNICODE(STRING_UNICODE, False)
        Msgbox STRING_UNICODE & vbcrlf & vbcrlf & "BINARY = " & STRING_TO_HEX_UNICODE(STRING_UNICODE, True)
