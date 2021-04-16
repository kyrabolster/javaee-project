/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.models;

import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author KyraB
 */
public class Employee extends Base implements IEmployee {

    private int id;
    private String firstName;
    private String lastName;
    private String SIN;
    private double hourlyRate;
    private boolean isDeleted;
    private Date createdAt;
    private Date updatedAt;
    private Date deletedAt;
    private List<ITask> tasks;
    private List<String> teams;


    public Employee() {
        this.firstName = "";
        this.lastName = "";
        this.SIN = "";
        this.hourlyRate = 0.0;
    }

    public Employee(String firstName, String lastName, String SIN, double hourlyRate) {
        setFirstName(firstName);
        setLastName(lastName);
        setSIN(SIN);
        setHourlyRate(hourlyRate);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        if (firstName == null || firstName.isEmpty()) {
            addError(ErrorFactory.createInstance(1, "First name is required"));
        } else {
            this.firstName = firstName;
        }
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        if (lastName == null || lastName.isEmpty()) {
            addError(ErrorFactory.createInstance(2, "Last name is required"));
        } else {
            this.lastName = lastName;
        }
    }

    public String getSIN() {
        return SIN;
    }

    public void setSIN(String SIN) {
        if (SIN == null) {
            addError(ErrorFactory.createInstance(3, "SIN must be greater than 0"));
        } else {
            Pattern pattern = Pattern.compile("^\\d{3}-?\\d{3}-?\\d{3}$");
            Matcher matcher = pattern.matcher((CharSequence) SIN);

            if (!matcher.matches()) {
                addError(ErrorFactory.createInstance(4, "SIN must be in valid Canadian format"));
            } else {
                this.SIN = SIN;
            }
        }
    }

    public double getHourlyRate() {
        return hourlyRate;
    }

    public void setHourlyRate(double hourlyRate) {
        if (hourlyRate <= 0) {
            addError(ErrorFactory.createInstance(4, "Hourly rate must be greater than 0"));
        } else {
            this.hourlyRate = hourlyRate;
        }
    }

    public boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Date getDeletedAt() {
        return deletedAt;
    }

    public void setDeletedAt(Date deletedAt) {
        this.deletedAt = deletedAt;
    }
    
    public List<ITask> getTasks() {
        return tasks;
    }
    
    public void setTasks(List<ITask> tasks) {
        this.tasks = tasks;
    }
    
    public List<String> getTeams() {
        return teams;
    }
    
    public void setTeams(List<String> teams) {
        this.teams = teams;
    }
}
