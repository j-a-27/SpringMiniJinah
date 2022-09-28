package bit.data.dao;

import bit.data.dto.ComBoardDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ComBoardDao implements ComBoardDaoInter{

    @Autowired
    SqlSession session;

    @Override
    public void insertBoard(ComBoardDto dto) {

    }
}
