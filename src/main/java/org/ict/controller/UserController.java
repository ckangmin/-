package org.ict.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.ict.domain.LoginDTO;
import org.ict.domain.UserVO;
import org.ict.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/user/*")
public class UserController {

	@Autowired
	private UserService service;
	
	@GetMapping("/login")
	public void loginGet(@ModelAttribute("dto") LoginDTO dto) {
		
	}
	
	@PostMapping("/loginPost")
	public void loginPost(LoginDTO dto, HttpSession session, Model model) throws Exception{
		UserVO vo=service.login(dto);
		if(vo== null) {
			return;
		}
		model.addAttribute("userVO", vo);
	}
	@PostMapping(value="", consumes="application/json",
										produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> register(
			@RequestBody UserVO vo){
		ResponseEntity<String> entity=null;
	try {
		service.signup(vo);
		entity=new ResponseEntity<String>(
				"SUCCESS" ,HttpStatus.OK);
	}catch(Exception e){
		e.printStackTrace();
		entity= new ResponseEntity<String>(
				e.getMessage(), HttpStatus.BAD_REQUEST);
		
	}
	return entity;
}	@GetMapping("/joinmember")
	public void hi() {
	
}
	@RequestMapping("/checkId")
		@ResponseBody
		public Map<Object,Object> idcheck(@RequestBody String uid){
		int count=0;
		Map<Object, Object>map =new HashMap<Object, Object>();
		
		count =service.ckid(uid);
		map.put("cnt", count);
		
		return map;
	}
	
}
