package kr.or.ddit.travelmaker.utils;

import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class MailUtils {
	public static int sendMail(Map<String, Object> map) {
		int res = 0;
		
		Properties properties = System.getProperties();
        Properties props = new Properties();
        String from = "";
        String host = "";
        if("@naver.com".equals(map.get("domain").toString())) {
        	from = "@naver.com";
            host = "smtp.naver.com";
            properties.setProperty("mail.smtp.host", host);
            props.put("mail.smtp.host", "smtp.naver.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.trust", "smtp.naver.com");
        } else if("@gmail.com".equals(map.get("domain").toString())) {
        	from = "@gmail.com";
            host = "smtp.gmail.com";
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
        } else if("@daum.net".equals(map.get("domain").toString())) {
        	from = "@daum.net";
            host = "smtp.daum.net";
            props.put("mail.smtp.host", host);
            props.put("mail.smtp.port", "465");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.ssl.enable", "true");
        } else {
            throw new IllegalArgumentException("Invalid email");
        }

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                if("@naver.com".equals(map.get("domain").toString())) {
                    return new PasswordAuthentication("", "");
                } else if("@gmail.com".equals(map.get("domain").toString())) {
                    return new PasswordAuthentication("", "");
                } else if("@daum.net".equals(map.get("domain").toString())) {
                    return new PasswordAuthentication("", "");
                } else {
                    return new PasswordAuthentication("", "");
                }
            }
        });
        
        String toAddr = map.get("memEmail").toString();
        
        try {
            
            MimeMultipart multipart = new MimeMultipart();
             
            MimeBodyPart messageBodyPart = new MimeBodyPart();
            String html = "<html><body> "
                    + "<p style=\'font-size: 1.5em; font-weight: bold;\'>"
                    + "다음 버튼을 클릭하여 새 비밀번호를 설정해주세요. <br>"
                    + "<a href='http://localhost/updatePassword?memNo=" + map.get("memNo").toString() + "'>비밀번호 재설정하러 가기</a>";
            messageBodyPart.setContent(html, "text/html; charset=UTF-8");
             
            multipart.addBodyPart(messageBodyPart);
             
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toAddr));
            message.setSubject("[Travel Maker] 새 비밀번호 설정");
            message.setContent(multipart);

            Transport.send(message);
            
            res = 1;
        } catch (Exception e) {
        	e.printStackTrace();
        }
        return res;
	}
}
