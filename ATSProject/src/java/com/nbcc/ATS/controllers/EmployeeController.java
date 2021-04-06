/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATS.controllers;

import com.nbcc.ATS.models.ErrorViewModel;
import com.nbcc.ATSsystem.business.EmployeeServiceFactory;
import com.nbcc.ATSsystem.business.IEmployeeService;
import com.nbcc.ATSsystem.business.ITaskService;
import com.nbcc.ATSsystem.business.TaskServiceFactory;
import com.nbcc.ATSsystem.models.IEmployee;
import com.nbcc.ATSsystem.models.EmployeeFactory;
import com.nbcc.ATSsystem.models.ErrorFactory;
import com.nbcc.ATSsystem.models.ITask;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author KyraB
 */
public class EmployeeController extends CommonController {

    private static final String EMPLOYEES_VIEW = "/employees.jsp";
    private static final String EMPLOYEES_MAINT_VIEW = "/employee.jsp";
    private static final String EMPLOYEE_SUMMARY_VIEW = "/employeesummary.jsp";
    private static final String EMPLOYEE_SKILLS_VIEW = "/employeeskills.jsp";
    private static final String EMPLOYEE_ERROR = "/error.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        IEmployeeService employeeService = EmployeeServiceFactory.createInstance();

        if (pathInfo != null) {
            String[] pathParts = pathInfo.split("/");

            int id = super.getInteger(pathParts[1]);

            if ("/create".equals(pathInfo)) {
                super.setView(request, EMPLOYEES_MAINT_VIEW);
            } else if (employeeExists(id)) {

                IEmployee employee = employeeService.getEmployee(id);

                if (employee != null) {
                    request.setAttribute("employee", employee);

                } else {
                    request.setAttribute("error", new ErrorViewModel(String.format("Employee ID: $s is not found", id)));
                }

                super.setView(request, EMPLOYEES_MAINT_VIEW);

                //if employee not found
            } else {
                request.setAttribute("entity", "employee");
                super.setView(request, EMPLOYEE_ERROR);
            }

        } else {
            //Set attribute as list of the employees
            request.setAttribute("employees", employeeService.getEmployees());
            super.setView(request, EMPLOYEES_VIEW);
        }

        super.getView().forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        super.setView(request, EMPLOYEE_SUMMARY_VIEW);

        IEmployeeService employeeService = EmployeeServiceFactory.createInstance();
        IEmployee employee;

        try {
            String action = super.getValue(request, "action");
            int id = super.getInteger(request, "hdnEmployeeId");

            getTasksToAdd(request, id);

            switch (action.toLowerCase()) {
                case "create":
                    employee = setEmployee(request);
                    employee = employeeService.createEmployee(employee);

                    request.setAttribute("employee", employee);

                    if (!employeeService.isValid(employee)) {
                        request.setAttribute("error", employee.getErrors());
                        super.setView(request, EMPLOYEES_MAINT_VIEW);
                    }

                    break;
                case "save":

                    break;
                case "delete":
                    employee = setEmployee(request);
                    employee.setId(id);

                    request.setAttribute("employee", employee);

                    if (employeeService.deleteEmployee(id) == 0) {
                        employee.addError(ErrorFactory.createInstance(13, "No records affected. Delete was unsuccessful"));
                        request.setAttribute("errors", employee.getErrors());
                        super.setView(request, EMPLOYEES_MAINT_VIEW);
                    } else {
                        if (employeeExists(id)) {
                            request.setAttribute("deleteMessage", "The following employee had been flagged as deleted since they are a member in a team.");
                        } else {
                            request.setAttribute("deleteMessage", "The following employee has been successfully deleted from the employees list.");
                        }
                    }
                    break;
                case "update skills":
                    employee = employeeService.getEmployee(id);
                    request.setAttribute("employee", employee);

                    super.setView(request, EMPLOYEE_SKILLS_VIEW);

                    break;
                case "add skill":
                    int skillToAddId = setSkillToAdd(request);

                    if (skillToAddId == 0) {
                        request.setAttribute("error", new ErrorViewModel(String.format("Please select a skill to be added.")));
                    }

                    employeeService.addEmployeeSkill(id, skillToAddId);

                    employee = employeeService.getEmployee(id);
                    request.setAttribute("employee", employee);

                    getTasksToAdd(request, id);

                    super.setView(request, EMPLOYEE_SKILLS_VIEW);

                    break;
                case "remove skill":
                    int skillToRemoveId = setSkillToRemove(request);

                    if (skillToRemoveId == 0) {
                        request.setAttribute("error", new ErrorViewModel(String.format("Please select a skill to be removed.")));
                    }

                    employeeService.removeEmployeeSkill(id, skillToRemoveId);

                    employee = employeeService.getEmployee(id);
                    request.setAttribute("employee", employee);

                    getTasksToAdd(request, id);

                    super.setView(request, EMPLOYEE_SKILLS_VIEW);

                    break;
                case "search":
                    String search = getValue(request, "search");
                    
                    //pass search keyword
                    request.setAttribute("employees", employeeService.getEmployees(search));
                    super.setView(request, EMPLOYEES_VIEW);
                    break;
            }
        } catch (Exception e) {
            super.setView(request, EMPLOYEES_MAINT_VIEW);
            request.setAttribute("error", new ErrorViewModel("An error occurred attempting to maintain employees"));
        }

        super.getView().forward(request, response);
    }

    private IEmployee setEmployee(HttpServletRequest request) {
        String firstName;
        String lastName;
        String SIN;
        double hourlyRate;

        firstName = getValue(request, "firstName");
        lastName = getValue(request, "lastName");
        SIN = getValue(request, "SIN");
        hourlyRate = getDouble(request, "hourlyRate");

        IEmployee employee = EmployeeFactory.createInstance(firstName, lastName, SIN, hourlyRate);

        return employee;
    }

    private int setSkillToAdd(HttpServletRequest request) {
        int skillId;

        skillId = getInteger(request, "taskToAdd");

        return skillId;
    }

    private int setSkillToRemove(HttpServletRequest request) {
        int skillId;

        skillId = getInteger(request, "taskToRemove");

        return skillId;
    }

    private void getAllTasks(HttpServletRequest request) {
        ITaskService taskService = TaskServiceFactory.createInstance();
        List<ITask> taskList = taskService.getTasks();
        request.setAttribute("taskList", taskList);
    }

    private void getTasksToAdd(HttpServletRequest request, int employeeId) {
        ITaskService taskService = TaskServiceFactory.createInstance();
        List<ITask> tasksToAdd = taskService.getTasksNotAssignedToEmployee(employeeId);
        request.setAttribute("tasksToAdd", tasksToAdd);
    }

    private boolean employeeExists(int id) {
        IEmployeeService employeeService = EmployeeServiceFactory.createInstance();

        List<IEmployee> emps = employeeService.getEmployees();

        List<Integer> empIds = new ArrayList<Integer>();

        for (IEmployee emp : emps) {
            int empId = emp.getId();
            empIds.add(empId);
        }

        return empIds.contains(id);
    }
}
