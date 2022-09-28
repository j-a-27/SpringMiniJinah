package bit.data.dao;

import java.util.List;
import java.util.Map;

import bit.data.dto.MemberDto;

public interface MemberDaoInter {
	
	public int getTotalCount();
	public List<MemberDto> getAllMembers();
	public void insertMember(MemberDto dto);
	public int getSerchId(String id);
	public String getName(String id);
	
	public int getIdPassCheck(Map<String, String> map);
	public MemberDto getDataById(String id);
	public MemberDto getDataByNum(int num);
	
	// Map<key,value> -> Map<String, Object>�� �ִ� ����:
	// ���⿡���� photo(String), num(int) �׷��Ƿ� value�ڸ��� String�̳� int�� Ư���Ұ�.
	// ���� �Ѵ� �����ϴ� Object�� ����.
	public void updatePhoto(Map<String, Object> map);
	public void updateMember(MemberDto dto);
	public void deleteMember(int num);

}
