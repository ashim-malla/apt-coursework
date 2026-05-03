package com.coursework.dao;

import com.coursework.utilities.DBConfig;

import java.sql.*;

public class UserDAO {

    public int insertUser(String name, String password, String email,
                          String phone, String license, String role) {

        String sql = "INSERT INTO user(name, email, password, phone, license_number, role) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, phone);
            ps.setString(5, license);
            ps.setString(6, role);

            return ps.executeUpdate() > 0 ? 1 : 0;

        } catch (SQLIntegrityConstraintViolationException e) {
            return 2; // duplicate email/user
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}