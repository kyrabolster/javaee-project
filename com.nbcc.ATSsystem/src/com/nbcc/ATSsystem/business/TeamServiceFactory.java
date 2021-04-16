package com.nbcc.ATSsystem.business;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-20
 */
public class TeamServiceFactory {
    public static ITeamService createInstance() {
        return new TeamService();
    }
}
