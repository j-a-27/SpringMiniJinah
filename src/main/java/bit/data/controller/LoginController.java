package bit.data.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import bit.data.dto.MemberDto;
import bit.data.service.MemberServiceInter;

@Controller
@RequestMapping("/member")
public class LoginController {
	
	@Autowired
	MemberServiceInter memService;
	
	@GetMapping("/login")
	@ResponseBody
	public Map<String, String> loginprocess(String id,String pass,HttpSession session)
	{
		Map<String, String> map=new HashMap<>();
		int result=memService.getIdPassCheck(id, pass);
		if(result==1) //���̵�� �н��� ��� �´� ���
		{
			//���� �ð� ����
			session.setMaxInactiveInterval(60*60*4); //4�ð�
			
			//�α����� ���̵� ���� ������ �� ���ǿ� ����
			MemberDto mdto=memService.getDataById(id);
			session.setAttribute("loginok", "yes"); // �ڿ� "yes" �� �������̾ �������. null���� �ƴ����� �����Ұ��̹Ƿ�
			session.setAttribute("loginid", id);
			session.setAttribute("loginname", mdto.getName());
			session.setAttribute("loginphoto", mdto.getPhoto());
		}
		map.put("result", result==1?"success":"fail");
		
		return map;
	}
	
	@GetMapping("/logout")
	@ResponseBody
	public void logout(HttpSession session)
	{
		//�α׾ƿ��� ���ŵǾ���� ����
		session.removeAttribute("loginok");
		session.removeAttribute("loginid");
	}
	

}











