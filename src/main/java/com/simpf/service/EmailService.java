package com.simpf.service;

import com.simpf.dto.EmailDTO;

public interface EmailService {

	public void sendMail(EmailDTO dto, String message);
}
