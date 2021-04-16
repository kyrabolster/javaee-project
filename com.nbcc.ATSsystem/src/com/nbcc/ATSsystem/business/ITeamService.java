/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.business;

import com.nbcc.ATSsystem.models.EmployeeVM;
import com.nbcc.ATSsystem.models.ITeam;
import java.util.List;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-20
 */
public interface ITeamService {
    boolean isValid(ITeam team);
    
    ITeam createTeam(ITeam team);
    int SaveTeam(ITeam team);
    int deleteTeam(int id);
    
    ITeam getTeam(int id);
    List<ITeam> getTeams();
    
    List<EmployeeVM> getEmployees();

    ITeam getTeamOnCall();
}
