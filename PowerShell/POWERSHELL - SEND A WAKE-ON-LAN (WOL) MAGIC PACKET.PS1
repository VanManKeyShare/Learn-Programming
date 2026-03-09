
# POWERSHELL - SEND A WAKE-ON-LAN (WOL) MAGIC PACKET

# ĐỊA CHỈ MAC CỦA MÁY CẦN BẬT
$MAC = "90:09:D0:85:21:97"

# CHUYỂN ĐỔI MAC SANG BYTE ARRAY
$MACBYTES = ($MAC -split '[-:]') | ForEach-Object { [byte]('0x' + $_) }

# TẠO "MAGIC PACKET" (6 BYTES FF + MAC LẶP LẠI 16 LẦN)
$PACKET = (,[byte]0xFF * 6) + ($MACBYTES * 16)

# GỬI GÓI WOL QUA UDP BROADCAST PORT 9
$UDPCLIENT = New-Object System.Net.Sockets.UdpClient
$UDPCLIENT.Connect(([System.Net.IPAddress]::Broadcast), 9)
$UDPCLIENT.Send($PACKET, $PACKET.Length)
$UDPCLIENT.Close()

Write-Host "ĐÃ GỬI WOL ĐẾN $MAC"

Start-Sleep -Seconds 3
