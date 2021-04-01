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
 * @date 2021-03-30
 */
public interface IJob extends IBase{
    int getId();
    
    void setId(int id);
    
    int getTeamId();
    
    void setTeamId(int teamId);
    
    String getDescription();
    
    void setDescription(String description);
    
    String getClientName();
    
    void setClientName(String clientName);
    
    Date getStart();
    
    void setStart(Date Start);
    
    Date getEnd();
    
    void setEnd(Date End);
    
    List<String> getTasks();

    void setTasks(List<String> tasks);
}
