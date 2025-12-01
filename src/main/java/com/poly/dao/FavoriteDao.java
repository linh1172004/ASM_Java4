package com.poly.dao;

import com.poly.entity.Favorite;
import com.poly.entity.User;
import com.poly.entity.Video;
import com.poly.utils.JpaUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class FavoriteDao {
    private EntityManager em = JpaUtils.getEntityManager();

    // Tìm đối tượng Favorite cụ thể
    private Favorite findFavorite(String userId, String videoId) {
        String jpql = "SELECT f FROM Favorite f WHERE f.user.id = :uid AND f.video.id = :vid";
        TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
        query.setParameter("uid", userId);
        query.setParameter("vid", videoId);
        List<Favorite> results = query.getResultList();
        return results.isEmpty() ? null : results.get(0);
    }

    // Kiểm tra xem User đã Like video này chưa
    public boolean isFavorited(String userId, String videoId) {
        return findFavorite(userId, videoId) != null;
    }

    // Toggle (Like/Unlike)
    public void toggleFavorite(User user, Video video) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();

            Favorite existingFavorite = findFavorite(user.getId(), video.getId());

            if (existingFavorite != null) {
                // Unlike (Xóa)
                em.remove(existingFavorite);
            } else {
                // Like (Thêm)
                Favorite favorite = new Favorite();
                favorite.setUser(user);
                favorite.setVideo(video);
                em.persist(favorite);
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            e.printStackTrace();
            throw new RuntimeException("Lỗi Toggle Favorite: " + e.getMessage());
        }
    }

    // Hàm mới: Lấy danh sách video yêu thích (cho báo cáo Admin)
    public List<Video> findFavoriteVideosByUserId(String userId) {
        String jpql = "SELECT f.video FROM Favorite f WHERE f.user.id = :uid";
        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
        query.setParameter("uid", userId);
        return query.getResultList();
    }
}