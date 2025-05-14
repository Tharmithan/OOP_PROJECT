package com.fitness.membership_system.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fitness.membership_system.model.Booking;
import com.fitness.membership_system.model.CardioWorkout;
import com.fitness.membership_system.model.StrengthWorkout;
import com.fitness.membership_system.model.Trainer;
import com.fitness.membership_system.model.WorkoutPlan;
import com.fitness.membership_system.service.WorkoutService;

@Controller
@RequestMapping("/workout")
public class WorkoutController {

    @Autowired
    private WorkoutService workoutService;

    @GetMapping("/list")
    public String listWorkouts(Model model) throws IOException {
        List<WorkoutPlan> workouts = workoutService.getAllWorkouts();
        model.addAttribute("workouts", workouts);
        return "workout-list";
    }

    @GetMapping("/trainers")
    public String listTrainers(Model model) throws IOException {
        List<Trainer> trainers = workoutService.getAllTrainers();
        model.addAttribute("trainers", trainers);
        return "trainer-profile";
    }

    @GetMapping("/book")
    public String showBookingForm(Model model) throws IOException {
        List<WorkoutPlan> workouts = workoutService.getAllWorkouts();
        List<Trainer> trainers = workoutService.getAllTrainers();
        if (workouts.isEmpty()) {
            workouts.add(new CardioWorkout("w1", "Sample Cardio", "A sample cardio workout", 30, "t1"));
        }
        if (trainers.isEmpty()) {
            trainers.add(new Trainer("t1", "John Doe", "Cardio", "Monday-Friday 9AM-5PM"));
        }
        model.addAttribute("workouts", workouts);
        model.addAttribute("trainers", trainers);
        model.addAttribute("booking", new Booking("", "", "", "", null));
        return "book-session";
    }

    @PostMapping("/book")
    public String bookSession(@RequestParam String userId, @RequestParam String workoutId,
                              @RequestParam String trainerId, @RequestParam String sessionTime) throws IOException {
        Booking booking = new Booking(
                UUID.randomUUID().toString(), userId, workoutId, trainerId, LocalDateTime.parse(sessionTime));
        workoutService.bookSession(booking);
        return "redirect:/workout/list";
    }

    @GetMapping("/admin/workouts")
    public String adminWorkoutManagement(Model model) throws IOException {
        List<WorkoutPlan> workouts = workoutService.getAllWorkouts();
        List<Trainer> trainers = workoutService.getAllTrainers();
        model.addAttribute("workouts", workouts);
        model.addAttribute("trainers", trainers);
        return "admin-workout-management";
    }

    @GetMapping("/admin/workouts/add")
    public String showAddWorkoutForm(Model model) throws IOException {
        model.addAttribute("workout", new CardioWorkout("", "", "", 0, ""));
        model.addAttribute("trainers", workoutService.getAllTrainers());
        return "admin-workout-management";
    }

    @PostMapping("/admin/workouts/add")
    public String addWorkout(@RequestParam String name, @RequestParam String description,
                             @RequestParam int durationMinutes, @RequestParam String trainerId,
                             @RequestParam String type) throws IOException {
        String id = UUID.randomUUID().toString();
        WorkoutPlan workout = type.equals("Cardio") ?
                new CardioWorkout(id, name, description, durationMinutes, trainerId) :
                new StrengthWorkout(id, name, description, durationMinutes, trainerId);
        workoutService.addWorkout(workout);
        return "redirect:/workout/admin/workouts";
    }

    @GetMapping("/admin/workouts/edit/{id}")
    public String showEditWorkoutForm(@PathVariable String id, Model model) throws IOException {
        WorkoutPlan workout = workoutService.findWorkoutById(id);
        model.addAttribute("workout", workout);
        model.addAttribute("trainers", workoutService.getAllTrainers());
        return "admin-workout-management";
    }

    @PostMapping("/admin/workouts/edit")
    public String updateWorkout(@RequestParam String id, @RequestParam String name,
                                @RequestParam String description, @RequestParam int durationMinutes,
                                @RequestParam String trainerId, @RequestParam String type) throws IOException {
        WorkoutPlan workout = type.equals("Cardio") ?
                new CardioWorkout(id, name, description, durationMinutes, trainerId) :
                new StrengthWorkout(id, name, description, durationMinutes, trainerId);
        workoutService.updateWorkout(workout);
        return "redirect:/workout/admin/workouts";
    }

    @GetMapping("/admin/workouts/delete/{id}")
    public String deleteWorkout(@PathVariable String id) throws IOException {
        workoutService.deleteWorkout(id);
        return "redirect:/workout/admin/workouts";
    }

    @GetMapping("/admin/trainers/add")
    public String showAddTrainerForm(Model model) {
        model.addAttribute("trainer", new Trainer("", "", "", ""));
        return "admin-workout-management";
    }

    @PostMapping("/admin/trainers/add")
    public String addTrainer(@RequestParam String name, @RequestParam String specialization,
                             @RequestParam String availability) throws IOException {
        Trainer trainer = new Trainer(UUID.randomUUID().toString(), name, specialization, availability);
        workoutService.addTrainer(trainer);
        return "redirect:/workout/admin/workouts";
    }

    @GetMapping("/admin/trainers/edit/{id}")
    public String showEditTrainerForm(@PathVariable String id, Model model) throws IOException {
        Trainer trainer = workoutService.findTrainerById(id);
        model.addAttribute("trainer", trainer);
        return "admin-workout-management";
    }

    @PostMapping("/admin/trainers/edit")
    public String updateTrainer(@RequestParam String id, @RequestParam String name,
                                @RequestParam String specialization, @RequestParam String availability) throws IOException {
        Trainer trainer = new Trainer(id, name, specialization, availability);
        workoutService.updateTrainer(trainer);
        return "redirect:/workout/admin/workouts";
    }

    @GetMapping("/admin/trainers/delete/{id}")
    public String deleteTrainer(@PathVariable String id) throws IOException {
        workoutService.deleteTrainer(id);
        return "redirect:/workout/admin/workouts";
    }
}