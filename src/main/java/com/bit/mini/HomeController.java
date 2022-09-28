package com.bit.mini;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
	@GetMapping("/")
	public String home()
	{
		return "/bit/layout/main"; //WEB-INF/layout/main.jsp가 layout1의 main부분
	}
	
	
	@GetMapping("/help/map")
	public String help()
	{
		return "/bit/help/googlemap"; //layout1의 main부분이 WEB-INF/help/googlemap.jsp으로 변경
	}
}
