package bit.data.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.data.dao.BoarddaoInter;
import bit.data.dto.BoardDto;

@Service
public class BoardService implements BoardServiceInter {

	@Autowired
	BoarddaoInter boardDao;
	
	@Override
	public int getMaxNum() {
		// TODO Auto-generated method stub
		return boardDao.getMaxNum();
	}

	@Override
	public int getTotalCount(String searchcolumn, String searchword) {
		// TODO Auto-generated method stub
		Map<String, String> map=new HashMap<>();
		map.put("searchcolumn", searchcolumn);
		map.put("searchword", searchword);
		
		return boardDao.getTotalCount(map);
	}

	@Override
	public List<BoardDto> getPagingList(String searchcolumn, String searchword, int startnum, int perpage) {
		// TODO Auto-generated method stub
		Map<String, Object> map=new HashMap<>();
		map.put("searchcolumn", searchcolumn);
		map.put("searchword", searchword);
		map.put("startnum", startnum);
		map.put("perpage", perpage);
		
		return boardDao.getPagingList(map);
	}

	@Override
	public void insertBoard(BoardDto dto) {
		// �������� ������� �Ǵ��ؼ� ������ §��
		int num=dto.getNum(); //����(���ο� ����)�� ��� 0�� �� ����
		int regroup=dto.getRegroup();
		int restep=dto.getRestep();
		int relevel=dto.getRelevel();
		
		if(num==0) //������ ���
		{
			regroup=this.getMaxNum()+1;
			restep=0;
			relevel=0;
					
		}else { //����� ���
			//���� �׷� �� ���޹��� restep���� ū ���� ���� �����͵��� ��� restep�� �ϰ� +1�� ���ش�.
			this.updateRestep(regroup, restep);
			//�׸��� ���� ���޹��� ������ 1ũ�� db�� ����
			restep++;
			relevel++;
		}
		//����� ���� �ٽ� dto�� �ֱ�
		dto.setRegroup(regroup);
		dto.setRestep(restep);
		dto.setRelevel(relevel);
		
		boardDao.insertBoard(dto);
	}

	@Override
	public void updateRestep(int regroup, int restep) {
		// TODO Auto-generated method stub
		Map<String, Integer> map=new HashMap<>();
		map.put("regroup", regroup);
		map.put("restep", restep);
		
		boardDao.updateRestep(map);
	}

	@Override
	public void updateReadCount(int num) {
		// TODO Auto-generated method stub
		boardDao.updateReadCount(num);
	}

	@Override
	public BoardDto getData(int num) {
		// TODO Auto-generated method stub
		return boardDao.getData(num);
	}

	@Override
	public void updateBoard(BoardDto dto) {
		// TODO Auto-generated method stub
		boardDao.updateBoard(dto);
	}

	@Override
	public void deleteBoard(int num) {
		// TODO Auto-generated method stub
		boardDao.deleteBoard(num);
	}

	@Override
	public void likesUpdate(int num) {
		// TODO Auto-generated method stub
		boardDao.likesUpdate(num);
	}

}
