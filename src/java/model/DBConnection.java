/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
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
    
    
    
    public static void main(String[] args) {
        new DBConnection();
    }
}

