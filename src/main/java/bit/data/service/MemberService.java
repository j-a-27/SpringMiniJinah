package bit.data.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bit.data.dao.MemberDaoInter;
import bit.data.dto.MemberDto;

@Service
public class MemberService implements MemberServiceInter {
	
	@Autowired
	MemberDaoInter memberDao;

	@Override
	public int getTotalCount() {

		return memberDao.getTotalCount();
	}

	@Override
	public List<MemberDto> getAllMembers() {
		
		return memberDao.getAllMembers();
	}

	@Override
	public void insertMember(MemberDto dto) {
		
		memberDao.insertMember(dto);
	}

	@Override
	public int getSerchId(String id) {
		
		return memberDao.getSerchId(id);
	}

	@Override
	public String getName(String id) {
		
		return memberDao.getName(id);
	}

	@Override
	public int getIdPassCheck(String id, String pass) {
		
		Map<String, String> map=new HashMap<>();
		map.put("loginid", id);
		map.put("loginpass", pass);
		
		return memberDao.getIdPassCheck(map);
	}

	@Override
	public MemberDto getDataById(String id) {
		
		return memberDao.getDataById(id);
	}

	@Override
	public MemberDto getDataByNum(int num) {
		
		return memberDao.getDataByNum(num);
	}

	@Override
	public void updatePhoto(int num, String photo) {
		
		Map<String, Object> map=new HashMap<>();
		map.put("photo", photo);
		map.put("num",num);
		
		memberDao.updatePhoto(map);
	}

	@Override
	public void updateMember(MemberDto dto) {

		memberDao.updateMember(dto);
	}

	@Override
	public void deleteMember(int num) {
		
		memberDao.deleteMember(num);
	}

}
