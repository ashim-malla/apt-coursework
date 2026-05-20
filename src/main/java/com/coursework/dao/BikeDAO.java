package com.coursework.dao;

import com.coursework.model.Bike;
import com.coursework.utilities.DBConfig;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;

public class BikeDAO {

    public static final int SUCCESS = 1;
    public static final int FAILED = 0;
    public static final int DUPLICATE_REGISTRATION = 2;

    public int insertBike(Bike bike) {
        String sql = "INSERT INTO bike(name, brand, type, registration_number, price_per_day, status, description) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bike.getName());
            ps.setString(2, bike.getBrand());
            ps.setString(3, bike.getType());
            ps.setString(4, bike.getRegistrationNumber());
            ps.setBigDecimal(5, bike.getPricePerDay());
            ps.setString(6, bike.getStatus());
            ps.setString(7, bike.getDescription());
            return ps.executeUpdate() > 0 ? SUCCESS : FAILED;
        } catch (SQLIntegrityConstraintViolationException e) {
            return DUPLICATE_REGISTRATION;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return FAILED;
    }

    public boolean registrationExists(String registrationNumber) {
        String sql = "SELECT 1 FROM bike WHERE registration_number = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, registrationNumber);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean registrationExistsForAnotherBike(String registrationNumber, int bikeId) {
        String sql = "SELECT 1 FROM bike WHERE registration_number = ? AND bike_id <> ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, registrationNumber);
            ps.setInt(2, bikeId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<Bike> getAllBikes() {
        List<Bike> bikes = new ArrayList<>();
        String sql = "SELECT * FROM bike ORDER BY bike_id DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                bikes.add(mapBike(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return bikes;
    }

    public List<Bike> getAvailableBikes() {
        List<Bike> bikes = new ArrayList<>();
        String sql = "SELECT * FROM bike WHERE status = 'available' ORDER BY bike_id DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                bikes.add(mapBike(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return bikes;
    }

    public Bike getBikeById(int bikeId) {
        String sql = "SELECT * FROM bike WHERE bike_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bikeId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapBike(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public int updateBike(Bike bike) {
        String sql = "UPDATE bike SET name = ?, brand = ?, type = ?, registration_number = ?, "
                + "price_per_day = ?, status = ?, description = ? WHERE bike_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bike.getName());
            ps.setString(2, bike.getBrand());
            ps.setString(3, bike.getType());
            ps.setString(4, bike.getRegistrationNumber());
            ps.setBigDecimal(5, bike.getPricePerDay());
            ps.setString(6, bike.getStatus());
            ps.setString(7, bike.getDescription());
            ps.setInt(8, bike.getBikeId());
            return ps.executeUpdate() > 0 ? SUCCESS : FAILED;
        } catch (SQLIntegrityConstraintViolationException e) {
            return DUPLICATE_REGISTRATION;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return FAILED;
    }

    public int deleteBike(int bikeId) {
        String sql = "DELETE FROM bike WHERE bike_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bikeId);
            return ps.executeUpdate() > 0 ? SUCCESS : FAILED;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return FAILED;
    }

    public int getTotalBikes() {
        return countBySql("SELECT COUNT(*) FROM bike");
    }

    public int getAvailableBikeCount() {
        return countBySql("SELECT COUNT(*) FROM bike WHERE status = 'available'");
    }

    private int countBySql(String sql) {
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    private Bike mapBike(ResultSet rs) throws Exception {
        Bike bike = new Bike();
        bike.setBikeId(rs.getInt("bike_id"));
        bike.setName(rs.getString("name"));
        bike.setBrand(rs.getString("brand"));
        bike.setType(rs.getString("type"));
        bike.setRegistrationNumber(rs.getString("registration_number"));
        bike.setPricePerDay(rs.getBigDecimal("price_per_day"));
        bike.setStatus(rs.getString("status"));
        bike.setDescription(rs.getString("description"));
        return bike;
    }
}
