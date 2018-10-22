package com.dstrube.intenttest;

import java.io.Serializable;

public class Employee implements Serializable {

    private String empName;
    private String empEmail;
    private String empPhone;

    public Employee() {
        setName("");
        setEmail("");
        setPhone("");
    }

    Employee(String name, String email, String phone) {

        setName(name);
        setEmail(email);
        setPhone(phone);
    }

    public String getName() {

        return empName;
    }

    public void setName(String name) {

        empName = name;
    }

    /*package*/ String getMail() {
        return empEmail;
    }

    private void setEmail(String mail) {
        empEmail = mail;
    }

    /*package*/ String getPhone() {
        return empPhone;
    }

    private void setPhone(String phone) {
        empPhone = phone;
    }


}

