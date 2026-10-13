package com.campushire.util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Enterprise Database Connection Manager using HikariCP connection pooling
 * with seamless graceful fallback to standard JDBC DriverManager.
 */
public class DBConnection {

    private static final Logger LOGGER = Logger.getLogger(DBConnection.class.getName());

    private static String dbDriver = "com.mysql.cj.jdbc.Driver";
    private static String dbUrl = "jdbc:mysql://localhost:3306/campushire_ai?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Kolkata&characterEncoding=UTF-8";
    private static String dbUser = "root";
    private static String dbPassword = "root";

    private static HikariDataSource dataSource = null;
    private static boolean poolingEnabled = false;

    static {
        loadConfiguration();
        initDataSource();
    }

    private static void loadConfiguration() {
        try (InputStream in = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in != null) {
                Properties props = new Properties();
                props.load(in);
                if (props.getProperty("db.driver") != null) dbDriver = props.getProperty("db.driver").trim();
                if (props.getProperty("db.url") != null) dbUrl = props.getProperty("db.url").trim();
                if (props.getProperty("db.username") != null) dbUser = props.getProperty("db.username").trim();
                if (props.getProperty("db.password") != null) dbPassword = props.getProperty("db.password").trim();
                LOGGER.info("DBConnection: Loaded configuration from db.properties");
            } else {
                LOGGER.warning("DBConnection: db.properties not found on classpath, using defaults.");
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Failed to load db.properties, using fallback defaults", e);
        }
    }

    private static synchronized void initDataSource() {
        try {
            Class.forName(dbDriver);
            HikariConfig config = new HikariConfig();
            config.setDriverClassName(dbDriver);
            config.setJdbcUrl(dbUrl);
            config.setUsername(dbUser);
            config.setPassword(dbPassword);
            config.setMaximumPoolSize(10);
            config.setMinimumIdle(2);
            config.setIdleTimeout(30000);
            config.setConnectionTimeout(10000);
            config.setPoolName("CampusHireHikariPool");

            dataSource = new HikariDataSource(config);
            poolingEnabled = true;
            LOGGER.info("DBConnection: HikariCP connection pool initialized successfully.");
        } catch (Throwable t) {
            LOGGER.log(Level.WARNING, "HikariCP pool init failed or class not present. Falling back to DriverManager: " + t.getMessage());
            poolingEnabled = false;
        }
    }

    /**
     * Obtains an active SQL Connection.
     */
    public static Connection getConnection() throws SQLException {
        if (poolingEnabled && dataSource != null && !dataSource.isClosed()) {
            try {
                return dataSource.getConnection();
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "Pool connection failed, attempting direct DriverManager fallback", e);
            }
        }

        // Direct fallback
        try {
            Class.forName(dbDriver);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found: " + dbDriver, e);
        }
        return DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    }

    /**
     * Safely closes one or more resources (ResultSet, Statement, Connection).
     */
    public static void closeQuietly(AutoCloseable... closeables) {
        if (closeables == null) return;
        for (AutoCloseable c : closeables) {
            if (c != null) {
                try {
                    c.close();
                } catch (Exception ignored) {
                }
            }
        }
    }

    /**
     * Shutdown pool hook for application undeploy / context destruction.
     */
    public static synchronized void shutdown() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            poolingEnabled = false;
            LOGGER.info("DBConnection: Connection pool shut down.");
        }
    }
}
