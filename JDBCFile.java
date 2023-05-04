package com.company;

import java.sql.*;
import java.util.Scanner;


public class JDBCFile {
	
	private static PreparedStatement availableInstrumentStmt;
	private static PreparedStatement listAllRentedStmt;
	private static PreparedStatement addRentalOfInstrumentStmt;
	private static PreparedStatement listStudentsCurrentRentalsStmt;
	private static PreparedStatement terminateRentalStmt;
	private static PreparedStatement listAllTerminatedStmt;


	private void accessDB() {
		try (Connection connection = createConnection()) {
			connection.setAutoCommit(false);
			prepareStatements(connection);
			
			System.out.println("\nSoundgood Music School \n");
			System.out.println("Enter the number of the wanted action: ");
			System.out.println(" 1 = List all available instruments");
			System.out.println(" 2 = Show active rentals of instruments");
			System.out.println(" 3 = Show terminated rentals of instruments");
			System.out.println(" 4 = Rent an instrument");
			System.out.println(" 5 = Remove rental of instrument \n");

			while(true) {
			
				Scanner in = new Scanner(System.in);
				
				int i = in.nextInt();
				
				if(i == 1) {
					System.out.println("Enter which instrument you would like to check:");
					listAvailableInstruments(in.next());
				}
				
				if(i == 2) {
					System.out.println("Showing list of active rentals of instruments:");
					listAllRentals();
				}
				if(i==3) {
					System.out.println("Showing list of terminated rentals of instruments:");
					listTerminatedTable();
				}
	
				if(i == 4) {
					System.out.println("Enter your student_id :");
					String student_id = in.next();
					int id1 = Integer.parseInt(student_id);
					
					System.out.println("Enter the instrument_id of which you would like to rent:");
					String instrument_id = in.next();
					int id2 = Integer.parseInt(instrument_id);
					
					
					addRental(id1, id2, connection);
					listUpdatedTable();
				}
				
				if(i == 5) {
					System.out.println("Enter the instrument_id of which you would like to terminate:");
					String instrument_id = in.next();
					int id = Integer.parseInt(instrument_id);
					
					terminate(id, connection);
					listTerminatedTable();
				}
			
				//System.out.println("Thank you for using our service!");
			}
						
		} catch (ClassNotFoundException | SQLException ex) {
			ex.printStackTrace();
		}
	}

	
/* --------------------------------------------------------------------------------------------------------------------------------------------------*/	

	
	/**** MAIN ****/
	
	
	public static void main(String[] args) {
		
		new JDBCFile().accessDB();
	}

	
/* --------------------------------------------------------------------------------------------------------------------------------------------------*/	
	
	
	/**** CONNECTION ESTABLISHMENT TO MYSQL SERVER: SOUNDGOODMUSICSCHOOL ****/
	
	
	private Connection createConnection() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost:3306/SoundGoodMusicSchool","root","SoundMusic23");
	}
	
	
/* --------------------------------------------------------------------------------------------------------------------------------------------------*/	

	
	/**** METHODS CREATED WITH THE HELP OF FUNCTIONS ****/
	
	
	/* TASK 1 (choice 1) - list instruments */
	private static void listAvailableInstruments(String instrument) throws SQLException {
		ResultSet rs = availableInstruments(instrument);
		System.out.println("--------------------------------------------------");
		while(rs.next()) {
			System.out.println("Brand: " + rs.getString("brand")
            + " Price: " + rs.getString("price"));
		}
		System.out.println("--------------------------------------------------");
	}
	
	/* TASK 2 (choice 2) - rent instrument: show list of rentals with details */
	private static void listAllRentals() throws SQLException {
		ResultSet rs = listAllRented();
		while(rs.next()) {
			System.out.println("Student ID: " + rs.getString("student_id") + " Instrument ID: " + rs.getString("instrument_id"));	
		}
	}
	
	/* TASK 2 (choice 4) - rent instrument: make choice of what one want to rent */
	private static void addRental(int student_id, int instrument_id, Connection connection) throws SQLException {
		//check that student does not have more then two rentals
		if(listStudentsCurrentRental((student_id)) == 2) {
			System.out.println("Maximum rental of instrument already exceeded!");
		} else {
			addRentalOfInstrument(student_id, instrument_id, connection);
		}
		
	}
	
	/* TASK 2 (choice 4) - rent instrument: show table of rentals */
	private static void listUpdatedTable() throws SQLException {
		ResultSet rs = listAllRented();
		System.out.println("\nNew updated table content");
		System.out.println("--------------------------------------------------");
		while(rs.next()) {
			System.out.println("Student ID: " + rs.getString("student_id") + " Instrument ID: " + rs.getString("instrument_id") + " Is rented: " + rs.getString("is_rented"));
		}
	}
	
	/* TASK 3 (choice 3) - terminate rental: show table of terminated rentals */
	private static void listTerminatedTable() throws SQLException {
		ResultSet rs = listAllTerminated();
		System.out.println("\nList over terminated rentals");
		System.out.println("--------------------------------------------------");
		while(rs.next()) {
			System.out.println("Student ID: " + rs.getString("student_id") + 
					" Instrument ID: " + rs.getString("instrument_id") + " Is rented: " + rs.getString("is_rented"));
		}
	}
	
	/* TASK 3 (choice 5) - terminate rental */
	private static void terminate(int instrument_id, Connection connection) throws SQLException {
		terminateRental(instrument_id, connection);
		connection.commit();
	}
	
	
/* --------------------------------------------------------------------------------------------------------------------------------------------------*/	
	
	
	/**** FUNCTIONS HELPING NAVIGATE WITH SQL CODE ****/
	
	
	// TASK 1 - choice 1
	public static ResultSet availableInstruments(String instrument) {
		try {
			availableInstrumentStmt.setString(1, instrument); 
			return availableInstrumentStmt.executeQuery();
		} catch(SQLException ex) {
			ex.printStackTrace();
			return null;
		}
	}
	
	//TASK 2 - choice 2
	public static ResultSet listAllRented() {
		try {
			return listAllRentedStmt.executeQuery();
		} catch (SQLException ex) {
			ex.printStackTrace();
			return null;
		}
	}
	
	// TASK 2 - choice 4
	public static void addRentalOfInstrument(int student_id, int instrument_id, Connection connection) throws SQLException {
		try {
			addRentalOfInstrumentStmt.setInt(1, student_id);
			addRentalOfInstrumentStmt.setInt(2, instrument_id);
			addRentalOfInstrumentStmt.executeUpdate();
			connection.commit();
		} catch (SQLException ex) {
			connection.rollback();
			ex.printStackTrace();
		}
	}
	
	/* both choice 4 below are "baked in" addRental method */
	
	// TASK 2 - choice 4
	private static int listStudentsCurrentRental(int instrument_id) throws SQLException {
		ResultSet rs = listStudentsCurrentRentals(instrument_id);
		rs.next();
		return rs.getInt(1);
	}
	
	// TASK 2 - choice 4
	private static ResultSet listStudentsCurrentRentals(int instrument_id) {
		try {
			listStudentsCurrentRentalsStmt.setInt(1, instrument_id);
			return listStudentsCurrentRentalsStmt.executeQuery();
		} catch (SQLException ex) {
			ex.printStackTrace();
			return null;
		}
	}
	
	// TASK 3 - choice 3
	public static ResultSet listAllTerminated() {
		try {
			return listAllTerminatedStmt.executeQuery();
		} catch (SQLException ex) {
			ex.printStackTrace();
			return null;
		}
	}
	
	// TASK 3 - choice 5
	private static void terminateRental(int instrument_id, Connection connection) throws SQLException {
		try {
			terminateRentalStmt.setInt(1, instrument_id);
			terminateRentalStmt.executeUpdate();
			connection.commit();
		} catch (SQLException ex) {
			connection.rollback();
			ex.printStackTrace();
		}
	}
	
	
/* --------------------------------------------------------------------------------------------------------------------------------------------------*/	
	
	
	/**** PREPARED STATEMENTS ****/
	
	
	private static void prepareStatements(Connection connection) throws SQLException {
		
		/* choice 1: */ availableInstrumentStmt = connection.prepareStatement("select * from instrument where is_rented = 0 and type_of_instrument = ?");
		
		/* choice 2: */ listAllRentedStmt = connection.prepareStatement("select * from instrument where is_rented = 1");
		
		/* choice 3: */ listAllTerminatedStmt = connection.prepareStatement("select * from instrument where is_rented = 0");
		
		/* choice 4: */ listStudentsCurrentRentalsStmt = connection.prepareStatement("select count(*) from instrument where student_id = ?");
		
		/* choice 4: */ addRentalOfInstrumentStmt = connection.prepareStatement("update instrument set is_rented = 1, student_id = ? where instrument_id = ?");
		
		/* choice 5: */ terminateRentalStmt = connection.prepareStatement("update instrument set is_rented = 0  where instrument_id = ?");
		
		
	}
}


