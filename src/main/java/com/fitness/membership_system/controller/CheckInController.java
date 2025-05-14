package com.fitness.membership_system.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fitness.membership_system.model.Admin;
import com.fitness.membership_system.model.CheckIn;
import com.fitness.membership_system.model.GymCheckIn;
import com.fitness.membership_system.model.User;
import com.fitness.membership_system.model.VirtualClassCheckIn;
import com.fitness.membership_system.service.CheckInService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/checkin")
public class CheckInController {

    @Autowired
    private CheckInService checkInService;

    @GetMapping("")
    public String showCheckInPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null)
            return "redirect:/users/login";
        model.addAttribute("userId", user.getId());
        return "checkin";
    }

    @PostMapping("")
    public String logCheckIn(@RequestParam("userId") String userId,
            @RequestParam("type") String type,
            @RequestParam(value = "virtualClassId", required = false) Integer virtualClassId,
            HttpSession session,
            RedirectAttributes redirectAttributes) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getId().equals(userId))
            return "redirect:/users/login";
        int checkInId = checkInService.getNextCheckInId();
        LocalDateTime checkInDate = LocalDateTime.now();
        CheckIn checkIn;
        if ("Gym".equals(type)) {
            checkIn = new GymCheckIn(checkInId, userId, checkInDate);
        } else {
            checkIn = new VirtualClassCheckIn(checkInId, userId, checkInDate,
                    virtualClassId != null ? virtualClassId : 0);
        }
        checkInService.logCheckIn(checkIn);
        redirectAttributes.addFlashAttribute("message", "Check-in successful!");
        return "redirect:/checkin";
    }

    @GetMapping("/history")
    public String showCheckInHistory(HttpSession session, Model model) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null)
            return "redirect:/users/login";
        List<CheckIn> checkIns = checkInService.getAllCheckIns().stream()
                .filter(checkIn -> checkIn.getUserId().equals(user.getId()))
                .collect(Collectors.toList());
        model.addAttribute("checkIns", checkIns);
        model.addAttribute("userId", user.getId());
        return "checkin-history";
    }

    @GetMapping("/admin")
    public String showAdminAttendance(HttpSession session, Model model) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof Admin))
            return "redirect:/users/admin/login";
        List<CheckIn> checkIns = checkInService.getAllCheckIns();
        model.addAttribute("checkIns", checkIns);
        return "admin-attendance";
    }

    @PostMapping("/admin")
    public String handleAdminActions(@RequestParam("action") String action,
            @RequestParam(value = "checkInId", required = false) Integer checkInId,
            @RequestParam(value = "userId", required = false) String userId,
            @RequestParam(value = "type", required = false) String type,
            @RequestParam(value = "checkInDate", required = false) String checkInDate,
            @RequestParam(value = "virtualClassId", required = false) Integer virtualClassId,
            HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof Admin))
            return "redirect:/users/admin/login";
        if ("update".equals(action) && checkInId != null) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            LocalDateTime dateTime = LocalDateTime.parse(checkInDate, formatter);
            CheckIn updatedCheckIn;
            if ("Gym".equals(type)) {
                updatedCheckIn = new GymCheckIn(checkInId, userId, dateTime);
            } else {
                updatedCheckIn = new VirtualClassCheckIn(checkInId, userId, dateTime,
                        virtualClassId != null ? virtualClassId : 0);
            }
            checkInService.updateCheckIn(checkInId, updatedCheckIn);
        } else if ("deleteOld".equals(action)) {
            checkInService.deleteOldRecords();
        }
        return "redirect:/checkin/admin";
    }
}