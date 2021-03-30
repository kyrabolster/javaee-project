/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.models;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-30
 */
public class Job extends Base implements IJob{
    private int id;
    private int teamId;
    private String description;
    private String clientName;
    private Date start;
    private Date end;
    private List<String> tasks;

    public Job() {
        this.teamId = 0;
        this.description = "";
        this.clientName = "";
        this.start = new Date();
        this.end = new Date();
        this.tasks = new ArrayList<>();
    }

    public Job(int teamId, String description, String clientName, Date start, List<String> tasks) {
        this.teamId = teamId;
        this.description = description;
        this.clientName = clientName;
        this.start = start;
        this.tasks = tasks;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTeamId() {
        return teamId;
    }

    public void setTeamId(int teamId) {
        this.teamId = teamId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getClientName() {
        return clientName;
    }

    public void setClientName(String clientName) {
        this.clientName = clientName;
    }

    public Date getStart() {
        return start;
    }

    public void setStart(Date start) {
        this.start = start;
    }

    public Date getEnd() {
        return end;
    }

    public void setEnd(Date end) {
        this.end = end;
    }

    public List<String> getTasks() {
        return tasks;
    }

    public void setTasks(List<String> tasks) {
        this.tasks = tasks;
    }
    
    
}
