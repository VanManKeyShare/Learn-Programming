
''' LỆNH EXCEL VBA -> BASE64 ENCODE + DECODE -> SUPPORT UTF8 + UTF16

    Option Explicit

    Public Function VMK_BASE64_ENCODE(ByVal sTEXT, Optional ByVal UTF_16_LE As Boolean = False) As String
        ''' USE AN AUX. XML DOCUMENT WITH A BASE64-ENCODED ELEMENT.
        ''' ASSIGNING THE BYTE STREAM (ARRAY) RETURNED BY STRTOBYTES() TO .NODETYPEDVALUE
        ''' AUTOMATICALLY PERFORMS BASE64-ENCODING, WHOSE RESULT CAN THEN BE ACCESSED AS THE ELEMENT'S TEXT.

        With CreateObject("Msxml2.DOMDocument").CreateElement("aux")
            .DataType = "bin.base64"
            If UTF_16_LE = True Then
                .NodeTypedValue = STRING_TO_BYTES(sTEXT, "utf-16le", 2)
            Else
                .NodeTypedValue = STRING_TO_BYTES(sTEXT, "utf-8", 3)
            End If
            VMK_BASE64_ENCODE = .Text
        End With

    End Function

    ''' DECODES THE SPECIFIED BASE64-ENCODED STRING.
    ''' IF THE DECODED STRING'S ORIGINAL ENCODING WAS:
    '''   + UTF-8, PASS FALSE FOR FISUTF16LE.
    '''   + UTF-16 LE, PASS TRUE FOR FISUTF16LE.

    Public Function VMK_BASE64_DECODE(ByVal sBASE64_ENCODED_TEXT, Optional ByVal UTF_16_LE As Boolean = False) As String

        Dim sTEXT_ENCODING As String: sTEXT_ENCODING = "utf-8"
        If UTF_16_LE = True Then sTEXT_ENCODING = "utf-16le"

        ''' USE AN AUX. XML DOCUMENT WITH A BASE64-ENCODED ELEMENT.
        ''' ASSIGNING THE ENCODED TEXT TO .TEXT MAKES THE DECODED BYTE ARRAY
        ''' AVAILABLE VIA .NODETYPEDVALUE, WHICH WE CAN PASS TO BYTESTOSTR()

        With CreateObject("Msxml2.DOMDocument").CreateElement("aux")
            .DataType = "bin.base64"
            .Text = sBASE64_ENCODED_TEXT
            VMK_BASE64_DECODE = BYTES_TO_STRING(.NodeTypedValue, sTEXT_ENCODING)
        End With

    End Function

    ''' RETURNS A BINARY REPRESENTATION (BYTE ARRAY) OF THE SPECIFIED STRING IN
    ''' THE SPECIFIED TEXT ENCODING, SUCH AS "UTF-8" OR "UTF-16LE".
    ''' PASS THE NUMBER OF BYTES THAT THE ENCODING'S BOM USES AS IBOMBYTECOUNT;
    ''' PASS 0 TO INCLUDE THE BOM IN THE OUTPUT.

    Private Function STRING_TO_BYTES(ByVal sTEXT, ByVal sTEXT_ENCODING, ByVal IBOM_BYTE_COUNT)
        With CreateObject("ADODB.Stream")
            .Type = 2  ''' ADTYPETEXT
            .Charset = sTEXT_ENCODING
            .Open
            .WriteText sTEXT
            .Position = 0
            .Type = 1  ''' ADTYPEBINARY
            .Position = IBOM_BYTE_COUNT ''' SKIP THE BOM
            STRING_TO_BYTES = .Read
            .Close
        End With
    End Function

    ''' RETURNS A STRING THAT CORRESPONDS TO THE SPECIFIED BYTE ARRAY, INTERPRETED
    ''' WITH THE SPECIFIED TEXT ENCODING, SUCH AS "UTF-8" OR "UTF-16LE"

    Private Function BYTES_TO_STRING(ByVal BYTE_ARRAY, ByVal sTEXT_ENCODING)

        ''' UTF-16 LE HAPPENS TO BE VBSCRIPT'S INTERNAL ENCODING, SO WE CAN
        ''' TAKE A SHORTCUT AND USE CSTR() TO DIRECTLY CONVERT THE BYTE ARRAY TO A STRING

        If LCase(sTEXT_ENCODING) = "utf-16le" Then
            BYTES_TO_STRING = CStr(BYTE_ARRAY)
        Else
            With CreateObject("ADODB.Stream")
                .Type = 1 ''' ADTYPEBINARY
                .Open
                .Write BYTE_ARRAY
                .Position = 0
                .Type = 2 ''' ADTYPETEXT
                .Charset = sTEXT_ENCODING
                BYTES_TO_STRING = .ReadText
                .Close
            End With
        End If
    End Function
