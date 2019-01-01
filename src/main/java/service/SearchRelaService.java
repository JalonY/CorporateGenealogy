package service;

import entity.TCorp;
import entity.TCorpPertains;

import java.util.List;

/**
 * service层接口，处理‘查关系’主要请求
 * @author: yjl
 * @date: 2018/8/25
 */
public interface SearchRelaService {

    List<TCorp> getCorpNameByOnePersonName(String onePersonName);//根据一个人员姓名查询所属企业名

    List<TCorp> getCorpNameByDistName(String distName); //根据分公司名查询公司

    List<TCorpPertains> getPeopleByCorpName(String corpName); //根据公司名查询公司人员
}
