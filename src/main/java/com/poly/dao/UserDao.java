package com.poly.dao;

import com.poly.entity.User;
import com.poly.utils.JpaUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

public class UserDao {
    private EntityManager em = JpaUtils.getEntityManager();

    @Override
    protected void finalize() throws Throwable {
        em.close();
        super.finalize();
    }

    // Hàm tìm user theo ID (Username)
    public User findById(String id) {
        return em.find(User.class, id);
    }
    // ... (Giữ nguyên findById và các code khác)

    public void create(User user) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(user);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}