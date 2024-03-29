/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.repository;

import com.nbcc.ATSsystem.models.EmployeeVM;
import com.nbcc.ATSsystem.models.ITeam;
import com.nbcc.ATSsystem.models.TeamFactory;
import com.nbcc.dataaccess.DALFactory;
import com.nbcc.dataaccess.IDAL;
import com.nbcc.dataaccess.IParameter;
import com.nbcc.dataaccess.ParameterFactory;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.sql.rowset.CachedRowSet;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-20
 */
public class TeamRepository extends BaseRepository implements ITeamRepository {

    private final String SPROC_INSERT_TEAM = "CALL InsertTeam(?,?,?,?,?);";
    private final String SPROC_RETRIEVE_EMPLOYEES = "CALL selectEmployeesNotInTeam()";
    private final String SPROC_RETRIEVE_TEAMMEMBERS = "CALL SelectEmployeesByTeamId(?)";
    private final String SPROC_RETRIEVE_TEAMS = "CALL RetrieveTeams(null)";
    private final String SPROC_RETRIEVE_TEAM = "CALL RetrieveTeams(?)";
    private final String SPROC_DELETE_TEAM = "CALL DeleteTeam(?)";
    private final String SPROC_UPDATE_ISONCALL = "CALL UpdateIsOnCallTeam(?,?,?)";
    private final String SPROC_RETRIEVE_ONCALLTEAM = "CALL SelectOnCallTeam()";

    private IDAL dataAccess;

    public TeamRepository() {
        dataAccess = DALFactory.createInstance();
    }

    /**
     * Insert team
     * @param team
     * @return id of inserted team
     */
    @Override
    public int insertTeam(ITeam team) {
        int returnId = 0;

        List<Object> returnValues;

        List<IParameter> params = ParameterFactory.createListInstance();

        params.add(ParameterFactory.createInstance(team.getName()));
        params.add(ParameterFactory.createInstance(team.getIsOnCall()));
        params.add(ParameterFactory.createInstance(team.getEmpId1()));
        params.add(ParameterFactory.createInstance(team.getEmpId2()));

        params.add(ParameterFactory.createInstance(returnId, IParameter.Direction.OUT, java.sql.Types.INTEGER));

        returnValues = dataAccess.executeNonQuery(SPROC_INSERT_TEAM, params);

        try {
            if (returnValues != null) {
                returnId = Integer.parseInt(returnValues.get(0).toString());
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return returnId;

    }

    /**
     * Delete team by id
     * @param id
     * @return number of rows affected
     */
    @Override
    public int deleteTeam(int id) {
        int rowsAffected = 0;
        List<Object> returnValues;
        List<IParameter> params = ParameterFactory.createListInstance();

        params.add(ParameterFactory.createInstance(id));

        returnValues = dataAccess.executeNonQuery(SPROC_DELETE_TEAM, params);

        try {
            if (returnValues != null) {
                rowsAffected = Integer.parseInt(returnValues.get(0).toString());
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return rowsAffected;
    }

    /**
     * Get all teams
     * @return list of teams
     */
    @Override
    public List<ITeam> retrieveTeams() {
        List<ITeam> retrievedTeams = TeamFactory.createListInstance();

        try {
            CachedRowSet cr = dataAccess.executeFill(SPROC_RETRIEVE_TEAMS, null);
            retrievedTeams = toListofTeams(cr);

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return retrievedTeams;
    }

    /**
     * Get team by id
     * @param id
     * @return team with respective id
     */
    @Override
    public ITeam retrieveTeam(int id) {
        List<ITeam> teams = TeamFactory.createListInstance();

        try {
            List<IParameter> params = ParameterFactory.createListInstance();
            params.add(ParameterFactory.createInstance(id));
            CachedRowSet cr = dataAccess.executeFill(SPROC_RETRIEVE_TEAM, params);
            teams = toListofTeams(cr);

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return teams.get(0);
    }

    /**
     * Get employee list as view model
     * @return list of employee view models
     */
    public List<EmployeeVM> retrievedEmplyeeList() {
        List<EmployeeVM> retrievedEmplyeeList = new ArrayList<>();

        try {
            CachedRowSet cr = dataAccess.executeFill(SPROC_RETRIEVE_EMPLOYEES, null);

            while (cr.next()) {
                EmployeeVM emp = new EmployeeVM();
                emp.setId(super.getInt("id", cr));
                emp.setName(cr.getString("FullName"));

                retrievedEmplyeeList.add(emp);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return retrievedEmplyeeList;
    }

    /**
     * Get list of teams from row set
     * @param cr
     * @return list of teams
     * @throws SQLException 
     */
    private List<ITeam> toListofTeams(CachedRowSet cr) throws SQLException {
        List<ITeam> retrievedTeams = TeamFactory.createListInstance();
        ITeam team;

        while (cr.next()) {
            team = TeamFactory.createInstance();
            team.setId(super.getInt("id", cr));
            team.setName(super.getString("Name", cr));
            team.setIsOnCall(cr.getBoolean("IsOnCall"));
            team.setIsDeleted(cr.getBoolean("IsDeleted"));
            team.setCreatedAt(super.getDate("CreatedAt", cr));
            team.setUpdatedAt(super.getDate("UpdatedAt", cr));
            team.setDeletedAt(super.getDate("DeletedAt", cr));
            team.setMembers(super.getString("teamMember", cr));

            retrievedTeams.add(team);
        }

        return retrievedTeams;
    }

    /**
     * Get team members by team id
     * @param id
     * @return list of team members for specified team
     */
    @Override
    public List<EmployeeVM> retrievedTeamMembers(int id) {
        List<EmployeeVM> retrievedTeamMembers = new ArrayList<>();

        try {
            List<IParameter> params = ParameterFactory.createListInstance();
            params.add(ParameterFactory.createInstance(id));
            CachedRowSet cr = dataAccess.executeFill(SPROC_RETRIEVE_TEAMMEMBERS, params);

            while (cr.next()) {
                EmployeeVM emp = new EmployeeVM();
                emp.setId(super.getInt("id", cr));
                emp.setName(cr.getString("FullName"));

                retrievedTeamMembers.add(emp);
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return retrievedTeamMembers;
    }

    /**
     * Update on call status of specific team
     * @param team
     * @return returned query values as string
     */
    @Override
    public String updateIsOnCall(ITeam team) {
        String returnString = null;

        List<Object> returnValues;

        List<IParameter> params = ParameterFactory.createListInstance();

        params.add(ParameterFactory.createInstance(team.getId()));
        params.add(ParameterFactory.createInstance(team.getIsOnCall()));

        params.add(ParameterFactory.createInstance(returnString, IParameter.Direction.OUT, java.sql.Types.VARCHAR));

        returnValues = dataAccess.executeNonQuery(SPROC_UPDATE_ISONCALL, params);

        try {
            if (returnValues.get(0) != null) {
                returnString = returnValues.get(0).toString();
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return returnString;
    }

    /**
     * Get team currently on call
     * @return team on call
     */
    @Override
    public ITeam retrieveOnCallTeam() {
        ITeam team = null;
        
        try {
            CachedRowSet cr = dataAccess.executeFill(SPROC_RETRIEVE_ONCALLTEAM, null);
            
            while (cr.next()) {
                team = TeamFactory.createInstance();
                team.setId(super.getInt("id", cr));
                team.setName(super.getString("Name", cr));
                team.setMembers(super.getString("teamMember", cr));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return team;
    }
}
