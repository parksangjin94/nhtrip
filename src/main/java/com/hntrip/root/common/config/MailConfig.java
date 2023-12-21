package com.hntrip.root.common.config;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
public class MailConfig {
	@Bean
    public static JavaMailSender mailSender() {
	   JavaMailSenderImpl jms = new JavaMailSenderImpl();
	   jms.setHost("smtp.gmail.com");
	   jms.setPort(587);
	   jms.setUsername("hntrip.diary@gmail.com");
	   jms.setPassword("oracle12!");
		// 보내는 사람의 메일주소가 된다.
	   Properties prop = new Properties();
	   prop.setProperty("mail.transport.protocol", "smtp");
	   prop.setProperty("mail.smtp.auth", "true"); 
	   prop.setProperty("mail.smtp.starttls.enable", "true");
	   prop.setProperty("mail.debug", "true");
	   jms.setJavaMailProperties(prop);
	
	   return jms;
    	}
}
