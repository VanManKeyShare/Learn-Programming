
''' LỆNH EXCEL VBA -> HÀM SLEEP

    #If VBA7 Then
        'FOR 64-BIT MS OFFICE
        Public Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal Milliseconds As LongPtr)
    #Else
        'FOR 32-BIT MS OFFICE
        Public Declare PtrSafe Sub Sleep Lib "kernel32" (ByVal Milliseconds As Long)
    #End If
