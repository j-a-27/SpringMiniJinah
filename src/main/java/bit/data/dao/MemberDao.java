package bit.data.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import bit.data.dto.MemberDto;

@Repository
public class MemberDao implements MemberDaoInter {
	
	@Autowired
	SqlSession session;
	String ns="bit.data.dao.MemberDao.";
	//namespace 길때 편하게 쓰기 위해 변수(ns)에 넣어놓기

	@Override
	public int getTotalCount() {
		// 원래는 앞에 namespace.id인데 생략가능
		//(다른 파일에 같은 아이디가 있을수도 있으므로 붙이는 것이 좋음)
		//-> namespace. 을 ns에 넣어놓았으므로 ns+ 로 넣는다
		return session.selectOne(ns+"getTotalCount");
	}

	@Override
	public List<MemberDto> getAllMembers() {
		
		return session.selectList(ns+"getAllMembers");
	}

	@Override
	public void insertMember(MemberDto dto) {
		
		session.insert(ns+"insertMember",dto);
	}

	@Override
	public int getSerchId(String id) {
		
		return session.selectOne(ns+"getIdSearch", id);
	}

	@Override
	public String getName(String id) {
		
		return session.selectOne(ns+"getName",id);
	}

	@Override
	public int getIdPassCheck(Map<String, String> map) {
		
		return session.selectOne(ns+"loginIdPassCheck",map);
	}

	@Override
	public MemberDto getDataById(String id) {
		
		return session.selectOne(ns+"getDataById",id);
	}

	@Override
	public MemberDto getDataByNum(int num) {
		
		return session.selectOne(ns+"getDataByNum",num);
	}

	@Override
	public void updatePhoto(Map<String, Object> map) {
		session.selectList(ns+"updatePhoto",map);
		
	}

	@Override
	public void updateMember(MemberDto dto) {
		session.selectOne(ns+"updateMember",dto);
		
	}

	@Override
	public void deleteMember(int num) {
		session.selectOne(ns+"deleteMember",num);
		
	}

}
