/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.models;

import java.util.Date;
import java.util.List;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-20
 */
public class Team extends Base implements ITeam {

    private int id;
    private String name;
    private boolean isOnCall;
    private int empId1;
    private int empId2;
    private boolean isDeleted;
    private Date createdAt;
    private Date updatedAt;
    private Date deletedAt;

    public Team() {
        this.name = "";
        this.isOnCall = false;
        this.empId1 = 0;
        this.empId2 = 0;
    }

    public Team(String name, boolean isOnCall, int empId1, int empId2) {
        setName(name);
        setIsOnCall(isOnCall);
        setEmpId1(empId1);
        setEmpId2(empId2);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        if (name == null || name.isEmpty()) {
            addError(ErrorFactory.createInstance(1, "Team name is required"));
        } else {
            this.name = name;
        }
    }

    public boolean getIsOnCall() {
        return isOnCall;
    }

    public void setIsOnCall(boolean isOnCall) {
        this.isOnCall = isOnCall;
    }

    public int getEmpId1() {
        return empId1;
    }

    public void setEmpId1(int empId) {
        if (empId == 0) {
            addError(ErrorFactory.createInstance(2, "Team member 1 is required"));
        } else if (empId == getEmpId2()) {
            addError(ErrorFactory.createInstance(3, "A employee cannot be added twice across all teams"));
        } else {
            this.empId1 = empId;
        }
    }

    public int getEmpId2() {
        return empId2;
    }

    public void setEmpId2(int empId) {
        if (empId == 0) {
            addError(ErrorFactory.createInstance(4, "Team member 2 is required"));
        } else if (empId == getEmpId1()) {
            addError(ErrorFactory.createInstance(3, "A employee cannot be added twice across all teams"));
        } else {
            this.empId2 = empId;
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
}
