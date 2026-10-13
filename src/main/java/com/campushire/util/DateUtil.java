package com.campushire.util;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 * Date and Timestamp formatting utility for views.
 */
public class DateUtil {

    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("MMM dd, yyyy");
    private static final SimpleDateFormat DATETIME_FORMAT = new SimpleDateFormat("MMM dd, yyyy hh:mm a");

    public static String formatDate(Date date) {
        if (date == null) return "N/A";
        return DATE_FORMAT.format(date);
    }

    public static String formatTimestamp(Timestamp ts) {
        if (ts == null) return "N/A";
        return DATETIME_FORMAT.format(ts);
    }

    public static Date parseSqlDate(String strDate) {
        if (strDate == null || strDate.trim().isEmpty()) return null;
        try {
            return Date.valueOf(strDate.trim());
        } catch (IllegalArgumentException e) {
            return null;
        }
    }
}
