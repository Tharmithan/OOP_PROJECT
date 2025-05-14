package com.fitness.membership_system.model;

import java.util.List;

public class Trainer {
    private String id;
    private String name;
    private String specialization;
    private String availability;

    public Trainer(String id, String name, String specialization, String availability) {
        this.id = id;
        this.name = name;
        this.specialization = specialization;
        this.availability = availability;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public String getAvailability() {
        return availability;
    }

    public void setAvailability(String availability) {
        this.availability = availability;
    }
}