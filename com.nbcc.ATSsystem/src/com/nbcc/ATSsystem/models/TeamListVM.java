/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.models;

import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author Soyoung Kim
 * @date 2021-04-01
 */
public class TeamListVM {
    private int id;
    private String teamName;
    private int totalDuration;
    private Timestamp start;
    private Timestamp end;
    private List<IEmployee> teamMembers;

    public TeamListVM() {        
    }

    public TeamListVM(int id, String teamName, int totalDuration, Timestamp start, Timestamp end) {
        setId(id);
        setTeamName(teamName);
        setTotalDuration(totalDuration);
        setStart(start);
        setEnd(end);
    }
    
    public TeamListVM(int id, String teamName, List<IEmployee> teamMembers){
        setId(id);
        setTeamName(teamName);
        setTeamMembers(teamMembers);
    }
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public int getTotalDuration() {
        return totalDuration;
    }

    public void setTotalDuration(int totalDuration) {
        this.totalDuration = totalDuration;
    }

    public Timestamp getStart() {
        return start;
    }

    public void setStart(Timestamp start) {
        this.start = start;
    }

    public Timestamp getEnd() {
        return end;
    }

    public void setEnd(Timestamp end) {
        this.end = end;
    }

    public List<IEmployee> getTeamMembers() {
        return teamMembers;
    }

    public void setTeamMembers(List<IEmployee> teamMembers) {
        this.teamMembers = teamMembers;
    }
    
    
}
