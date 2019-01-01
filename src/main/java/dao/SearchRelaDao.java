package dao;

import entity.TCorp;
import entity.TCorpPertains;

import java.util.List;

public interface SearchRelaDao {

    List<TCorp> getCorpNameByOnePersonName(String onePersonName);//根据一个人员姓名查询所属企业名

    List<TCorp> getCorpNameByDistName(String distName); //根据分公司名查询公司

    List<TCorpPertains> getPeopleByCorpName(String corpName);   //根据公司名查询公司人员
}
