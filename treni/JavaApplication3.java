/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javaapplication3;

import java.sql.*;

/**
 *
 * @author kaisersource
 */
public class JavaApplication3 {
/**
 *
 * @author kaisersource
 */
 static {
        try {
            // register the driver with DriverManager
            Class.forName("org.postgresql.Driver").newInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
 
    public static void main(String args[]) {
        Connection con = null;
        try {
 
        
            String url = "jdbc:postgresql://127.0.0.1:5432/postgres";
            String userid = "postgres";
            String passwd = "Jobaka31";
            con = DriverManager.getConnection(url, userid, passwd);
            System.out.println("...sono pronto per iniziare!");
            Statement st=con.createStatement();
            st.executeUpdate("set search_path to treni");
            st.executeUpdate("alter table citta drop column if exists numstazioni cascade");
            st.executeUpdate("alter table citta add column numstazioni integer");
            
            ResultSet rs=st.executeQuery("select citta,count(cod_stazione) as numstazioni from stazione group by citta");
            PreparedStatement ps=con.prepareStatement("update citta set numstazioni=? where nome=?");
            while(rs.next()){
                
               String citta=rs.getString("citta");
               int numstazioni=rs.getInt("numstazioni");
               ps.setInt(1,numstazioni); 
               ps.setString(2, citta);
               ps.execute(); // <---- MAREMMA TROIA L'EXECUTE
                
            }
          
//aggiunge alla relazione citta l'attributo numstazioni relativo
//al numero di stazioni della relativa città
          
            ps.close();
            rs.close();
            st.close();
            con.close();
  } catch (Exception e) {
            e.printStackTrace();
            
        }

   }
}
