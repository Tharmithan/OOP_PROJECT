package com.fitness.membership_system.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fitness.membership_system.model.Admin;
import com.fitness.membership_system.model.Payment;
import com.fitness.membership_system.model.User;
import com.fitness.membership_system.service.PaymentService;

import jakarta.servlet.http.HttpSession;

@Controller
public class PaymentController {

    private final PaymentService paymentService;

    @Autowired
    public PaymentController(PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    @GetMapping("/users/payment")
    public String showPaymentForm(HttpSession session, Model model) {
        System.out.println("Session user attribute: " + session.getAttribute("user")); // Debug log
        if (session.getAttribute("user") == null) {
            System.out.println("User not logged in, redirecting to login page.");
            return "redirect:/users/login";
        }
        model.addAttribute("user", session.getAttribute("user"));
        return "payment";
    }

    @PostMapping("/users/payment")
    public String processPayment(@RequestParam String amount, @RequestParam String method,
            HttpSession session, RedirectAttributes redirectAttributes) {
        System.out.println("Received payment method: " + method);
        System.out.println("Session user: " + session.getAttribute("user"));
        if (session.getAttribute("user") == null) {
            return "redirect:/users/login";
        }
        User user = (User) session.getAttribute("user");
        String userId = user.getId();
        // paymentId will be set by PaymentService, passing a placeholder "0"
        Payment payment = new Payment("0", userId, user.getUsername(), Double.parseDouble(amount), method, "Pending");
        paymentService.savePayment(payment);
        redirectAttributes.addFlashAttribute("message", "Payment submitted successfully. Awaiting admin approval.");
        return "payment-success";
    }

    @GetMapping("/admin/payment-management")
    public String showPaymentManagement(HttpSession session, Model model) {
        System.out.println("Session user attribute for admin: " + session.getAttribute("user")); // Debug log
        User user = (User) session.getAttribute("user");
        if (user == null || !(user instanceof Admin)) {
            System.out.println("Admin not logged in or not authorized, redirecting to login page.");
            return "redirect:/users/login";
        }
        List<Payment> payments = paymentService.getAllPayments();
        model.addAttribute("payments", payments);
        return "payment-management";
    }

    @PostMapping("/admin/payment-action")
    public String processPaymentAction(@RequestParam String paymentId, @RequestParam String action,
            RedirectAttributes redirectAttributes) {
        Payment payment = paymentService.getPaymentById(paymentId);
        if (payment != null) {
            if ("approve".equals(action)) {
                payment.setStatus("Approved");
            } else if ("reject".equals(action)) {
                payment.setStatus("Rejected");
            }
            paymentService.updatePayment(payment);
            redirectAttributes.addFlashAttribute("message", "Payment " + action + "d successfully.");
        }
        return "redirect:/admin/payment-management";
    }

    @GetMapping("/users/card-details")
    public String showCardDetails(@RequestParam String amount, @RequestParam String method,
            HttpSession session, Model model) {
        if (session.getAttribute("user") == null) {
            return "redirect:/users/login";
        }
        model.addAttribute("amount", amount);
        model.addAttribute("method", method);
        return "card-details";
    }

    @PostMapping("/users/process-card-payment")
    public String processCardPayment(@RequestParam String amount, @RequestParam String method,
            @RequestParam String cardNumber, @RequestParam String expiryDate, @RequestParam String cvv,
            HttpSession session, RedirectAttributes redirectAttributes) {
        if (session.getAttribute("user") == null) {
            return "redirect:/users/login";
        }
        User user = (User) session.getAttribute("user");
        String userId = user.getId();
        // paymentId will be set by PaymentService, passing a placeholder "0"
        Payment payment = new Payment("0", userId, user.getUsername(), Double.parseDouble(amount), method, "Pending");
        paymentService.savePayment(payment);
        redirectAttributes.addFlashAttribute("message", "Payment submitted successfully. Awaiting admin approval.");
        return "payment-success";
    }
}