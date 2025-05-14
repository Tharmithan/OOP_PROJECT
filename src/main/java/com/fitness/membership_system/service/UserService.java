package com.fitness.membership_system.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fitness.membership_system.model.Admin;
import com.fitness.membership_system.model.PremiumMember;
import com.fitness.membership_system.model.RegularMember;
import com.fitness.membership_system.model.User;

@Service
public class UserService {

    @Value("${file.users.path}")
    private String usersFilePath;

    @Value("${file.admins.path}")
    private String adminsFilePath;

    public void registerMember(User user) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(usersFilePath, true))) {
            writer.write(String.format("%s,%s,%s,%s,%s,%s\n",
                    user.getId(), user.getUsername(), user.getPassword(), user.getEmail(), user.getPhone(), user.getMembershipType()));
        }
    }

    public void registerAdmin(Admin admin) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(adminsFilePath, true))) {
            writer.write(String.format("%s,%s,%s,%s,%s,%b\n",
                    admin.getId(), admin.getUsername(), admin.getPassword(), admin.getEmail(), admin.getPhone(), admin.isSuperAdmin()));
        }
    }

    public User findMemberByUsername(String username) throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(usersFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts[1].equals(username)) {
                    return parts[5].equals("Premium") ?
                            new PremiumMember(parts[0], parts[1], parts[2], parts[3], parts[4]) :
                            new RegularMember(parts[0], parts[1], parts[2], parts[3], parts[4]);
                }
            }
        }
        return null;
    }

    public Admin findAdminByUsername(String username) throws IOException {
        try (BufferedReader reader = new BufferedReader(new FileReader(adminsFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts[1].equals(username)) {
                    return new Admin(parts[0], parts[1], parts[2], parts[3], parts[4], Boolean.parseBoolean(parts[5]));
                }
            }
        }
        return null;
    }

    public List<User> getAllMembers() throws IOException {
        List<User> members = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(usersFilePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                User user = parts[5].equals("Premium") ?
                        new PremiumMember(parts[0], parts[1], parts[2], parts[3], parts[4]) :
                        new RegularMember(parts[0], parts[1], parts[2], parts[3], parts[4]);
                members.add(user);
            }
        }
        return members;
    }

    public void updateMember(User updatedUser) throws IOException {
        List<User> members = getAllMembers();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(usersFilePath))) {
            for (User user : members) {
                if (user.getId().equals(updatedUser.getId())) {
                    writer.write(String.format("%s,%s,%s,%s,%s,%s\n",
                            updatedUser.getId(), updatedUser.getUsername(), updatedUser.getPassword(),
                            updatedUser.getEmail(), updatedUser.getPhone(), updatedUser.getMembershipType()));
                } else {
                    writer.write(String.format("%s,%s,%s,%s,%s,%s\n",
                            user.getId(), user.getUsername(), user.getPassword(),
                            user.getEmail(), user.getPhone(), user.getMembershipType()));
                }
            }
        }
    }

    public void deleteMember(String id) throws IOException {
        List<User> members = getAllMembers();
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(usersFilePath))) {
            for (User user : members) {
                if (!user.getId().equals(id)) {
                    writer.write(String.format("%s,%s,%s,%s,%s,%s\n",
                            user.getId(), user.getUsername(), user.getPassword(),
                            user.getEmail(), user.getPhone(), user.getMembershipType()));
                }
            }
        }
    }
}