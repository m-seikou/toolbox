' MyDNS に 端末に割り振られたIPを通知する
' プライベートなLAN内でDDNSによる名前解決を実現することが目的

Const MYDNS_ID = "mydnsXXXXXXXXXX"
Const MYDNS_PWD = "XXXXXXXXXXXXXXXX"

Dim oClassSet
Dim oClass
Dim oLocator
Dim oService
Dim ipAddress

'ローカルコンピュータに接続する。
Set oLocator = WScript.CreateObject("WbemScripting.SWbemLocator")
Set oService = oLocator.ConnectServer
'クエリー条件をWQLにて指定する。
Set oClassSet = oService.ExecQuery("Select * From Win32_NetworkAdapterConfiguration")

'コレクションを解析する。
For Each oClass In oClassSet
	' 192.168.56.1 は仮想ネットワークアダプター
	If oClass.IPEnabled = True Then
		If oClass.IPAddress(0) <> "192.168.56.1" then
			ipAddress = oClass.IPAddress(0)
		End If
	End If
Next


Dim oXMLHTTP   ' MSXMLオブジェクト
Dim oStream    ' ADODB.Streamオブジェクト
Dim resData    ' レスポンス

Set oXMLHTTP = CreateObject("MSXML2.XMLHTTP.3.0")
oXMLHTTP.Open "GET", "http://www.mydns.jp/directip.html?MID=" & MYDNS_MID & "&PWD=" & MYDNS_PWD & "&IPV4ADDR=" & ipAddress, False
oXMLHTTP.Send

