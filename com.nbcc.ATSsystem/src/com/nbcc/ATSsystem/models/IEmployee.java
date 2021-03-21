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
 * @author KyraB
 */
public interface IEmployee extends IBase {

    int getId();

    void setId(int id);

    String getFirstName();

    void setFirstName(String firstName);

    String getLastName();

    void setLastName(String lastName);

    String getSIN();

    void setSIN(String SIN);

    double getHourlyRate();

    void setHourlyRate(double hourlyRate);

    boolean getIsDeleted();

    void setIsDeleted(boolean isDeleted);

    Date getCreatedAt();

    void setCreatedAt(Date createdAt);

    Date getUpdatedAt();

    void setUpdatedAt(Date updatedAt);

    Date getDeletedAt();

    void setDeletedAt(Date deletedAt);

    List<String> getTasks();

    void setTasks(List<String> tasks);
    
    List<String> getTeams();

    void setTeams(List<String> teams);
}
