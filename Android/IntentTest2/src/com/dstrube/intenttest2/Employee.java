package com.dstrube.intenttest2;

import java.io.Serializable;

@SuppressWarnings("serial")
public class Employee implements Serializable {
	private String name;
	private String emailAddress;
	private String phoneNumber;
	
	public Employee() {
		name = "";
		emailAddress = "";
		phoneNumber = "";
	};

	public Employee(String name, String emailAddress, String phoneNumber) {
		setName(name);
		setEmailAddress(emailAddress);
		setPhoneNumber(phoneNumber);
	}

	public String getName() {
		return name;
	}

	public String getEmailAddress() {
		return emailAddress;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setEmailAddress(String emailAddress) {
		this.emailAddress = emailAddress;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

}
