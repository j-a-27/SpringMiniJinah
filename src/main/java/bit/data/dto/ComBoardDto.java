package bit.data.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class ComBoardDto {

    private int boardnum;
    private String boardtype;
    private int usernum;
    private String userid;
    private String subject;
    private String content;
    private String photo;
    private int readcount;
    private int likes;
    private int report;
    private Timestamp writeday;

}
