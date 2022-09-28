package bit.data.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import bit.data.dto.BoardAnswerDto;
import bit.data.service.BoardAnswerServiceInter;
import util.ChangeName;

@RestController
@RequestMapping("/answer")
public class AnswerController {
	
	@Autowired
	BoardAnswerServiceInter answerService;

	String uploadPhoto;
	
	//��ۿ��� ���� ���ε� �ÿ� ȣ��
	@PostMapping("/updatephoto")
	public Map<String,String> photoUpload(HttpServletRequest request,MultipartFile photo)
	{

		//��Ĺ�� �ö� upload ���� ��� ���ϱ�
		String path=request.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println(path);
		//���ε� �� ����� ���ϸ� ���ϱ�
		uploadPhoto=ChangeName.getChangeFileName(photo.getOriginalFilename());
		
		//���ε�
		try {
			photo.transferTo(new File(path+"/"+uploadPhoto));

		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Map<String,String> map=new HashMap<>();
		map.put("aphoto", uploadPhoto);
		
		return map;
	}
	@PostMapping("/insert")
	public void insert(BoardAnswerDto dto)
	{
		//������ ���� ���� �� db insert
		if(uploadPhoto==null) //���� ������ ������ ���
			dto.setPhoto("no");
		else
			dto.setPhoto(uploadPhoto);
		
		answerService.insertAnswer(dto);
		uploadPhoto=null; //�� ���� ����� ���ؼ� �����̸��� null�� �ʱ�ȭ
	}
	@GetMapping("/list") //���� ���ξȿ� �ּ� �ȳ����� 500 num�� null ��¼�� �������Ф�
	public List<BoardAnswerDto> list(int num)
	{
		return answerService.getAllAnswerList(num);
	}
	
	@GetMapping("/delete")
	public void delete(int idx,HttpServletRequest request)
	{
		//���ε�� ��� ���ϱ�
		String path=request.getSession().getServletContext().getRealPath("/resources/upload");
		System.out.println(path);
		
		//������ �������� ���� �����
		//�������� ���
		String photo=answerService.getAnswer(idx).getPhoto();
		
		//file ��ü ����
		File file = new File(path+"/"+photo);
		if(file.exists()) {
			System.out.println("������ �����ϹǷ� �����մϴ�");
			file.delete();
		}
		
		answerService.deleteAnswer(idx);
	}

}














