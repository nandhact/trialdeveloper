package net.codejava.spring.controller;
import java.util.List;
 
import javax.servlet.http.HttpServletRequest;

import net.codejava.spring.dao.UserDAO;
import net.codejava.spring.model.User;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
 
/**
 * Handles requests for the application home page.
 */
@Controller
public class LoginController {
     
    @Autowired
    private UserDAO userDao;
 
    @RequestMapping("/")
    public ModelAndView handleRequest() throws Exception {
        //List<User> listUsers = userDao.list();
        ModelAndView model = new ModelAndView("login");
        //model.addObject("userList", listUsers);
        return model;
    }
     
    @RequestMapping(value = "/new", method = RequestMethod.GET)
    public ModelAndView newUser() {
        ModelAndView model = new ModelAndView("UserForm");
        model.addObject("user", new User());
        return model;      
    }

    @RequestMapping("/list")
    public ModelAndView showUser(){
        List<User> listUsers = userDao.list();
        ModelAndView model = new ModelAndView("UserList");
        model.addObject("userList", listUsers);
        return model;
    }
     
    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public ModelAndView editUser(HttpServletRequest request) {
        int userId = Integer.parseInt(request.getParameter("id"));
        User user = userDao.get(userId);
        ModelAndView model = new ModelAndView("UserForm");
        model.addObject("user", user);
        return model;      
    }
    
     
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public ModelAndView deleteUser(HttpServletRequest request) {
        int userId = Integer.parseInt(request.getParameter("id"));
        userDao.delete(userId);
        return new ModelAndView("redirect:/");     
    }
     
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public ModelAndView saveUser(@ModelAttribute User user) {
        userDao.saveOrUpdate(user);
        return new ModelAndView("redirect:/");
    }
    
    @RequestMapping(value = "/check", method = RequestMethod.POST)
    public ModelAndView check(@ModelAttribute User user) {
    	String password = user.getPassword();
        String username = user.getUsername();
        if (user != null && user.getUsername() != null & user.getPassword() != null) {
        	User userDetails = userDao.getUser(user.getUsername());
            if (userDetails.getUsername().trim().equals(username) && userDetails.getPassword().trim().equals(password)) {
            	 return new ModelAndView("redirect:/table");
            } else {

            	 return new ModelAndView("redirect:/");
            }
        } else {

        	 return new ModelAndView("redirect:/org/new");
        }
    }
    
    @RequestMapping("/table")
    public ModelAndView welcome(){
        ModelAndView model = new ModelAndView("table");
        return model;
    }
    /*@RequestMapping("/BookNew")
    public ModelAndView booknew(){
        ModelAndView model = new ModelAndView("BookNew");
        return model;
    }*/
    
    
}