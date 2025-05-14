package com.fitness.membership_system.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fitness.membership_system.model.Trainer;

@Controller
public class TrainerController {
    @GetMapping("/trainers")
    public String showTrainers(Model model) {
        List<Trainer> trainers = new ArrayList<>();
        try {
            InputStream is = getClass().getClassLoader().getResourceAsStream("trainers.txt");
            if (is != null) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(is));
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",");
                    if (parts.length >= 4) {
                        trainers.add(new Trainer(parts[0], parts[1], parts[2], parts[3]));
                    }
                }
                reader.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        model.addAttribute("trainers", trainers);
        return "trainer-profile";
    }
} 