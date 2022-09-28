package com.bit.mini;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	@GetMapping("/")
	public String home()
	{
		return "/bit/layout/main"; //WEB-INF/layout/main.jsp�� layout1�� main�κ�
	}
	
	
	@GetMapping("/help/map")
	public String help()
	{
		return "/bit/help/googlemap"; //layout1�� main�κ��� WEB-INF/help/googlemap.jsp���� ����
	}
}
