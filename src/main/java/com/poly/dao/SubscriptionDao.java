package com.poly.dao;

import com.poly.entity.Subscription;
import com.poly.entity.User;
import com.poly.utils.JpaUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

public class SubscriptionDao {
    private EntityManager em = JpaUtils.getEntityManager();

    @Override
    protected void finalize() throws Throwable { em.close(); super.finalize(); }

    // Kiểm tra xem User đã đăng ký kênh này chưa
    public boolean isSubscribed(String subscriberId, String channelId) {
        String jpql = "SELECT COUNT(s) FROM Subscription s WHERE s.subscriber.id = :sid AND s.channel.id = :cid";
        TypedQuery<Long> query = em.createQuery(jpql, Long.class);
        query.setParameter("sid", subscriberId);
        query.setParameter("cid", channelId);
        return query.getSingleResult() > 0;
    }

    // Thao tác Đăng ký/Hủy đăng ký
    public void toggleSubscription(User subscriber, User channel) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();

            if (isSubscribed(subscriber.getId(), channel.getId())) {
                // Hủy đăng ký
                String jpql = "DELETE FROM Subscription s WHERE s.subscriber.id = :sid AND s.channel.id = :cid";
                em.createQuery(jpql)
                        .setParameter("sid", subscriber.getId())
                        .setParameter("cid", channel.getId())
                        .executeUpdate();
            } else {
                // Đăng ký mới
                Subscription sub = new Subscription();
                sub.setSubscriber(subscriber);
                sub.setChannel(channel);
                em.persist(sub);
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            e.printStackTrace();
        }
    }
}