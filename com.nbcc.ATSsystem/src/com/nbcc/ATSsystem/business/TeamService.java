/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.business;

import com.nbcc.ATSsystem.models.EmployeeVM;
import com.nbcc.ATSsystem.models.ErrorFactory;
import com.nbcc.ATSsystem.models.ITeam;
import com.nbcc.ATSsystem.repository.ITeamRepository;
import com.nbcc.ATSsystem.repository.TeamRepositoryFactory;
import java.util.List;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-20
 */
public class TeamService implements ITeamService {

    private final ITeamRepository repo;

    public TeamService() {
        repo = TeamRepositoryFactory.createInstance();
    }

    @Override
    public boolean isValid(ITeam team) {
        return team.getErrors().isEmpty();
    }

    @Override
    public ITeam createTeam(ITeam team) {
        if (isValid(team)) {
            
            int id = 0;
            
            if(team.getIsOnCall()){
                ITeam isOnCallTeam = repo.retrieveOnCallTeam();
                if(isOnCallTeam == null) {
                    id = repo.insertTeam(team);
                } else {
                    team.addError(ErrorFactory.createInstance(14, "Team " + isOnCallTeam.getName() + " is current on call team. Only one team can be on call team."));
                }
            } else {
                id = repo.insertTeam(team);
            }
            
            if (id > 0) {
                team.setId(id);
            } else {
                team.addError(ErrorFactory.createInstance(5, "Team was not valid for creation. Database error."));
            }
        } else {
            team.addError(ErrorFactory.createInstance(5, "Team failed validation for creation"));
        }

        return team;
    }

    public List<EmployeeVM> getEmployees() {
        return repo.retrievedEmplyeeList();
    }

    public ITeam getTeamOnCall() {
        return repo.retrieveOnCallTeam();
    }
    
    @Override
    public int saveTeam(ITeam team) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int deleteTeam(int id) {
        return repo.deleteTeam(id);
    }

    @Override
    public ITeam getTeam(int id) {
        return repo.retrieveTeam(id);
    }

    @Override
    public List<ITeam> getTeams() {
        return repo.retrieveTeams();
    }

    @Override
    public List<EmployeeVM> getMembers(int id) {
        return repo.retrievedTeamMembers(id);
    }

    @Override
    public String updateIsOnCall(ITeam team) {
        return repo.updateIsOnCall(team);
    }
}
