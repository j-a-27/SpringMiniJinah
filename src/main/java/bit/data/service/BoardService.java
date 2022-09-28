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
		// 새글인지 답글인지 판단해서 로직을 짠다
		int num=dto.getNum(); //새글(새로운 원글)일 경우 0이 들어가 있음
		int regroup=dto.getRegroup();
		int restep=dto.getRestep();
		int relevel=dto.getRelevel();
		
		if(num==0) //새글일 경우
		{
			regroup=this.getMaxNum()+1;
			restep=0;
			relevel=0;
					
		}else { //답글일 경우
			//같은 그룹 중 전달받은 restep보다 큰 값을 가진 데이터들은 모두 restep에 일괄 +1을 해준다.
			this.updateRestep(regroup, restep);
			//그리고 나서 전달받은 값보다 1크게 db에 저장
			restep++;
			relevel++;
		}
		//변경된 값들 다시 dto에 넣기
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
