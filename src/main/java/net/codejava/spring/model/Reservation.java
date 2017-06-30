package net.codejava.spring.model;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "RESERVATION_DETL")
public class Reservation {
   private int resid;
   private int userid;
   private String date;
   private String start_time;
   private int duration;
   private String meeting_name;
   @Id
   @GeneratedValue
   @Column(name = "RES_ID")
public int getResid() {
	return resid;
}
public void setResid(int resid) {
	this.resid = resid;
}
public int getUserid() {
	return userid;
}
public void setUserid(int userid) {
	this.userid = userid;
}
public String getMeeting_name() {
	return meeting_name;
}
public void setMeeting_name(String meeting_name) {
	this.meeting_name = meeting_name;
}
public String getDate() {
	return date;
}
public void setDate(String date) {
	this.date = date;
}
public String getStart_time() {
	return start_time;
}
public void setStart_time(String start_time) {
	this.start_time = start_time;
}
public int getDuration() {
	return duration;
}
public void setDuration(int duration) {
	this.duration = duration;
}

}
   