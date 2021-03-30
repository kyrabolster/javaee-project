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
public abstract class JobFactory {
    public static IJob createInstance() {
        return new Job();
    }
    
    public static IJob createInstance(int teamId, String description, String clientName, Date start, List<String> tasks){
        return new Job(teamId, description, clientName, start, tasks);
    }
    
    public static ArrayList<IJob> createListInstance() {
        return new ArrayList();
    }
}
