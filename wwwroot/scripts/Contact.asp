<% 
	TheHostHeader = request.ServerVariables("HTTP_HOST")

myMsg = ""

	For Each Item In Request.form
  	    fieldName = Item
    	fieldValue = Request.form(Item)
    	myMsg = myMsg & fieldName & " = " & fieldValue & vbcrlf
    Next

'TheEmail = "tedxpretoria@gmail.com"
TheEmail = "quintin.schnehage@gmail.com"

Set myMail=CreateObject("CDO.Message")

myMail.Subject	=	"Message from your website: " & now() 
myMail.From 	=	"no-reply@getbuild.today"
myMail.To 		= 	TheEmail
myMail.TextBody = 	myMsg

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
("http://schemas.microsoft.com/cdo/configuration/sendusername")= "no-reply@tedxpretoria.co.za"
myMail.Configuration.Fields.Item _
("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "noreply321"
myMail.Configuration.Fields.Update

myMail.Send
set myMail=nothing

Response.ContentType = "application/json"
Response.Write("{ ""ResponseStatus"": ""success""}")

'MyUrl = Request.ServerVariables("HTTP_REFERER")  
'response.write(myUrl & "&BuildMessage=MSGSENT")  
%>