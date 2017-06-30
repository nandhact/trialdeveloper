package net.codejava.spring.dao;
 
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import net.codejava.spring.model.Conference;
import net.codejava.spring.model.Reservation;
 
@Repository
public class ReservationDAOImpl implements ReservationDAO {
    @Autowired
    private SessionFactory sessionFactory;
 
    public ReservationDAOImpl() {
         
    }
     
    public ReservationDAOImpl(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
 
    @Override
    @Transactional
    public List<Reservation> list() {
        @SuppressWarnings("unchecked")
        List<Reservation> listReservation = (List<Reservation>) sessionFactory.getCurrentSession()
                .createCriteria(Reservation.class)
                .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).list();
 
        return listReservation;
    }
 
    @Override
    @Transactional
    public void saveOrUpdate(Reservation reservation) {
        sessionFactory.getCurrentSession().saveOrUpdate(reservation);
    }
 
    @Override
    @Transactional
    public void delete(int resid) {
    	Reservation reservationToDelete = new Reservation();
        reservationToDelete.setResid(resid);
        sessionFactory.getCurrentSession().delete(reservationToDelete);
    }
    @Override
    @Transactional
    public List<Conference> getConfRooms(){
        @SuppressWarnings("unchecked")
    	List<Conference> listConference = (List<Conference>) sessionFactory.getCurrentSession()
                .createCriteria(Conference.class)
                .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY).list();
 
        return listConference;
    }
    @Override
    @Transactional
    public Reservation get(int resid) {
        String hql = "from Reservation where res_id=" + resid;
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
         
        @SuppressWarnings("unchecked")
        List<Reservation> listReservation = (List<Reservation>) query.list();
         
        if (listReservation != null && !listReservation.isEmpty()) {
            return listReservation.get(0);
        }
         
        return null;
    }
    @Override
    @Transactional
    public Reservation getReservation(String meeting_name) {
        String hql = "from Reservation where meeting_name='"+meeting_name+"'";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
         
        @SuppressWarnings("unchecked")
        List<Reservation> listReservation = (List<Reservation>) query.list();
         
        if (listReservation != null && !listReservation.isEmpty()) {
            return listReservation.get(0);
        }
         
        return null;
    }
    
    @SuppressWarnings("unchecked")
	@Override
    @Transactional
    public List<Reservation> getReservationBetween(String date1, String date2) {
        String hql = "from Reservation where date>='"+date1+"'and date<='"+date2+"'";
        Query query = sessionFactory.getCurrentSession().createQuery(hql);
         
        List<Reservation> listReservation = (List<Reservation>) query.list();
         
        if (listReservation != null && !listReservation.isEmpty()) {
            return listReservation;
        }
         
        return null;
    }

}
