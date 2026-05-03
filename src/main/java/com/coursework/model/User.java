package com.coursework.model;

public class User {

    private int userId;
    private String name;
    private String email;
    private String password;
    private String phone;
    private String licenseNumber;
    private String role;
    private String accountStatus;

    // Getters and Setters

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }
    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }

    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
    }
    
    public String getAccountStatus() {
    	return accountStatus;
    }
    public void setAccountStatus(String accountStatus) {
    	this.accountStatus = accountStatus;
    }
    
}