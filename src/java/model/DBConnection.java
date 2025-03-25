/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author pdatt
 */
public class DBConnection {
    public Connection conn=null;
    public  DBConnection(String URL,String userName,String password){
        try {
            // URL: String connection: Server, DB, socket
            // userName, password: accout of SQL Server
            //call Driver
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            // call connection
            conn=DriverManager.getConnection(URL, userName, password);
            System.out.println("connected");
        } catch (ClassNotFoundException ex) {
            ex.printStackTrace();
        } catch (SQLException ex) {
             ex.printStackTrace();
            //Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public DBConnection(){
        this("jdbc:sqlserver://localhost:1433;databaseName=swp391",
                "sa","123456");
    }
    
     public ResultSet getData(String sql) {
        ResultSet rs = null;
        try {
            Statement statement = conn.createStatement(
                ResultSet.TYPE_SCROLL_INSENSITIVE,
                ResultSet.CONCUR_READ_ONLY
            );
            rs = statement.executeQuery(sql);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return rs;
    }
    
    public static void main(String[] args) {
        new DBConnection();
    }
}
