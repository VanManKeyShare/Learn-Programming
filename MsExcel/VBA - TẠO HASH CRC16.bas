
LỆNH EXCEL VBA -> TẠO HASH CRC16

    Function VMK_HASH_CRC16(DATA As String) As String

        Dim BYTES() As Byte
        BYTES = StrConv(DATA, vbFromUnicode)

        Dim CRC As Long
        CRC = &HFFFF&

        Dim I As Integer, J As Integer
        For I = LBound(BYTES) To UBound(BYTES)
            CRC = CRC Xor BYTES(I)
            For J = 1 To 8
                If (CRC And 1) Then
                    CRC = ((CRC And &HFFFFFFFE) \ 2) Xor &HA001&
                Else
                    CRC = (CRC And &HFFFFFFFE) \ 2
                End If
            Next J
        Next I

        VMK_HASH_CRC16 = Right("0000" & Hex(CRC), 4)

    End Function
