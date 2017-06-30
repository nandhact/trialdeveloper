package net.codejava.spring.controller;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import net.codejava.spring.dao.ReservationDAO;
import net.codejava.spring.dao.ReservationDAOImpl;
import net.codejava.spring.model.Conference;
import net.codejava.spring.model.Reservation;
@Controller
public class ReservationController {
	@Autowired
	private ReservationDAO reservationDao;
	//@RequestMapping(value="/greeting", method = RequestMethod.GET)
	@RequestMapping (value="/profile",method=(RequestMethod.GET), produces=MediaType.APPLICATION_JSON_VALUE)
   // public ResponseEntity<?> profile(@RequestParam(value="start_date") String start_date,@RequestParam(value="end_date") String end_date) {
	 public ResponseEntity<?> profile() {
    	//reservationDao = new ReservationDAOImpl();
    	List<Reservation> listReservations = reservationDao.getReservationBetween("21-06-2017", "25-06-2017");
       //return listReservations;
    	JSONArray arr = new JSONArray();
    	for(Reservation res : listReservations){
    		JSONObject json = new JSONObject();
    		SimpleDateFormat frmt = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        	try {
				json.put("startDate", frmt.parse(res.getDate()+" "+res.getStart_time()).getTime());
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        	json.put("duration", res.getDuration());
        	arr.add(json);
    	}
    	JSONObject json = new JSONObject();
    	json.put("ReservationList", arr);
    	return new ResponseEntity("apiStatus("+json.toString()+")", HttpStatus.OK);
    }

	@RequestMapping (value="/listConfRoom",method=(RequestMethod.GET), produces=MediaType.APPLICATION_JSON_VALUE)
	 	 public ResponseEntity<?> listConfRoom() {
	    	List<Conference> listConfRooms = reservationDao.getConfRooms();
	    	JSONArray arr = new JSONArray();
	    	for(Conference res : listConfRooms){
	    		JSONObject json = new JSONObject();
	    		json.put("id", res.getConid());
				json.put("name", res.getRoom_name());
	        	arr.add(json);
	    	}
	    	JSONObject json = new JSONObject();
	    	json.put("RoomList", arr);
	    	return new ResponseEntity("apiStatus("+json.toString()+")", HttpStatus.OK);
	    }
	
	@RequestMapping(value="/BookNew", method = RequestMethod.GET)
    public ModelAndView booknew(){
		ModelAndView model = new ModelAndView("BookNew");
        model.addObject("reservation", new Reservation());
        return model;
    }
	@RequestMapping("/BookList")
    public ModelAndView showReservation(HttpServletRequest request){
		String date1 = request.getParameter("start_date");
		String date2 = request.getParameter("end_date");
		List<Reservation> listReservations = reservationDao.getReservationBetween(date1, date2);
        ModelAndView model = new ModelAndView("ReservationList");
        model.addObject("reservationList", listReservations);
        return model;
    }
	
	@RequestMapping(value = "/BookEdit", method = RequestMethod.GET)
    public ModelAndView editReservation(HttpServletRequest request) {
        int resid = Integer.parseInt(request.getParameter("resid"));
        Reservation reservation = reservationDao.get(resid);
        ModelAndView model = new ModelAndView("BookNew");
        model.addObject("reservation", reservation);
        return model;      
    }
	
	@RequestMapping(value = "/BookDelete", method = RequestMethod.GET)
    public ModelAndView deleteReservation(HttpServletRequest request) {
        int resId = Integer.parseInt(request.getParameter("resid"));
        reservationDao.delete(resId);
        return new ModelAndView("redirect:/table");     
    }
	
    @RequestMapping(value = "/BookSave", method = RequestMethod.POST)
    public ModelAndView saveReservation(@ModelAttribute Reservation reservation) {
    	reservationDao.saveOrUpdate(reservation);
        return new ModelAndView("redirect:/table");
    }
}
