package com.poly.entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Subscriptions", uniqueConstraints = {
        @UniqueConstraint(columnNames = {"SubscriberId", "ChannelId"})
})
public class Subscription {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne @JoinColumn(name = "SubscriberId")
    private User subscriber; // Người đăng ký (User)

    @ManyToOne @JoinColumn(name = "ChannelId")
    private User channel; // Chủ kênh (User)

    @Temporal(TemporalType.DATE)
    @Column(name = "SubscribeDate")
    private Date subscribeDate = new Date();

    // Getter/Setter
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public User getSubscriber() { return subscriber; }
    public void setSubscriber(User subscriber) { this.subscriber = subscriber; }
    public User getChannel() { return channel; }
    public void setChannel(User channel) { this.channel = channel; }
    public Date getSubscribeDate() { return subscribeDate; }
    public void setSubscribeDate(Date subscribeDate) { this.subscribeDate = subscribeDate; }
}