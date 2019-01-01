package service.impl;

import dao.SearchCorpDao;
import dao.SearchRelaDao;
import entity.TCorp;
import entity.TCorpPertains;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.SearchRelaService;

import java.util.List;

/**
 * service层，处理‘查关系’主要请求
 * @author: yjl
 * @date: 2018/8/25
 */
@Service
public class SearchRelaServiceImpl implements SearchRelaService{
    @Autowired
    SearchRelaDao searchRelaDao;

    //根据一个人员姓名查询所属企业名
    @Override
    public List<TCorp> getCorpNameByOnePersonName(String onePersonName) {
        return searchRelaDao.getCorpNameByOnePersonName(onePersonName);
    }
    //根据分公司名查询公司
    @Override
    public List<TCorp> getCorpNameByDistName(String distName) {
        return searchRelaDao.getCorpNameByDistName(distName);
    }

    //根据公司名查询公司人员
    @Override
    public List<TCorpPertains> getPeopleByCorpName(String corpName) {
        return searchRelaDao.getPeopleByCorpName(corpName);
    }

}
