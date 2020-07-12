<%@ page import="java.util.Properties" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%!
public static class SMTPAuthenticator extends Authenticator {
	public PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("******","******");
	}
}
%>
<%
if(request.getParameter("email") != null) {
	//validate the email
	Properties props = new Properties();
	props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	SMTPAuthenticator auth = new SMTPAuthenticator();
	Session sess = Session.getInstance(props,auth);
	MimeMessage msg=new MimeMessage(sess);
	msg.setContent("Thank you for registering please click to activate <a href=''>click</a>","text/html");
	msg.setSubject("Book store account");
	msg.setFrom(new InternetAddress("bookstore@fake.com"));
	msg.addRecipient(Message.RecipientType.TO,new InternetAddress(request.getParameter("email")));
	try {
		Transport trans= sess.getTransport("smtp");
		trans.connect("smtp.gmail.com",465,"******","*****");
		trans.sendMessage(msg,msg.getAllRecipients());
		trans.close();
		%>
		Email was sent!
		<%
	} catch(Exception e) {
		
		
        out.println("Result: " + e.getMessage() + "\n");
     
	}
	
	%>
	sending ...
	<%
}
%>

<form action="">
Enter your email
<br />
<input type="text" name="email" />
<br />
<input type="submit" value="register" />
</form>

</body>
</html>