package com.fitness.membership_system.controller;

import java.io.IOException;
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

import com.fitness.membership_system.model.Admin;
import com.fitness.membership_system.model.PremiumMember;
import com.fitness.membership_system.model.RegularMember;
import com.fitness.membership_system.model.User;
import com.fitness.membership_system.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new RegularMember("", "", "", "", ""));
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@RequestParam String username, @RequestParam String password,
            @RequestParam String email, @RequestParam String phone,
            @RequestParam String membershipType) throws IOException {
        String id = UUID.randomUUID().toString();
        User user = membershipType.equals("Premium") ? new PremiumMember(id, username, password, email, phone)
                : new RegularMember(id, username, password, email, phone);
        userService.registerMember(user);
        return "redirect:/users/login";
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String loginUser(@RequestParam String username, @RequestParam String password, Model model,
            HttpSession session) throws IOException {
        User user = userService.findMemberByUsername(username);
        if (user != null && user.getPassword().equals(password)) {
            session.setAttribute("user", user);
            return "redirect:/";
        }
        model.addAttribute("error", "Invalid credentials");
        return "login";
    }

    @GetMapping("/admin/login")
    public String showAdminLoginForm() {
        return "admin-login";
    }

    @PostMapping("/admin/login")
    public String loginAdmin(@RequestParam String username, @RequestParam String password, Model model,
            HttpSession session) throws IOException {
        Admin admin = userService.findAdminByUsername(username);
        System.out.println("Attempting to login admin: " + username);
        if (admin != null && admin.getPassword().equals(password)) {
            System.out.println("Admin login successful, setting session attribute: " + admin);
            session.setAttribute("user", admin);
            return "redirect:/users/admin/dashboard";
        }
        System.out.println("Admin login failed for: " + username);
        model.addAttribute("error", "Invalid admin credentials");
        return "admin-login";
    }

    @GetMapping("/admin/dashboard")
    public String showAdminDashboard(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        System.out.println("Checking session in dashboard: " + user);
        if (user == null) {
            System.out.println("No user in session, redirecting to login.");
            return "redirect:/users/admin/login";
        }
        // Temporarily bypass role check for debugging
        System.out.println("User found: " + user.getUsername());
        if (user instanceof Admin) {
            System.out.println("User is an Admin instance.");
        } else {
            System.out.println("User is NOT an Admin instance: " + user.getClass());
            return "redirect:/users/admin/login";
        }
        model.addAttribute("user", user);
        System.out.println("Rendering admin dashboard for: " + user.getUsername());
        return "admin-dashboard";
    }

    @GetMapping("/list")
    public String listMembers(Model model) throws IOException {
        List<User> members = userService.getAllMembers();
        model.addAttribute("members", members);
        return "member-list";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model) throws IOException {
        User user = userService.getAllMembers().stream()
                .filter(u -> u.getId().equals(id))
                .findFirst()
                .orElse(null);
        model.addAttribute("user", user);
        return "edit-profile";
    }

    @PostMapping("/edit")
    public String updateUser(@RequestParam String id, @RequestParam String username,
            @RequestParam String password, @RequestParam String email,
            @RequestParam String phone, @RequestParam String membershipType) throws IOException {
        User user = membershipType.equals("Premium") ? new PremiumMember(id, username, password, email, phone)
                : new RegularMember(id, username, password, email, phone);
        userService.updateMember(user);
        return "redirect:/users/list";
    }

    @GetMapping("/delete/{id}")
    public String deleteUser(@PathVariable String id) throws IOException {
        userService.deleteMember(id);
        return "redirect:/users/list";
    }

    @GetMapping("/profile/{id}")
    public String showProfile(@PathVariable String id, HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getId().equals(id)) {
            return "redirect:/users/login";
        }
        model.addAttribute("user", user);
        return "profile"; // Ensure you have a profile.jsp file
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/profile")
    public String showLoggedInProfile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/users/login";
        }
        model.addAttribute("user", user);
        return "profile";
    }

}