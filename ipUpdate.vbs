' MyDNS �� �[���Ɋ���U��ꂽIP��ʒm����
' �v���C�x�[�g��LAN����DDNS�ɂ�閼�O�������������邱�Ƃ��ړI

Const MYDNS_ID = "mydnsXXXXXXXXXX"
Const MYDNS_PWD = "XXXXXXXXXXXXXXXX"

Dim oClassSet
Dim oClass
Dim oLocator
Dim oService
Dim ipAddress

'���[�J���R���s���[�^�ɐڑ�����B
Set oLocator = WScript.CreateObject("WbemScripting.SWbemLocator")
Set oService = oLocator.ConnectServer
'�N�G���[������WQL�ɂĎw�肷��B
Set oClassSet = oService.ExecQuery("Select * From Win32_NetworkAdapterConfiguration")

'�R���N�V��������͂���B
For Each oClass In oClassSet
	' 192.168.56.1 �͉��z�l�b�g���[�N�A�_�v�^�[
	If oClass.IPEnabled = True Then
		If oClass.IPAddress(0) <> "192.168.56.1" then
			ipAddress = oClass.IPAddress(0)
		End If
	End If
Next


Dim oXMLHTTP   ' MSXML�I�u�W�F�N�g
Dim oStream    ' ADODB.Stream�I�u�W�F�N�g
Dim resData    ' ���X�|���X

Set oXMLHTTP = CreateObject("MSXML2.XMLHTTP.3.0")
oXMLHTTP.Open "GET", "http://www.mydns.jp/directip.html?MID=" & MYDNS_MID & "&PWD=" & MYDNS_PWD & "&IPV4ADDR=" & ipAddress, False
oXMLHTTP.Send

