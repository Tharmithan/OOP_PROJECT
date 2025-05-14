package com.fitness.membership_system.controller;

import java.io.IOException;
import java.time.LocalDate;
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
import com.fitness.membership_system.model.BasicPlan;
import com.fitness.membership_system.model.MembershipPlan;
import com.fitness.membership_system.model.PremiumPlan;
import com.fitness.membership_system.model.RenewalQueue;
import com.fitness.membership_system.model.RenewalRequest;
import com.fitness.membership_system.model.StandardPlan;
import com.fitness.membership_system.model.User;
import com.fitness.membership_system.service.MembershipService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/membership")
public class MembershipController {

    @Autowired
    private MembershipService membershipService;

    @GetMapping("/plans")
    public String listPlans(Model model, HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/users/login";
        }
        List<MembershipPlan> plans = membershipService.getAllPlans();
        model.addAttribute("plans", plans);
        return "plan-list";
    }

    @GetMapping("/admin/plans")
    public String adminPlanManagement(Model model, HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof Admin)) {
            return "redirect:/users/admin/login";
        }
        List<MembershipPlan> plans = membershipService.getAllPlans();
        model.addAttribute("plans", plans);
        return "admin-plan-management";
    }

    @GetMapping("/admin/plans/add")
    public String showAddPlanForm(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof Admin)) {
            return "redirect:/users/admin/login";
        }
        model.addAttribute("plan", new BasicPlan("", 0.0, 0));
        return "admin-plan-management";
    }

    @PostMapping("/admin/plans/add")
    public String addPlan(@RequestParam String name, @RequestParam double price,
                          @RequestParam int durationMonths, @RequestParam String accessRights,
                          HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof Admin)) {
            return "redirect:/users/admin/login";
        }
        String id = UUID.randomUUID().toString();
        MembershipPlan plan;
        switch (name) {
            case "Basic":
                plan = new BasicPlan(id, price, durationMonths);
                break;
            case "Standard":
                plan = new StandardPlan(id, price, durationMonths);
                break;
            case "Premium":
                plan = new PremiumPlan(id, price, durationMonths);
                break;
            default:
                return "redirect:/membership/admin/plans";
        }
        plan.setAccessRights(accessRights);
        membershipService.addPlan(plan);
        return "redirect:/membership/admin/plans";
    }

    @GetMapping("/admin/plans/edit/{id}")
    public String showEditPlanForm(@PathVariable String id, Model model, HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof Admin)) {
            return "redirect:/users/admin/login";
        }
        MembershipPlan plan = membershipService.findPlanById(id);
        model.addAttribute("plan", plan);
        return "admin-plan-management";
    }

    @PostMapping("/admin/plans/edit")
    public String updatePlan(@RequestParam String id, @RequestParam String name,
                             @RequestParam double price, @RequestParam int durationMonths,
                             @RequestParam String accessRights, HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof Admin)) {
            return "redirect:/users/admin/login";
        }
        MembershipPlan plan;
        switch (name) {
            case "Basic":
                plan = new BasicPlan(id, price, durationMonths);
                break;
            case "Standard":
                plan = new StandardPlan(id, price, durationMonths);
                break;
            case "Premium":
                plan = new PremiumPlan(id, price, durationMonths);
                break;
            default:
                return "redirect:/membership/admin/plans";
        }
        plan.setAccessRights(accessRights);
        membershipService.updatePlan(plan);
        return "redirect:/membership/admin/plans";
    }

    @GetMapping("/admin/plans/delete/{id}")
    public String deletePlan(@PathVariable String id, HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof Admin)) {
            return "redirect:/users/admin/login";
        }
        membershipService.deletePlan(id);
        return "redirect:/membership/admin/plans";
    }

    @GetMapping("/upgrade")
    public String showUpgradeForm(Model model, HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/users/login";
        }
        List<MembershipPlan> plans = membershipService.getAllPlans();
        model.addAttribute("plans", plans);
        model.addAttribute("userId", user.getId()); // Pass userId for the form
        return "plan-upgrade";
    }

    @PostMapping("/submit-upgrade")
    public String submitUpgradeAfterPayment(@RequestParam String userId, @RequestParam String planId, Model model, HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null || !user.getId().equals(userId)) {
            return "redirect:/users/login";
        }
        RenewalRequest request = new RenewalRequest(
                UUID.randomUUID().toString(), userId, planId,
                LocalDate.now(), LocalDate.now(), 1);
        membershipService.enqueueRenewalRequest(request);
        model.addAttribute("message", "Upgrade request submitted successfully!");
        return "upgrade-success";
    }

    @GetMapping("/admin/renewal-queue")
    public String viewRenewalQueue(Model model, HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof Admin)) {
            return "redirect:/users/admin/login";
        }
        RenewalQueue queue = membershipService.getRenewalQueue();
        model.addAttribute("queue", queue.getQueue());
        return "renewal-queue";
    }

    @GetMapping("/admin/renewal-queue/dequeue")
    public String dequeueRenewalRequest(HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof Admin)) {
            return "redirect:/users/admin/login";
        }
        membershipService.dequeueRenewalRequest();
        return "redirect:/membership/admin/renewal-queue";
    }

    @PostMapping("/admin/renewal-queue/update-priority")
    public String updateRenewalPriority(@RequestParam String requestId, @RequestParam int priority,
                                        HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof Admin)) {
            return "redirect:/users/admin/login";
        }
        membershipService.updateRenewalPriority(requestId, priority);
        return "redirect:/membership/admin/renewal-queue";
    }

    @GetMapping("/admin/sorted-renewals")
    public String viewSortedRenewals(Model model, HttpSession session) throws IOException {
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof Admin)) {
            return "redirect:/users/admin/login";
        }
        List<RenewalRequest> sortedRequests = membershipService.getSortedRenewalRequests();
        model.addAttribute("requests", sortedRequests);
        return "sorted-renewal-list";
    }

    @GetMapping("/submit-upgrade")
    public String handleGetSubmitUpgrade(Model model) {
        model.addAttribute("message", "Please use the payment flow to submit an upgrade request.");
        return "upgrade-success";
    }
}