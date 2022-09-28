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
	//namespace �涧 ���ϰ� ���� ���� ����(ns)�� �־����

	@Override
	public int getTotalCount() {
		// ������ �տ� namespace.id�ε� ��������
		//(�ٸ� ���Ͽ� ���� ���̵� �������� �����Ƿ� ���̴� ���� ����)
		//-> namespace. �� ns�� �־�������Ƿ� ns+ �� �ִ´�
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
