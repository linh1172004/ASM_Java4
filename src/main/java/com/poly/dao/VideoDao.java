package com.poly.dao;

import com.poly.entity.Video;
import com.poly.utils.JpaUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class VideoDao {
    private EntityManager em = JpaUtils.getEntityManager();

    @Override
    protected void finalize() throws Throwable {
        em.close();
        super.finalize();
    }

    // 1. Lấy tất cả video
    public List<Video> findAll() {
        String jpql = "SELECT v FROM Video v";
        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
        return query.getResultList();
    }

    // 2. Tìm video theo ID
    public Video findById(String id) {
        return em.find(Video.class, id);
    }

    // 3. THÊM MỚI VIDEO (Hàm bạn đang thiếu)
    public void create(Video video) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(video);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            e.printStackTrace();
        }
    }

    // 4. CẬP NHẬT VIDEO (Hàm bạn đang thiếu)
    public void update(Video video) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(video);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            e.printStackTrace();
        }
    }

    // 5. XÓA VIDEO (Hàm bạn đang thiếu)
    public void delete(String id) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            Video video = em.find(Video.class, id);
            if (video != null) {
                em.remove(video);
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            e.printStackTrace();
        }
    }

    public List<Video> findByUser(String userId) {
        String jpql = "SELECT v FROM Video v WHERE v.uploader.id = :uid AND v.active = true ORDER BY v.views DESC";
        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
        query.setParameter("uid", userId);
        return query.getResultList();
    }
    public List<Video> findByKeyword(String keyword) {
        String jpql = "SELECT v FROM Video v WHERE v.title LIKE :keyword AND v.active = true";
        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
        query.setParameter("keyword", "%" + keyword + "%");
        return query.getResultList();
    }

}