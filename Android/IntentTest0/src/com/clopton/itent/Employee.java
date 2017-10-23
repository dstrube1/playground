package com.clopton.itent;

import java.io.Serializable;

import android.os.Parcel;
import android.os.Parcelable;

public class Employee implements Serializable {
	
	private String empName;
	private String empEmail;
	private String empPhone;
	
	public Employee(String name, String mail, String phone){
		
		empName = name;
		empEmail = mail;
		empPhone = phone;
	}
	
	public String getName(){
		
		return empName;
	}
	
	public void setName(String name){
	
		empName = name;
	}
	
	public String getMail(){
		return empEmail;
	}
	public void setMail(String mail){
		empEmail = mail;
	}
	public String getPhone(){
		return empPhone;
	}
	public void setPhone(String phone){
		empPhone = phone;
	}

	
}

