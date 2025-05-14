package com.fitness.membership_system.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fitness.membership_system.model.Booking;
import com.fitness.membership_system.model.CardioWorkout;
import com.fitness.membership_system.model.StrengthWorkout;
import com.fitness.membership_system.model.Trainer;
import com.fitness.membership_system.model.WorkoutPlan;

@Service
public class WorkoutService {

    @Value("${file.workouts.path}")
    private String workoutsFilePath;

    @Value("${file.trainers.path}")
    private String trainersFilePath;

    @Value("${file.bookings.path}")
    private String bookingsFilePath;

    public void addWorkout(WorkoutPlan workout) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(workoutsFilePath, true))) {
            writer.write(String.format("%s,%s,%s,%d,%s,%s\n",
                    workout.getId(), workout.getName(), workout.getDescription(),
                    workout.getDurationMinutes(), workout.getTrainerId(), workout.getType()));
        }
    }

    public List<WorkoutPlan> getAllWorkouts() throws IOException {
        List<WorkoutPlan> workouts = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(workoutsFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                WorkoutPlan workout = parts[5].equals("Cardio") ?
                        new CardioWorkout(parts[0], parts[1], parts[2], Integer.parseInt(parts[3]), parts[4]) :
                        new StrengthWorkout(parts[0], parts[1], parts[2], Integer.parseInt(parts[3]), parts[4]);
                workouts.add(workout);
            }
        }
        return workouts;
    }

    public WorkoutPlan findWorkoutById(String id) throws IOException {
        return getAllWorkouts().stream()
                .filter(workout -> workout.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    public void updateWorkout(WorkoutPlan updatedWorkout) throws IOException {
        List<WorkoutPlan> workouts = getAllWorkouts();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(workoutsFilePath))) {
            for (WorkoutPlan workout : workouts) {
                if (workout.getId().equals(updatedWorkout.getId())) {
                    writer.write(String.format("%s,%s,%s,%d,%s,%s\n",
                            updatedWorkout.getId(), updatedWorkout.getName(), updatedWorkout.getDescription(),
                            updatedWorkout.getDurationMinutes(), updatedWorkout.getTrainerId(), updatedWorkout.getType()));
                } else {
                    writer.write(String.format("%s,%s,%s,%d,%s,%s\n",
                            workout.getId(), workout.getName(), workout.getDescription(),
                            workout.getDurationMinutes(), workout.getTrainerId(), workout.getType()));
                }
            }
        }
    }

    public void deleteWorkout(String id) throws IOException {
        List<WorkoutPlan> workouts = getAllWorkouts();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(workoutsFilePath))) {
            for (WorkoutPlan workout : workouts) {
                if (!workout.getId().equals(id)) {
                    writer.write(String.format("%s,%s,%s,%d,%s,%s\n",
                            workout.getId(), workout.getName(), workout.getDescription(),
                            workout.getDurationMinutes(), workout.getTrainerId(), workout.getType()));
                }
            }
        }
    }

    public void addTrainer(Trainer trainer) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(trainersFilePath, true))) {
            writer.write(String.format("%s,%s,%s,%s\n",
                    trainer.getId(), trainer.getName(), trainer.getSpecialization(), trainer.getAvailability()));
        }
    }

    public List<Trainer> getAllTrainers() throws IOException {
        List<Trainer> trainers = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(trainersFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                Trainer trainer = new Trainer(parts[0], parts[1], parts[2], parts[3]);
                trainers.add(trainer);
            }
        }
        return trainers;
    }

    public Trainer findTrainerById(String id) throws IOException {
        return getAllTrainers().stream()
                .filter(trainer -> trainer.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    public void updateTrainer(Trainer updatedTrainer) throws IOException {
        List<Trainer> trainers = getAllTrainers();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(trainersFilePath))) {
            for (Trainer trainer : trainers) {
                if (trainer.getId().equals(updatedTrainer.getId())) {
                    writer.write(String.format("%s,%s,%s,%s\n",
                            updatedTrainer.getId(), updatedTrainer.getName(),
                            updatedTrainer.getSpecialization(), updatedTrainer.getAvailability()));
                } else {
                    writer.write(String.format("%s,%s,%s,%s\n",
                            trainer.getId(), trainer.getName(),
                            trainer.getSpecialization(), trainer.getAvailability()));
                }
            }
        }
    }

    public void deleteTrainer(String id) throws IOException {
        List<Trainer> trainers = getAllTrainers();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(trainersFilePath))) {
            for (Trainer trainer : trainers) {
                if (!trainer.getId().equals(id)) {
                    writer.write(String.format("%s,%s,%s,%s\n",
                            trainer.getId(), trainer.getName(),
                            trainer.getSpecialization(), trainer.getAvailability()));
                }
            }
        }
    }

    public void bookSession(Booking booking) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(bookingsFilePath, true))) {
            writer.write(String.format("%s,%s,%s,%s,%s\n",
                    booking.getId(), booking.getUserId(), booking.getWorkoutId(),
                    booking.getTrainerId(), booking.getSessionTime().toString()));
        }
    }

    public List<Booking> getAllBookings() throws IOException {
        List<Booking> bookings = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(bookingsFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                Booking booking = new Booking(parts[0], parts[1], parts[2], parts[3], LocalDateTime.parse(parts[4]));
                bookings.add(booking);
            }
        }
        return bookings;
    }
}