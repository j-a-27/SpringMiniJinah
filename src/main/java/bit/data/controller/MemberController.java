package bit.data.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import bit.data.dto.MemberDto;
import bit.data.service.MemberServiceInter;
import util.ChangeName;

@Controller
@RequestMapping("/member") // �����ּ� �տ� ���������� ���� ���� ����-> ���� /list�� /member/list
public class MemberController {
	
	@Autowired
	MemberServiceInter memService;
	
	@GetMapping("/list")
	public String mlist(Model model)
	{
		//�� ��� �ο����� db���� ��´�
		int totalCount =memService.getTotalCount();
		
		//��ü ��� �����͸� �����´�
		List<MemberDto> list=memService.getAllMembers();
		
		//model�� ������ �Ѵ�
		model.addAttribute("totalCount",totalCount);
		model.addAttribute("list",list);
		
		return "/bit/member/memberlist";
	}

	@GetMapping("/form")
	public String mform()
	{
		return "/bit/member/memberform";
	}
	
	@PostMapping("/insert")
	public String insert(HttpServletRequest request,MemberDto dto,MultipartFile myphoto)
	{
		//��Ĺ�� �ö� upload ���� ��� ���ϱ�
		String path=request.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println(path);
		//������ ���ϸ� ���ϱ�
		String fileName=ChangeName.getChangeFileName(myphoto.getOriginalFilename());
		//dto�� photo�� ����
		dto.setPhoto(fileName);
		
		//upload
		try {
			myphoto.transferTo(new File(path+"/"+fileName));
			
			//db insert
			memService.insertMember(dto);
			
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return "redirect:list"; //  /member/list �����ּ� ȣ��-��Ʈ�ѷ��޼��� ȣ��
	}
	
	//���̵� üũ�ϴ� �޼���
	@GetMapping("/idcheck")
	@ResponseBody
	public Map<String, Integer> getSearchId(String id)
	{
		Map<String, Integer> map=new HashMap<>();
		
		int count=memService.getSerchId(id); //���̵� ������� 1, ���� ��� 0��ȯ
		
		map.put("count", count);
		return map;
	}
	
	//��������޼���
	@PostMapping("/updatephoto")
	@ResponseBody
	public void updatePhoto(HttpServletRequest request,HttpSession session,
			int num,MultipartFile photo)
	{
		//��Ĺ�� �ö� upload ���� ��� ���ϱ�
		String path=request.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println(path);
		//���ε� �� ����� ���ϸ� ���ϱ�
		String fileName=ChangeName.getChangeFileName(photo.getOriginalFilename());
		
		//���ε�
		try {
			photo.transferTo(new File(path+"/"+fileName));
			memService.updatePhoto(num, fileName); //db���� ��������
			session.setAttribute("loginphoto", fileName); //������ ��������
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}					
	}
	
	//����
	@GetMapping("/delete")
	@ResponseBody
	public void delete(int num,HttpSession session)
	{
		memService.deleteMember(num);
		
		//�α����� ���� ������ ��缼�� �����
		session.removeAttribute("loginok");
		session.removeAttribute("loginid");
		session.removeAttribute("loginname");
		session.removeAttribute("loginphoto");
	}
	
	//�������� ����� ������ ��ȯ
	@GetMapping("/updateform")
	@ResponseBody
	public MemberDto getData(int num)
	{
		return memService.getDataByNum(num);
	}
	
	//����
	@PostMapping("/update")
	@ResponseBody
	public void update(MemberDto dto,HttpSession session)
	{
		memService.updateMember(dto);
		//���ǿ� ����� �̸��� �����ϱ�
		session.setAttribute("loginname", dto.getName());
	}
	
}











