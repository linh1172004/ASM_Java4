package com.poly.utils;

import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class SendMailUtils {

    // THAY THẾ BẰNG EMAIL VÀ APP PASSWORD CỦA BẠN
    private static final String SENDER_EMAIL = "your_email@gmail.com";
    private static final String SENDER_PASSWORD = "your_app_password";

    public static void send(String recipient, String subject, String content) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        };

        Session session = Session.getInstance(props, auth);
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL, "OE Cinema Support"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject(subject);
            message.setText(content);
            Transport.send(message);
            System.out.println("Email sent successfully to: " + recipient);
        } catch (Exception e) {
            System.err.println("Failed to send email to " + recipient + ". Error: " + e.getMessage());
        }
    }
}