
''' LỆNH EXCEL VBA -> CHUYỂN SỐ SANG TIẾNG ANH

Option Explicit

Function NUMBERS_TO_WORDS_ENGLISH(STR_NUMBER As String) As String

    STR_NUMBER = Trim(STR_NUMBER)
    STR_NUMBER = Replace(STR_NUMBER, ",", "")
    STR_NUMBER = Replace(STR_NUMBER, " ", "")

    If STR_NUMBER = "" Then
        NUMBERS_TO_WORDS_ENGLISH = ""
        Exit Function
    End If

    Dim I0 As Integer
    For I0 = 1 To Len(STR_NUMBER)
        If (Asc(Mid(STR_NUMBER, I0, 1)) < 48) Or (Asc(Mid(STR_NUMBER, I0, 1)) > 57) Then
            NUMBERS_TO_WORDS_ENGLISH = "PLEASE ENTER NUMBER"
            Exit Function
        End If
    Next I0

    Dim ARRY_BODY(10) As String
    Dim ARRY_PREFIX(9) As String
    Dim ARRY_POSITION(101) As String

    ARRY_PREFIX(1) = " "
    ARRY_PREFIX(2) = " UN"
    ARRY_PREFIX(3) = " DUO"
    ARRY_PREFIX(4) = " TRE"
    ARRY_PREFIX(5) = " QUATTUOR"
    ARRY_PREFIX(6) = " QUIN"
    ARRY_PREFIX(7) = " SEX"
    ARRY_PREFIX(8) = " SEPTEN"
    ARRY_PREFIX(9) = " OCTO"
    ARRY_PREFIX(0) = " NOVEM"

    ARRY_BODY(1) = "DECILLION "
    ARRY_BODY(2) = "VIGINTILLION "
    ARRY_BODY(3) = "TRIGINTILLION "
    ARRY_BODY(4) = "QUADRAGINTILLION "
    ARRY_BODY(5) = "QUINQUAGINTILLION "
    ARRY_BODY(6) = "SEXUAGINTILLION "
    ARRY_BODY(7) = "SEPTUAGINTILLION "
    ARRY_BODY(8) = "OCTOGINTILLION "
    ARRY_BODY(9) = "NONAGINTILLION "
    ARRY_BODY(10) = "CENTILLION "

    ARRY_POSITION(0) = ""
    ARRY_POSITION(1) = " THOUSAND "
    ARRY_POSITION(2) = " MILLION "
    ARRY_POSITION(3) = " BILLION "
    ARRY_POSITION(4) = " TRILLION "
    ARRY_POSITION(5) = " QUADRILLION "
    ARRY_POSITION(6) = " QUINTILLION "
    ARRY_POSITION(7) = " SEXTILLION "
    ARRY_POSITION(8) = " SEPTILLION "
    ARRY_POSITION(9) = " OCTILLION "
    ARRY_POSITION(10) = " NONILLION "

    Dim I1 As Integer
    For I1 = 11 To 101
        If (I1 - 1) = (I1 \ 10) * 10 Then
            ARRY_POSITION(I1) = ARRY_PREFIX(I1 Mod 10) & ARRY_BODY(Int(I1 / 10))
        Else
            ARRY_POSITION(I1) = ARRY_PREFIX(I1 Mod 10) & LCase(ARRY_BODY(Int(I1 / 11)))
        End If
    Next I1

    STR_NUMBER = StrReverse(STR_NUMBER)

    Dim I2 As Integer
    Dim STR_TEMP As String
    Dim STR_CLUSTER As String
    Dim STR_TEMP_NUMBER As String
    Dim DONE As Boolean
    Dim STR_NUMBER_AS_TEXT As String

    I2 = 0
    DONE = False
    STR_NUMBER_AS_TEXT = ""

    Do While Not DONE
        STR_CLUSTER = StrReverse(Mid(STR_NUMBER, 1, 3))
        STR_TEMP_NUMBER = ""
        If (Len(STR_NUMBER) - 3) < 1 Then
            DONE = True
        Else
            STR_NUMBER = Mid(STR_NUMBER, 4)
        End If
        Do While Len(STR_CLUSTER) < 3
            STR_CLUSTER = "0" & STR_CLUSTER
        Loop
        STR_TEMP = NUMBERS_TO_WORDS_ENG(Val(Left(STR_CLUSTER, 1)))
        If Len(STR_TEMP) > 0 Then STR_TEMP_NUMBER = STR_TEMP & " HUNDRED "
        STR_TEMP = NUMBERS_TO_WORDS_ENG(Val(Mid(STR_CLUSTER, 2, 2)))
        If Len(STR_TEMP) = 0 Then
            STR_TEMP = NUMBERS_TO_WORDS_ENG(Val(Mid(STR_CLUSTER, 2, 1)) * 10)
            STR_TEMP_NUMBER = STR_TEMP_NUMBER & STR_TEMP
            STR_TEMP = NUMBERS_TO_WORDS_ENG(Val(Mid(STR_CLUSTER, 3, 1)))
            If Len(STR_TEMP) > 0 Then
                STR_TEMP_NUMBER = STR_TEMP_NUMBER & " " & STR_TEMP
            End If
        Else
            STR_TEMP_NUMBER = STR_TEMP_NUMBER & STR_TEMP
        End If
        If Len(STR_TEMP_NUMBER) + 0 Then STR_NUMBER_AS_TEXT = STR_TEMP_NUMBER & ARRY_POSITION(I2) & STR_NUMBER_AS_TEXT
        I2 = I2 + 1
    Loop

    NUMBERS_TO_WORDS_ENGLISH = STR_NUMBER_AS_TEXT
End Function

Private Function NUMBERS_TO_WORDS_ENG(NUMBER As Integer) As String
    Dim RESULT As String
    Select Case NUMBER
        Case 0: RESULT = ""
        Case 1: RESULT = "ONE"
        Case 2: RESULT = "TWO"
        Case 3: RESULT = "THREE"
        Case 4: RESULT = "FOUR"
        Case 5: RESULT = "FIVE"
        Case 6: RESULT = "SIX"
        Case 7: RESULT = "SEVEN"
        Case 8: RESULT = "EIGHT"
        Case 9: RESULT = "NINE"
        Case 10: RESULT = "TEN"
        Case 11: RESULT = "ELEVEN"
        Case 12: RESULT = "TWELVE"
        Case 13: RESULT = "THIRTEEN"
        Case 14: RESULT = "FOURTEEN"
        Case 15: RESULT = "FIFTEEN"
        Case 16: RESULT = "SIXTEEN"
        Case 17: RESULT = "SEVENTEEN"
        Case 18: RESULT = "EIGHTEEN"
        Case 19: RESULT = "NINETEEN"
        Case 20: RESULT = "TWENTY"
        Case 30: RESULT = "THIRTY"
        Case 40: RESULT = "FOURTY"
        Case 50: RESULT = "FIFTY"
        Case 60: RESULT = "SIXTY"
        Case 70: RESULT = "SEVENTY"
        Case 80: RESULT = "EIGHTY"
        Case 90: RESULT = "NINETY"
    End Select
    NUMBERS_TO_WORDS_ENG = RESULT
End Function
