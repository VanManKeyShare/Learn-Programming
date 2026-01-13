
''' LỆNH EXCEL VBA -> CHECK DATA IS IN ARRAY

    Private Function IsInArray(DATA As Variant, Arr As Variant) As Boolean
        Dim Elemen As Variant
        On Error GoTo IsInArrayError:
            For Each Elemen In Arr
                If UCase(Elemen) = UCase(DATA) Then
                    IsInArray = True
                    Exit Function
                End If
            Next Elemen
        Exit Function
    IsInArrayError:
        On Error GoTo 0
        IsInArray = False
    End Function
