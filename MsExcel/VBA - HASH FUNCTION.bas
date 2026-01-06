
LỆNH EXCEL VBA -> HASH FUNCTION -> Version 1.1

    Option Explicit

    ''' TOOLS -> REFERENCES -> MICROSOFT XML, V6.0

    Public Function VMK_HASH_MD5(ByVal sIn As String, Optional ToBase64 As Boolean = 0) As String
        ''' TOOLS -> REFERENCES -> MICROSOFT XML, V6.0
        Dim oT As Object, oMD5 As Object, zBYTES() As Byte
        Set oT = CreateObject("System.Text.UTF8Encoding")
        Set oMD5 = CreateObject("System.Security.Cryptography.MD5CryptoServiceProvider")
            zBYTES = oT.Getbytes_4(sIn)
            zBYTES = oMD5.ComputeHash_2(zBYTES)
            If ToBase64 = True Then
            VMK_HASH_MD5 = CONVERT_TO_BASE64_STRING(zBYTES)
            Else
            VMK_HASH_MD5 = CONVERT_TO_HEX_STRING(zBYTES)
            End If
        Set oT = Nothing
        Set oMD5 = Nothing
    End Function

    Public Function VMK_HASH_SHA1(sIn As String, Optional ToBase64 As Boolean = 0) As String
        ''' TOOLS -> REFERENCES -> MICROSOFT XML, V6.0
        Dim oT As Object, oSHA1 As Object, zBYTES() As Byte
        Set oT = CreateObject("System.Text.UTF8Encoding")
        Set oSHA1 = CreateObject("System.Security.Cryptography.SHA1Managed")
            zBYTES = oT.Getbytes_4(sIn)
            zBYTES = oSHA1.ComputeHash_2(zBYTES)
            If ToBase64 = True Then
                VMK_HASH_SHA1 = CONVERT_TO_BASE64_STRING(zBYTES)
            Else
                VMK_HASH_SHA1 = CONVERT_TO_HEX_STRING(zBYTES)
            End If
        Set oT = Nothing
        Set oSHA1 = Nothing
    End Function

    Public Function VMK_HASH_SHA256(sIn As String, Optional ToBase64 As Boolean = 0) As String
        ''' TOOLS -> REFERENCES -> MICROSOFT XML, V6.0
        Dim oT As Object, oSHA256 As Object, zBYTES() As Byte
        Set oT = CreateObject("System.Text.UTF8Encoding")
        Set oSHA256 = CreateObject("System.Security.Cryptography.SHA256Managed")
            zBYTES = oT.Getbytes_4(sIn)
            zBYTES = oSHA256.ComputeHash_2(zBYTES)
            If ToBase64 = True Then
                VMK_HASH_SHA256 = CONVERT_TO_BASE64_STRING(zBYTES)
            Else
                VMK_HASH_SHA256 = CONVERT_TO_HEX_STRING(zBYTES)
            End If
        Set oT = Nothing
        Set oSHA256 = Nothing
    End Function

    Public Function VMK_HASH_SHA384(sIn As String, Optional ToBase64 As Boolean = 0) As String
        ''' TOOLS -> REFERENCES -> MICROSOFT XML, V6.0
        Dim oT As Object, oSHA384 As Object, zBYTES() As Byte
        Set oT = CreateObject("System.Text.UTF8Encoding")
        Set oSHA384 = CreateObject("System.Security.Cryptography.SHA384Managed")
            zBYTES = oT.Getbytes_4(sIn)
            zBYTES = oSHA384.ComputeHash_2(zBYTES)
            If ToBase64 = True Then
                VMK_HASH_SHA384 = CONVERT_TO_BASE64_STRING(zBYTES)
            Else
                VMK_HASH_SHA384 = CONVERT_TO_HEX_STRING(zBYTES)
            End If
        Set oT = Nothing
        Set oSHA384 = Nothing
    End Function

    Public Function VMK_HASH_SHA512(sIn As String, Optional ToBase64 As Boolean = 0) As String
        ''' TOOLS -> REFERENCES -> MICROSOFT XML, V6.0
        Dim oT As Object, oSHA512 As Object, zBYTES() As Byte
        Set oT = CreateObject("System.Text.UTF8Encoding")
        Set oSHA512 = CreateObject("System.Security.Cryptography.SHA512Managed")
            zBYTES = oT.Getbytes_4(sIn)
            zBYTES = oSHA512.ComputeHash_2(zBYTES)
            If ToBase64 = True Then
                VMK_HASH_SHA512 = CONVERT_TO_BASE64_STRING(zBYTES)
            Else
                VMK_HASH_SHA512 = CONVERT_TO_HEX_STRING(zBYTES)
            End If
        Set oT = Nothing
        Set oSHA512 = Nothing
    End Function

    Public Function VMK_HASH_SHA512_WITH_SALT(ByVal sIn As String, ByVal sSecKey As String, Optional ByVal ToBase64 As Boolean = False) As String
        ''' TOOLS -> REFERENCES -> MICROSOFT XML, V6.0
        Dim oT As Object, oSHA512SALT As Object, zBYTES() As Byte
        Set oT = CreateObject("System.Text.UTF8Encoding")
        Set oSHA512SALT = CreateObject("System.Security.Cryptography.HMACSHA512")
            zBYTES = oT.Getbytes_4(sIn)
            oSHA512SALT.Key = oT.Getbytes_4(sSecKey)
            zBYTES = oSHA512SALT.ComputeHash_2(zBYTES)
            If ToBase64 = True Then
                VMK_HASH_SHA512_WITH_SALT = CONVERT_TO_BASE64_STRING(zBYTES)
            Else
                VMK_HASH_SHA512_WITH_SALT = CONVERT_TO_HEX_STRING(zBYTES)
            End If
        Set oT = Nothing
        Set oSHA512SALT = Nothing
    End Function

    Private Function CONVERT_TO_BASE64_STRING(vIn As Variant) As Variant
        ''' TOOLS -> REFERENCES -> MICROSOFT XML, V6.0
        Dim oD As Object
        Set oD = CreateObject("MSXML2.DOMDocument.6.0")
            With oD
                .LoadXML "<root />"
                .DocumentElement.DataType = "bin.base64"
                .DocumentElement.nodeTypedValue = vIn
            End With
        CONVERT_TO_BASE64_STRING = Replace(oD.DocumentElement.Text, vbLf, "")
        Set oD = Nothing
    End Function

    Private Function CONVERT_TO_HEX_STRING(vIn As Variant) As Variant
        ''' TOOLS -> REFERENCES -> MICROSOFT XML, V6.0
        Dim oD As Object
        Set oD = CreateObject("MSXML2.DOMDocument.6.0")
            With oD
                .LoadXML "<root />"
                .DocumentElement.DataType = "bin.Hex"
                .DocumentElement.nodeTypedValue = vIn
            End With
        CONVERT_TO_HEX_STRING = Replace(oD.DocumentElement.Text, vbLf, "")
        Set oD = Nothing
    End Function
