/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.models;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-30
 */
public class Job extends Base implements IJob {

    private int id;
    private int teamId;
    private String teamName;
    private String clientName;
    private String description;
    private Timestamp start;
    private Timestamp end;
    private double cost;
    private double revenue;
    private String tasksName;

    private List<String> tasks;
    private boolean isOnSite;
    private int totalDuration;
    private String selectedTasks;

    public Job() {
        this.teamId = 0;
        this.description = "";
        this.clientName = "";
        this.start = new Timestamp(System.currentTimeMillis());
        this.end = new Timestamp(System.currentTimeMillis());
        this.tasks = new ArrayList<>();
    }

    public Job(String clientName, String description, Timestamp start, List<String> tasks, boolean isOnSite) {
        setClientName(clientName);
        setDescription(description);
        setStart(start);
        setTasks(tasks);
        setIsOnSite(isOnSite);
    }

    public Job(int teamId, String clientName, String description, Timestamp start, List<String> tasks) {
        setTeamId(teamId);
        setClientName(clientName);
        setDescription(description);
        setStart(start);
        setTasks(tasks);
    }

    public Job(int teamId, String clientName, String description, Timestamp start, List<String> tasks, boolean isOnSite, int totalDuration, String selectedTasks) {
        setTeamId(teamId);
        setClientName(clientName);
        setDescription(description);
        setStart(start);
        setTasks(tasks);
        setIsOnSite(isOnSite);
        setTotalDuration(totalDuration);
        setSelectedTasks(selectedTasks);
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
        if (teamId < 0) {
            addError(ErrorFactory.createInstance(6, "You should select a team"));
        } else {
            this.teamId = teamId;
        }
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public String getClientName() {
        return clientName;
    }

    public void setClientName(String clientName) {
        if ("".equals(clientName) || clientName == null) {
            addError(ErrorFactory.createInstance(1, "Client Name is required"));
        } else {
            this.clientName = clientName;
        }
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        if ("".equals(description) || description == null) {
            addError(ErrorFactory.createInstance(2, "Job description is required"));
        } else {
            this.description = description;
        }
    }

    public Timestamp getStart() {
        return start;
    }

    public void setStart(Timestamp start) {
        Timestamp current = new Timestamp(System.currentTimeMillis());

        if(getId() > 0){
            this.start = start;
        } else {
            if (start == null) {
                addError(ErrorFactory.createInstance(3, "Start date is required"));
            } else if (start.compareTo(current) < 0) {
                addError(ErrorFactory.createInstance(7, "Start date can not be past"));
            } else {
                this.start = start;
            }            
        }
    }

    public Timestamp getEnd() {
        return end;
    }

    public void setEnd(Timestamp end) {
        this.end = end;
    }

    public List<String> getTasks() {
        return tasks;
    }

    public void setTasks(List<String> tasks) {
        if (tasks.isEmpty()) {
            addError(ErrorFactory.createInstance(5, "At least one task is required"));
        } else {
            this.tasks = tasks;
        }
    }

    public boolean getIsOnSite() {
        return isOnSite;
    }

    public void setIsOnSite(boolean isOnSite) {
        this.isOnSite = isOnSite;
    }

    @Override
    public int getTotalDuration() {
        return totalDuration;
    }

    @Override
    public void setTotalDuration(int totalDuration) {
        this.totalDuration = totalDuration;
    }

    @Override
    public String getSelectedTasks() {
        return selectedTasks;
    }

    @Override
    public void setSelectedTasks(String selectedTasks) {
        this.selectedTasks = selectedTasks;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public double getRevenue() {
        return revenue;
    }

    public void setRevenue(double revenue) {
        this.revenue = revenue;
    }

    public String getTasksName() {
        return tasksName;
    }

    public void setTasksName(String tasksName) {
        this.tasksName = tasksName;
    }

}
