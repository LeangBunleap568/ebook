import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class CheckDB {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://127.0.0.1:3309/ebook-app?useSSL=false&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC",
                "root", "admin123");
            
            Statement stmt = conn.createStatement();
            
            // Try to select
            System.out.println("Checking columns in book_order:");
            ResultSet rs = stmt.executeQuery("DESCRIBE book_order");
            while(rs.next()) {
                System.out.println(rs.getString("Field") + " - " + rs.getString("Type"));
            }
            rs.close();
            
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
