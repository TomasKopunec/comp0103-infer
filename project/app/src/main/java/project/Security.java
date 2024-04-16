package project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Security {
    public static void main(String[] args) throws Exception {
        // Inputs from the user
        String username = args [0];
        String password = args [1];
        // Vulnerable SQL query !
        String query = " SELECT * FROM users WHERE username ='" + username + "' AND password ='" + password + "'";
        // Establish database connection
        Connection connection = DriverManager.getConnection("jdbc:mysql:// localhost :3306/ database "," admin ", " pass ") ;
        // Execute query
        Statement statement = connection.createStatement () ;
        ResultSet resultSet = statement.executeQuery ( query ) ;
        // ...
        resultSet.close();
        statement.close();
        connection.close();
    }
}
