package bit.data.dto;

import java.sql.Timestamp;

import lombok.Data;


/*
@Setter
@Getter
@ToString
@Data- 이거 하나로 setter & getter & tostring 3개 모두 적용

@NoArgsConstructor
@AllArgsConstructor
*/

@Data
public class BoardDto {

	private int num;
	private int readcount;
	private int likes;
	private int regroup;
	private int restep;
	private int relevel;
	private String id;
	private String name;
	private String subject;
	private String content;
	private String photo;
	private Timestamp writeday;
	private int acount;
	

}
