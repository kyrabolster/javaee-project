/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.models;

import java.util.ArrayList;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-20
 */
public abstract class TeamFactory {
     public static ITeam createInstance() {
        return new Team();
    }
    
    public static ITeam createInstance(String name, boolean isOnCall, int empId1, int empId2) {
        return new Team(name, isOnCall, empId1, empId2);
    }
    
    public static ArrayList<ITeam> createListInstance() {
        return new ArrayList();
    }
}
