package com.fitness.membership_system.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fitness.membership_system.model.BasicPlan;
import com.fitness.membership_system.model.MembershipPlan;
import com.fitness.membership_system.model.PremiumPlan;
import com.fitness.membership_system.model.RenewalQueue;
import com.fitness.membership_system.model.RenewalRequest;
import com.fitness.membership_system.model.StandardPlan;

@Service
public class MembershipService {

    @Value("${file.plans.path}")
    private String plansFilePath;

    @Value("${file.renewals.path}")
    private String renewalsFilePath;

    public void addPlan(MembershipPlan plan) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(plansFilePath, true))) {
            writer.write(String.format("%s,%s,%.2f,%d,%s\n",
                    plan.getId(), plan.getName(), plan.getPrice(), plan.getDurationMonths(), plan.getAccessRights()));
        }
    }

    public List<MembershipPlan> getAllPlans() throws IOException {
        List<MembershipPlan> plans = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(plansFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                MembershipPlan plan;
                switch (parts[1]) {
                    case "Basic":
                        plan = new BasicPlan(parts[0], Double.parseDouble(parts[2]), Integer.parseInt(parts[3]));
                        break;
                    case "Standard":
                        plan = new StandardPlan(parts[0], Double.parseDouble(parts[2]), Integer.parseInt(parts[3]));
                        break;
                    case "Premium":
                        plan = new PremiumPlan(parts[0], Double.parseDouble(parts[2]), Integer.parseInt(parts[3]));
                        break;
                    default:
                        continue;
                }
                plan.setAccessRights(parts[4]);
                plans.add(plan);
            }
        }
        return plans;
    }

    public MembershipPlan findPlanById(String id) throws IOException {
        return getAllPlans().stream()
                .filter(plan -> plan.getId().equals(id))
                .findFirst()
                .orElse(null);
    }

    public void updatePlan(MembershipPlan updatedPlan) throws IOException {
        List<MembershipPlan> plans = getAllPlans();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(plansFilePath))) {
            for (MembershipPlan plan : plans) {
                if (plan.getId().equals(updatedPlan.getId())) {
                    writer.write(String.format("%s,%s,%.2f,%d,%s\n",
                            updatedPlan.getId(), updatedPlan.getName(), updatedPlan.getPrice(),
                            updatedPlan.getDurationMonths(), updatedPlan.getAccessRights()));
                } else {
                    writer.write(String.format("%s,%s,%.2f,%d,%s\n",
                            plan.getId(), plan.getName(), plan.getPrice(),
                            plan.getDurationMonths(), plan.getAccessRights()));
                }
            }
        }
    }

    public void deletePlan(String id) throws IOException {
        List<MembershipPlan> plans = getAllPlans();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(plansFilePath))) {
            for (MembershipPlan plan : plans) {
                if (!plan.getId().equals(id)) {
                    writer.write(String.format("%s,%s,%.2f,%d,%s\n",
                            plan.getId(), plan.getName(), plan.getPrice(),
                            plan.getDurationMonths(), plan.getAccessRights()));
                }
            }
        }
    }

    public void enqueueRenewalRequest(RenewalRequest request) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(renewalsFilePath, true))) {
            writer.write(String.format("%s,%s,%s,%s,%s,%d\n",
                    request.getRequestId(), request.getUserId(), request.getPlanId(),
                    request.getRequestDate().toString(), request.getLastRenewalDate().toString(),
                    request.getPriority()));
        }
    }

    public RenewalQueue getRenewalQueue() throws IOException {
        RenewalQueue queue = new RenewalQueue();
        try (BufferedReader reader = new BufferedReader(new FileReader(renewalsFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                RenewalRequest request = new RenewalRequest(
                        parts[0], parts[1], parts[2],
                        LocalDate.parse(parts[3]), LocalDate.parse(parts[4]), Integer.parseInt(parts[5]));
                queue.enqueue(request);
            }
        }
        return queue;
    }

    public void dequeueRenewalRequest() throws IOException {
        RenewalQueue queue = getRenewalQueue();
        queue.dequeue();
        saveQueueToFile(queue);
    }

    public void updateRenewalPriority(String requestId, int newPriority) throws IOException {
        RenewalQueue queue = getRenewalQueue();
        queue.updatePriority(requestId, newPriority);
        saveQueueToFile(queue);
    }

    private void saveQueueToFile(RenewalQueue queue) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(renewalsFilePath))) {
            for (RenewalRequest request : queue.getQueue()) {
                writer.write(String.format("%s,%s,%s,%s,%s,%d\n",
                        request.getRequestId(), request.getUserId(), request.getPlanId(),
                        request.getRequestDate().toString(), request.getLastRenewalDate().toString(),
                        request.getPriority()));
            }
        }
    }

    public List<RenewalRequest> getSortedRenewalRequests() throws IOException {
        List<RenewalRequest> requests = getRenewalQueue().getQueue();
        // Insertion Sort by lastRenewalDate
        for (int i = 1; i < requests.size(); i++) {
            RenewalRequest key = requests.get(i);
            int j = i - 1;
            while (j >= 0 && requests.get(j).getLastRenewalDate().isAfter(key.getLastRenewalDate())) {
                requests.set(j + 1, requests.get(j));
                j--;
            }
            requests.set(j + 1, key);
        }
        return requests;
    }
}