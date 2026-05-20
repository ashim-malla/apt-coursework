package com.coursework.dao;

import com.coursework.model.Booking;
import com.coursework.utilities.DBConfig;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    public int createBooking(Booking booking) {
        String sql = "INSERT INTO booking(user_id, bike_id, start_date, end_date, total_amount, booking_status) "
                + "VALUES (?, ?, ?, ?, ?, 'pending')";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, booking.getUserId());
            ps.setInt(2, booking.getBikeId());
            ps.setDate(3, Date.valueOf(booking.getStartDate()));
            ps.setDate(4, Date.valueOf(booking.getEndDate()));
            ps.setBigDecimal(5, booking.getTotalAmount());
            return ps.executeUpdate() > 0 ? 1 : 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, bk.name AS bike_name, bk.brand AS bike_brand, bk.registration_number "
                + "FROM booking b INNER JOIN bike bk ON b.bike_id = bk.bike_id "
                + "WHERE b.user_id = ? ORDER BY b.booking_id DESC";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                bookings.add(mapBooking(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return bookings;
    }

    public int countActiveBookingsByUserId(int userId) {
        String sql = "SELECT COUNT(*) FROM booking WHERE user_id = ? AND booking_status IN ('pending', 'approved')";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    private Booking mapBooking(ResultSet rs) throws Exception {
        Booking booking = new Booking();
        booking.setBookingId(rs.getInt("booking_id"));
        booking.setUserId(rs.getInt("user_id"));
        booking.setBikeId(rs.getInt("bike_id"));
        booking.setBikeName(rs.getString("bike_name"));
        booking.setBikeBrand(rs.getString("bike_brand"));
        booking.setRegistrationNumber(rs.getString("registration_number"));
        booking.setStartDate(rs.getDate("start_date").toLocalDate());
        booking.setEndDate(rs.getDate("end_date").toLocalDate());
        booking.setTotalAmount(rs.getBigDecimal("total_amount"));
        booking.setBookingStatus(rs.getString("booking_status"));
        return booking;
    }
}
