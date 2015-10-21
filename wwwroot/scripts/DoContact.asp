<!--#include file="../../Connections/MyConn.asp" -->

<% 
	TheHostHeader = request.ServerVariables("HTTP_HOST")
	Dim MyRS
	Dim MyRS_numRows

	Set DC = server.CreateObject("adodb.connection")
	dc.open MM_MyConn_STRING
	Set MyRS = Server.CreateObject("ADODB.Recordset")
	MyRS.ActiveConnection = DC
	MySQL = "SELECT * FROM UserDomains where FQDN= '" & TheHostHeader & "'"
	'response.write Mysql
	MyRS.CursorType = 0
	MyRS.CursorLocation = 2
	MyRS.LockType = 1
	MyRS.Open MySQL,DC

	If not MyRS.EOF then
		TheAccountID = MyRS("VOAccountID")
		TheAccountID = replace(TheAccountID,"{","")
		TheAccountID = replace(TheAccountID,"}","")
		MyRS.Close
		set MyRS = nothing
		dc.close
		set dc = nothing
	end if

	Set DC = server.CreateObject("adodb.connection")
	dc.open MM_MyConn_STRING
	Set MyRS = Server.CreateObject("ADODB.Recordset")
	MyRS.ActiveConnection = DC
	MySQL = "SELECT * FROM UserAccounts where VOAccountID= '" & TheAccountID & "'"
	'response.write Mysql
	MyRS.CursorType = 0
	MyRS.CursorLocation = 2
	MyRS.LockType = 1
	MyRS.Open MySQL,DC
	if not MyRS.EOF then
		TheUID = MyRS("UserID") 
		TheUID = replace(TheUID,"{","")
		TheUID = replace(TheUID,"}","")
	end if
	
	MyRS.Close
	set MyRS = nothing
	dc.close
	set dc = nothing

	Set DC = server.CreateObject("adodb.connection")
	dc.open MM_MyConn_STRING
	Set MyRS = Server.CreateObject("ADODB.Recordset")
	MyRS.ActiveConnection = DC
	MySQL = "SELECT * FROM UserLogins where UserAccountID= '" & TheUID & "'"
	'response.write Mysql
	MyRS.CursorType = 0
	MyRS.CursorLocation = 2
	MyRS.LockType = 1
	MyRS.Open MySQL,DC
	if not MyRS.EOF then
		TheEmail = myrs("emailAddress") 
	end if
	
	MyRS.Close
	set MyRS = nothing
	dc.close
	set dc = nothing
	'response.write TheEmail



myMsg = ""
	For Each Item In Request.form
  	    fieldName = Item
    	fieldValue = Request.form(Item)

    	myMsg = myMsg & fieldName & " = " & fieldValue & vbcrlf
    Next

Set myMail=CreateObject("CDO.Message")
myMail.Subject="Message from your website: " & now() 
myMail.From="no-reply@getbuild.today"
myMail.To= TheEmail
myMail.TextBody= myMsg

myMail.Configuration.Fields.Item _
("http://schemas.microsoft.com/cdo/configuration/sendusing")= 2
'Name or IP of remote SMTP server
myMail.Configuration.Fields.Item _
("http://schemas.microsoft.com/cdo/configuration/smtpserver")="oxmail.registrar-servers.com"
'Server port
myMail.Configuration.Fields.Item _
("http://schemas.microsoft.com/cdo/configuration/smtpserverport")= 25
myMail.Configuration.Fields.Item _
("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
myMail.Configuration.Fields.Item _
("http://schemas.microsoft.com/cdo/configuration/sendusername")= "no-reply@getbuild.today"
myMail.Configuration.Fields.Item _
("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "noreply321"
myMail.Configuration.Fields.Update

myMail.Send
set myMail=nothing

MyUrl = Request.ServerVariables("HTTP_REFERER")  
response.redirect(myUrl & "&BuildMessage=MSGSENT")  %>