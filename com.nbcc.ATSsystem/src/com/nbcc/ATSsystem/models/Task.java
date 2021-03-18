/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nbcc.ATSsystem.models;

/**
 *
 * @author Soyoung Kim
 * @date 2021-03-15
 */
public class Task extends Base implements ITask {

    private int id;
    private String name;
    private String description;
    private int duration;

    public Task() {
        this.name = "";
        this.description = "";
        this.duration = 0;
    }

    public Task(String name, String description, int duration) {
        setName(name);
        setDescription(description);
        setDuration(duration);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        if (name == null) {
            addError(ErrorFactory.createInstance(1, "Task name is required"));
        } else {
            this.name = name;
        }
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        if (description == null) {
            addError(ErrorFactory.createInstance(2, "Task description is required"));
        } else if (description.length() < 5) {
            addError(ErrorFactory.createInstance(3, "Task description must be 5 characters or larger"));
        } else {
            this.description = description;
        }
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        if (duration < 15) {
            addError(ErrorFactory.createInstance(4, "Duration can not be less than 15 minutes"));
        } else {
            this.duration = duration;
        }
    }

}
