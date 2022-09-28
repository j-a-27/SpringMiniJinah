package bit.data.service;

import bit.data.dao.ComBoardDaoInter;
import bit.data.dto.ComBoardDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ComBoardService implements ComBoardServiceInter{

    @Autowired
    ComBoardDaoInter cbdao;

    @Override
    public void insertBoard(ComBoardDto dto) {

        int num = dto.getBoardnum();
        cbdao.insertBoard(dto);
    }
}
