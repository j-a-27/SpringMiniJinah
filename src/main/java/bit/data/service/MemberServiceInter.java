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
	
	// 자료형 map인 상태로 controller로 넘기면 거기서 처리해야함
	// 여기서 Map<String, String> map-> String id, String pass 로 풀어주고,
	// Service class에서 Map으로 묶어준다.
	public int getIdPassCheck(String id, String pass);
	
	public MemberDto getDataById(String id);
	public MemberDto getDataByNum(int num);
	
	//위와 동일한 경우. Map<String, Object> map -> int num, String photo
	public void updatePhoto(int num, String photo);
	
	public void updateMember(MemberDto dto);
	public void deleteMember(int num);
}
