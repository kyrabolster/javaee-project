/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.models;

import java.sql.Timestamp;
import java.time.LocalDateTime;
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
    
    Timestamp getStart();
    
    void setStart(Timestamp Start);
    
    Timestamp getEnd();
    
    void setEnd(Timestamp End);
    
    List<String> getTasks();

    void setTasks(List<String> tasks);
    
    boolean getIsOnSite();
    
    void setIsOnSite(boolean isOnSite);
    
    int getTotalDuration();
    
    void setTotalDuration(int totalDuration);
    
    String getSelectedTasks();
    
    void setSelectedTasks(String selectedTasks);
    
}
