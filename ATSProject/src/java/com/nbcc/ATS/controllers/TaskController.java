/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATS.controllers;

import com.nbcc.ATS.models.ErrorViewModel;
import com.nbcc.ATSsystem.business.ITaskService;
import com.nbcc.ATSsystem.business.TaskServiceFactory;
import com.nbcc.ATSsystem.models.ITask;
import com.nbcc.ATSsystem.models.TaskFactory;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author notil
 */
public class TaskController extends CommonController {
    private static final String TASKS_VIEW = "/tasks.jsp";
    private static final String TASKS_MAINT_VIEW = "/task.jsp";
    private static final String TASK_SUMMARY_VIEW = "/tasksummary.jsp";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        //Service Instance
        ITaskService taskService = TaskServiceFactory.createInstance();

        if (pathInfo != null) {
            String[] pathParts = pathInfo.split("/");

            int id = super.getInteger(pathParts[1]);
            //Get the invoice in a variable
            ITask task = taskService.getTask(id);
            
            //Set attribute as invoice or error
            if(task != null) {
                request.setAttribute("task", task);
            } else {
                request.setAttribute("error", new ErrorViewModel(String.format("Task ID: $s is not found", id)));
            }
            super.setView(request, TASKS_MAINT_VIEW);
        } else {
            //Set attribute as list of the invoices
            request.setAttribute("tasks", taskService.getTasks());
            super.setView(request, TASKS_VIEW);
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
        
        super.setView(request, TASK_SUMMARY_VIEW);
        
        ITaskService taskService = TaskServiceFactory.createInstance();
        ITask task;
        
        try {
            String action = super.getValue(request, "action");
            int id = super.getInteger(request, "hdnTaskId");
            

            switch (action.toLowerCase()) {
                case "create":
                    task = setTask(request);
                    task = taskService.createTask(task);
                    
                    request.setAttribute("task", task);
                    
                    if(!taskService.isValid(task)){
                        request.setAttribute("error", task.getErrors());
                        super.setView(request, TASKS_MAINT_VIEW);
                    }
                    
                    break;
                case "save":
                    
                    break;
                case "delete":
                   
                    break;
            }
        } catch (Exception e) {
            super.setView(request, TASKS_MAINT_VIEW);
            request.setAttribute("error", new ErrorViewModel("An error occurred attempting to maintain tasks"));
        }

        super.getView().forward(request, response);
    }

    private ITask setTask(HttpServletRequest request){
        String name;
        String description;
        int duration;
        
        name = getValue(request, "taskName");
        description = getValue(request, "taskDesc");
        duration = getInteger(request, "taskDuration");
        
        ITask task = TaskFactory.createInstance(name, description, duration);
        
        return task;
    }
}
