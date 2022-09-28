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
	
	// Map<key,value> -> Map<String, Object>로 넣는 이유:
	// 여기에서는 photo(String), num(int) 그러므로 value자리에 String이나 int로 특정불가.
	// 따라서 둘다 포괄하는 Object로 쓴다.
	public void updatePhoto(Map<String, Object> map);
	public void updateMember(MemberDto dto);
	public void deleteMember(int num);

}
