package javaapplication1;
import java.sql.*;
import java.io.*;
import java.util.*;
class JavaApplication1{

   static {
      try {
         // register the driver with DriverManager
         Class.forName("org.postgresql.Driver").newInstance();
      } catch (Exception e) {
         e.printStackTrace();
      }
   }

   public static void main(String argv[]) {
      Connection con = null;
	try{


            // Connect to DB. URL is jdbc:postgresql:DB
            String url = "jdbc:postgresql://127.0.0.1/postgres";
            String userid = "postgres";
            String passwd = "toto";
            con = DriverManager.getConnection(url, userid, passwd);
            
            System.out.println("...sono pronto per iniziare. Vai!");

            Statement stmt = con.createStatement();
            stmt.executeUpdate("set search_path to ippica");
            stmt.executeUpdate("drop table if exists ippodromo cascade");
            stmt.executeUpdate("create table ippodromo(nome varchar primary key,"
            + "capienza integer,"
            +"citta varchar,"
            +"nazione varchar)");
           
            stmt.executeUpdate("alter table gara add column livello varchar");
            // Punto 1. Definizione tabella: Da completare.
		
            // Punto 2. Da completare.

            //Chiusura oggetti: Da completare.
            System.out.println("...chiudo tutto!");
            stmt.close();
            con.close();
        } catch( Exception e ) {
         e.printStackTrace();
        }
   }
}



