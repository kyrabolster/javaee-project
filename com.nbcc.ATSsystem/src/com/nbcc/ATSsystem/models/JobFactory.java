/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.models;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-30
 */
public abstract class JobFactory {
    public static IJob createInstance() {
        return new Job();
    }
    
    public static IJob createInstance(String clientName, String description, Timestamp start, List<String> tasks, boolean isOnSite){
        return new Job(clientName, description, start, tasks, isOnSite);
    }
    
    public static IJob createInstance(int teamId, String clientName, String description, Timestamp start, List<String> tasks){
        return new Job(teamId, clientName, description, start, tasks);
    }
    
    public static IJob createInstance(int teamId, String clientName, String description, Timestamp start, List<String> tasks, boolean isOnSite, int totalDuration, String selectedTasks){
        return new Job(teamId, clientName, description, start, tasks, isOnSite, totalDuration, selectedTasks);
    }
    
    public static ArrayList<IJob> createListInstance() {
        return new ArrayList();
    }
}
