
LỆNH EXCEL VBA -> SORT ARRAY FROM A TO Z

    Function SORT_ARRAY_A_TO_Z(MyArray As Variant) As Variant
        Dim I As Long
        Dim J As Long
        Dim Temp
        For I = LBound(MyArray) To UBound(MyArray) - 1
            For J = I + 1 To UBound(MyArray)
                If UCase(MyArray(I)) > UCase(MyArray(J)) Then
                Temp = MyArray(J)
                MyArray(J) = MyArray(I)
                MyArray(I) = Temp
                End If
            Next J
        Next I
        SORT_ARRAY_A_TO_Z = MyArray
    End Function
