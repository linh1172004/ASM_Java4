import com.poly.utils.JpaUtils;
import jakarta.persistence.EntityManager; // Đã đổi

public class TestConnection {
    public static void main(String[] args) {
        try {
            EntityManager em = JpaUtils.getEntityManager();
            System.out.println("KẾT NỐI THÀNH CÔNG VỚI HIBERNATE 6!");
            em.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}