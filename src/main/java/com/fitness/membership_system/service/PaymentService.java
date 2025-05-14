package com.fitness.membership_system.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.fitness.membership_system.model.Payment;

@Service
public class PaymentService {

    private static final String PAYMENT_FILE = "payments.txt";

    public void savePayment(Payment payment) {
        List<Payment> payments = getAllPayments();
        // Generate a unique paymentId
        String newPaymentId = String.valueOf(getNextPaymentId(payments));
        payment.setId(newPaymentId);
        payments.add(payment);
        saveToFile(payments);
    }

    public List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        File file = new File(PAYMENT_FILE);
        if (!file.exists()) {
            try {
                file.createNewFile();
                saveToFile(new ArrayList<>());
            } catch (IOException ex) {
                ex.printStackTrace();
            }
            return payments;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(PAYMENT_FILE))) {
            String line;
            // Skip header if it exists
            reader.readLine();
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 6) {  // Updated to expect 6 fields (paymentId, userId, username, amount, method, status)
                    Payment payment = new Payment(
                            parts[0].trim(),  // paymentId
                            parts[1].trim(),  // userId
                            parts[2].trim(),  // username
                            Double.parseDouble(parts[3].trim()),  // amount
                            parts[4].trim(),  // method
                            parts[5].trim()   // status
                    );
                    payments.add(payment);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return payments;
    }

    public Payment getPaymentById(String id) {
        return getAllPayments().stream()
                .filter(p -> p.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    public void updatePayment(Payment payment) {
        List<Payment> payments = getAllPayments();
        for (int i = 0; i < payments.size(); i++) {
            if (payments.get(i).getId().equals(payment.getId())) {
                payments.set(i, payment);
                break;
            }
        }
        saveToFile(payments);
    }

    private void saveToFile(List<Payment> payments) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(PAYMENT_FILE))) {
            // Write header
            writer.write("Payment ID,User ID,Username,Amount,Method,Status\n");
            for (Payment payment : payments) {
                writer.write(String.format("%s,%s,%s,%.2f,%s,%s%n",
                        payment.getId(),
                        payment.getUserId(),
                        payment.getUsername(),
                        payment.getAmount(),
                        payment.getMethod(),
                        payment.getStatus()));
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private int getNextPaymentId(List<Payment> payments) {
        if (payments.isEmpty()) {
            return 1;
        }
        return payments.stream()
                .map(p -> Integer.parseInt(p.getId()))
                .max(Integer::compareTo)
                .orElse(0) + 1;
    }
}