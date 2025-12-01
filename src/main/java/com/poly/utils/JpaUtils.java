package com.poly.utils;

import jakarta.persistence.EntityManager;        // Đã đổi
import jakarta.persistence.EntityManagerFactory; // Đã đổi
import jakarta.persistence.Persistence;          // Đã đổi

public class JpaUtils {
    private static EntityManagerFactory factory;

    public static EntityManager getEntityManager() {
        if (factory == null || !factory.isOpen()) {
            factory = Persistence.createEntityManagerFactory("OECinemaPU");
        }
        return factory.createEntityManager();
    }

    public static void shutdown() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}