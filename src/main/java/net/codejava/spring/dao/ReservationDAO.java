package net.codejava.spring.dao;

import java.util.List;

import net.codejava.spring.model.Reservation;

public interface ReservationDAO {
	    public List<Reservation> list();
	    public Reservation get(int resid);
	    public Reservation getReservation(String meeting_name);
	    public void saveOrUpdate(Reservation reservation);
	    public void delete(int resid);
	    public List<Reservation> getReservationBetween(String date1, String date2);
	 
}
