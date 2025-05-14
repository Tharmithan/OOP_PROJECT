package com.fitness.membership_system.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fitness.membership_system.model.CheckIn;
import com.fitness.membership_system.model.GymCheckIn;
import com.fitness.membership_system.model.VirtualClassCheckIn;

@Service
public class CheckInService {

    @Value("${file.checkins.path}")
    private String checkinsFilePath;

    public void logCheckIn(CheckIn checkIn) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(checkinsFilePath, true))) {
            writer.write(checkIn.logCheckIn());
            writer.newLine();
        }
    }

    public List<CheckIn> getAllCheckIns() throws IOException {
        List<CheckIn> checkIns = new ArrayList<>();
        File file = new File(checkinsFilePath);
        if (!file.exists()) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(checkinsFilePath))) {
                writer.write("CheckIn ID|User ID|Type|CheckIn Date|Virtual Class ID\n");
            }
            return checkIns;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            reader.readLine(); // Skip header
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                int checkInId = Integer.parseInt(parts[0].trim());
                String userId = parts[1].trim();
                String type = parts[2].trim();
                String dateStr = parts[3].trim().replace(" ", "T");
                // Remove colon and everything after seconds if present (handles nanoseconds and
                // timezone)
                int tIndex = dateStr.indexOf("T");
                int colonIndex = dateStr.indexOf(":", tIndex + 3); // after HH:mm:ss
                if (colonIndex != -1 && colonIndex > tIndex + 6) {
                    dateStr = dateStr.substring(0, colonIndex);
                }
                LocalDateTime checkInDate = LocalDateTime.parse(dateStr);

                if ("Gym".equals(type)) {
                    checkIns.add(new GymCheckIn(checkInId, userId, checkInDate));
                } else if ("Virtual".equals(type)) {
                    int virtualClassId = Integer.parseInt(parts[4].trim());
                    checkIns.add(new VirtualClassCheckIn(checkInId, userId, checkInDate, virtualClassId));
                }
            }
        }
        return checkIns;
    }

    public void updateCheckIn(int checkInId, CheckIn updatedCheckIn) throws IOException {
        List<CheckIn> checkIns = getAllCheckIns();
        List<CheckIn> updatedList = new ArrayList<>();
        for (CheckIn checkIn : checkIns) {
            if (checkIn.getCheckInId() == checkInId) {
                updatedList.add(updatedCheckIn);
            } else {
                updatedList.add(checkIn);
            }
        }
        writeAllCheckIns(updatedList);
    }

    public void deleteOldRecords() throws IOException {
        List<CheckIn> checkIns = getAllCheckIns();
        LocalDateTime sixMonthsAgo = LocalDateTime.now().minusMonths(6);
        List<CheckIn> filteredList = new ArrayList<>();
        for (CheckIn checkIn : checkIns) {
            if (checkIn.getCheckInDate().isAfter(sixMonthsAgo)) {
                filteredList.add(checkIn);
            }
        }
        writeAllCheckIns(filteredList);
    }

    private void writeAllCheckIns(List<CheckIn> checkIns) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(checkinsFilePath))) {
            writer.write("CheckIn ID|User ID|Type|CheckIn Date|Virtual Class ID\n");
            for (CheckIn checkIn : checkIns) {
                writer.write(checkIn.logCheckIn());
                writer.newLine();
            }
        }
    }

    public int getNextCheckInId() throws IOException {
        List<CheckIn> checkIns = getAllCheckIns();
        return checkIns.isEmpty() ? 1 : checkIns.get(checkIns.size() - 1).getCheckInId() + 1;
    }
}