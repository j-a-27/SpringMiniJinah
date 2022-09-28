package bit.data.service;

import java.util.List;
import java.util.Map;

import bit.data.dto.MemberDto;

public interface MemberServiceInter {
	
	public int getTotalCount();
	public List<MemberDto> getAllMembers();
	public void insertMember(MemberDto dto);
	public int getSerchId(String id);
	public String getName(String id);
	
	// �ڷ��� map�� ���·� controller�� �ѱ�� �ű⼭ ó���ؾ���
	// ���⼭ Map<String, String> map-> String id, String pass �� Ǯ���ְ�,
	// Service class���� Map���� �����ش�.
	public int getIdPassCheck(String id, String pass);
	
	public MemberDto getDataById(String id);
	public MemberDto getDataByNum(int num);
	
	//���� ������ ���. Map<String, Object> map -> int num, String photo
	public void updatePhoto(int num, String photo);
	
	public void updateMember(MemberDto dto);
	public void deleteMember(int num);
}
