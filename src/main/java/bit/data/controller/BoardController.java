package bit.data.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import bit.data.dto.BoardDto;
import bit.data.service.BoardAnswerServiceInter;
import bit.data.service.BoardServiceInter;
import bit.data.service.MemberServiceInter;
import util.ChangeName;

@Controller
public class BoardController {
	
	@Autowired
	BoardServiceInter boardService;
	
	@Autowired
	BoardAnswerServiceInter answerService;
	
	@Autowired
	MemberServiceInter memberService;
	
	@GetMapping("/board/list")
	public String board(
			/* �Է°��� ���� ��츦 ����Ͽ� default���� �ְų� required=false�� �����������. ���� �ϳ� ������ �Է°������� ������*/
			@RequestParam(defaultValue="1") int currentPage, /*null�ϰ�� �⺻�������� 1��*/
			@RequestParam(value = "searchcolumn", required = false) String sc, /*required = false: ���� ������� null���� �Ѿ*/
			@RequestParam(value = "searchword", required = false) String sw,
			Model model
			)
	{
		//����¡ ó���� �ʿ��� ������
		//��ü ����
		int totalCount=boardService.getTotalCount(sc,sw);
		int perPage=5;//���������� ������ ���� ����
		int perBlock=3;//�Ѻ��� ������ �������� ����
		int startNum;//db���� ������ ���� ���۹�ȣ(mysql�� ù���� 0��,����Ŭ�� 1��)
		int startPage;//������ ������ ����������
		int endPage;//�� ���� ������ ��������
		int totalPage;//�� ��������
		int no;//�� �������� ����� ���۹�ȣ
		
		//�� ���������� ���Ѵ�
		//�ѱ��ǰ���/���������纸���������� ����(7/5=1)
		//�������� 1�̶� ������ ������ 1������ �߰�(1+1=2�������� �ʿ�)
		totalPage=totalCount/perPage+(totalCount%perPage==0?0:1);
		
		//�� ���� ������ ����������
		//perBlock=5 �ϰ�� ������������ 1~5 �ϰ��� ������������ 1, ���������� 5
		//���� ������������ 13 �ϰ��� ������������ 11, ���������� 15
		startPage=(currentPage-1)/perBlock*perBlock+1;
		endPage=startPage+perBlock-1;
		//������������ 23���ϰ�� ������ ���� ���������� 25�� �ƴ϶� 23�̶���Ѵ�
		if(endPage>totalPage)
			endPage=totalPage;
		
		//�� ���������� ������ ���۹�ȣ
		//��: 1������->0, 2������:5, 3������ : 10...
		startNum=(currentPage-1)*perPage;
		
		//���������� ����� ���۹�ȣ ���ϱ�
		//��: �ѱ۰����� 23�̶��  1�������� 23,2�������� 18,3�������� 13...
		no=totalCount-(currentPage-1)*perPage;
		
		//���������� ������ �۸� ��������
		List<BoardDto> list=boardService.getPagingList(sc,sw,startNum, perPage);
		
		//list�� �� acount�� ��� ���� �����ϱ�
		for(BoardDto dto:list)
		{
			int acount=answerService.getAllAnswerList(dto.getNum()).size();
			dto.setAcount(acount);
		}

		//request�� ��� �� �ʿ��� ������ �ֱ�
		model.addAttribute("list",list);
		model.addAttribute("totalCount",totalCount);
		model.addAttribute("currentPage",currentPage);
		model.addAttribute("startPage",startPage);
		model.addAttribute("endPage",endPage);
		model.addAttribute("no",no);
		model.addAttribute("totalPage",totalPage);
		
		System.out.println("totalCount:"+totalCount); //��� ���θ����ּ�(/board/list)�� �Ѿ�� ����.
		return "/bit/board/boardlist";
	}

	@GetMapping("/board/form")
	public String bform(
			@RequestParam(defaultValue="0") int num,
			@RequestParam(defaultValue="0") int regroup,
			@RequestParam(defaultValue="0") int restep,
			@RequestParam(defaultValue="0") int relevel,
			@RequestParam(defaultValue="1") int currentPage,
			Model model
			)
	{
		//����� ��츸 �Ѿ���� ����. ������ ��� ��� null�̹Ƿ� defaultValue������ ����
		model.addAttribute("num",num);
		model.addAttribute("regroup",regroup);
		model.addAttribute("restep",restep);
		model.addAttribute("relevel",relevel);
		model.addAttribute("currentPage",currentPage);
		
		//���� �����ϰ�� "", ����� ��� �ش� ������ �־��
		String subject="";
		if(num>0) {
			subject=boardService.getData(num).getSubject();
		}
		model.addAttribute("subject",subject);
		
		return "/bit/board/boardform";
	}

	@PostMapping("/board/insert")
	public String insert(BoardDto dto,int currentPage,List<MultipartFile> upload,
			HttpServletRequest request)
	{
		//���ε� ���
		String path=request.getSession().getServletContext().getRealPath("/resources/upload");
		
		//���ε带 ������ ��� 0������ ���ϸ��� ""�� �ȴ�
		//���ε� ���ص� upload size�� 1�̵�
		System.out.println(upload.size());
		
		if(upload.get(0).getOriginalFilename().equals(""))
		{
			dto.setPhoto("no");
		}else {
			String photo="";
			int idx=1;
			for(MultipartFile multi:upload) {
				//���ϸ��� ���糯¥�� ���� �� , �� ����
				String newName=idx++ + "_" + ChangeName.getChangeFileName(multi.getOriginalFilename());
				photo+=newName+",";
				
				//���ε�
				try {
					multi.transferTo(new File(path+"/"+newName));
				} catch (IllegalStateException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			//������ �ĸ� ����
			photo=photo.substring(0,photo.length()-1);
			//dto�� ����
			dto.setPhoto(photo);
		}
		
		//db�� insert
		boardService.insertBoard(dto);
		
		return "redirect:list?currentPage="+currentPage;
	}
	
	@GetMapping("/board/detail")
	public ModelAndView detail(int num, int currentPage)
	{
		ModelAndView mview=new ModelAndView();
		
		//��ȸ�� ����
		boardService.updateReadCount(num);		
		//num�� �ش��ϴ� dto ���
		BoardDto dto=boardService.getData(num);		
		//�۾� ����� ������ memphoto
		//�̶� �۾������ Ż��������� NullPointer ������ �߻��Ѵ�
		String memphoto="";	
		try {
			memphoto=memberService.getDataById(dto.getId()).getPhoto();
		}catch (NullPointerException e){
			memphoto="no";
			dto.setName("Ż��ȸ��");
		}		
		mview.addObject("dto",dto);
		mview.addObject("memphoto",memphoto);
		mview.addObject("currentPage",currentPage);
				
		mview.setViewName("/bit/board/boarddetail");
		return mview;
	}
	
	//���ƿ�� ����
	@GetMapping("/board/likes")
	@ResponseBody
	public Map<String, Integer> likes(int num)
	{
		Map<String, Integer> map=new HashMap<>();
		
		//���ƿ� �� ����
		boardService.likesUpdate(num);
		//num�� �ش��ϴ� dto ���
		BoardDto dto=boardService.getData(num);		
		int likes=dto.getLikes();
		//���� ����: int likes=boardService.getData(num).getLikes();
		
		map.put("likes", likes);
		
		return map;
	}
	
	@PostMapping("/board/update")
	public String update(BoardDto dto,int currentPage,List<MultipartFile> upload,
			HttpServletRequest request)
	{
		//���ε� ���
		String path=request.getSession().getServletContext().getRealPath("/resources/upload");
		
		//���ε带 ������ ��� 0������ ���ϸ��� ""�� �ȴ�
		//���ε� ���ص� upload size�� 1�̵�
		System.out.println(upload.size());
		
		if(upload.get(0).getOriginalFilename().equals(""))
		{
			dto.setPhoto(null); //null�̸� ������ü�� �ȵ�. ���� ������ �����ϰڴٴ� ��
		}else {
			String photo="";
			int idx=1;
			for(MultipartFile multi:upload) {
				//���ϸ��� ���糯¥�� ���� �� , �� ����
				String newName=idx++ + "_" + ChangeName.getChangeFileName(multi.getOriginalFilename());
				photo+=newName+",";
				
				//���ε�
				try {
					multi.transferTo(new File(path+"/"+newName));
				} catch (IllegalStateException | IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			//������ �ĸ� ����
			photo=photo.substring(0,photo.length()-1);
			//dto�� ����
			dto.setPhoto(photo);
		}
		
		//db�� update
		boardService.updateBoard(dto);
		
		return "redirect:detail?currentPage="+currentPage+"&num="+dto.getNum(); //redirect �ؾ� forward��
	}
	
	@GetMapping("/board/delete")
	public String delete(int num,int currentPage)
	{
		boardService.deleteBoard(num);
		//���� �� ���� �������� �̵�
		return "redirect:list?currentPage="+currentPage;
	}
	
	@GetMapping("/board/updateform")
	public String updateform(Model model,int num,int currentPage)
	{
		//num�� �ش��ϴ� dto���
		BoardDto dto=boardService.getData(num);
		
		//model�� ����
		model.addAttribute("dto",dto);
		model.addAttribute("currentPage",currentPage);
		
		return "/bit/board/updateform";
	}

}








