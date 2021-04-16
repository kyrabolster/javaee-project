/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.models;

import java.util.Date;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-20
 */
public interface ITeam extends IBase{
    int getId();
    
    void setId(int id);
    
    String getName();
    
    void setName(String name);
    
    boolean getIsOnCall();
    
    void setIsOnCall(boolean isOnCall);
    
    int getEmpId1();
    
    void setEmpId1(int empId);
    
    int getEmpId2();
    
    void setEmpId2(int empId);
    
    boolean getIsDeleted();
    
    void setIsDeleted(boolean isDeleted);
    
    Date getCreatedAt();

    void setCreatedAt(Date createdAt);

    Date getUpdatedAt();

    void setUpdatedAt(Date updatedAt);

    Date getDeletedAt();

    void setDeletedAt(Date deletedAt);
    
    String getMembers();
    
    void setMembers(String names);
    
}
