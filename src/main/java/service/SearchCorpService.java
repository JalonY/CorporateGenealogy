package service;

import entity.*;

import java.util.List;

/**
 * service层接口，处理‘查企业’主要请求
 * @author: yjl
 * @date: 2018/4/9
 */
public interface SearchCorpService {

    List<TCorp> getAllCorpName();  //根据关键字自动补全

    List<TCorp> getAllNewRegCorps();  //获取最新注册的企业

    List<TCorp> getAllNewMarCorps();  //获取最新上市的企业

    List<TCorp> getAllNewFinCorps();  //获取最新融资的企业

    List<TCorpRecruit> getAllCorpRecruit(); //获取所有企业招聘信息

    List<TCorp> getListCorpByName(String userInput); //根据名称查询相关企业

    List<TCorp> getListCorpByStock(String userInput); //根据法人/股东查询相关企业

    List<TCorp> getListCorpByManager(String userInput); //根据高管查询相关企业

    List<TCorp> getListCorpByIndu(String userInput); //根据所属行业查询相关企业

    List<TCorp> getListCorpByAddress(String corp_address);  //根据地址查询相关企业

    List<TCorp> getListCorpByDate(String new_before_date, String new_after_date); //根据日期获取相关企业

    List<TCorp> getCorpInfo(int corp_id);  //根据企业ID查询企业详情

    TCorp getCorpByName(String corpName);  //根据企业名称返回信息

    List<TCorpPertains> getCorpPertains(int corp_id);  //根据企业ID查询公司主要人员

    List<TCorpStock> getCorpStock(int corp_id);  //根据企业ID查询公司主要股东

    List<TCorpStock> getStockRatio(int corp_id);  //获取企业股东投资比例计算实际控股人

    List<TCorpDist> getCorpDist(int corp_id);  //根据企业ID查询公司分支机构

    List<TCorp> getCorpNameByPersonNames(String Name);  //根据人员姓名查询所属企业名

    List<TCorpStock> getStockIdByRegNo(String corpRegNo);  //根据公司注册号查询股东id

    List<TCorp> getStockCorpByStockId(int stock_id);  //根据股东id查询对外投资情况

    List<TCorpStock> getCorpStockByStockCertificateNo(String certificateNo);    //根据股东注册号关联企业查询该企业的股东

    List<TCorpStock> getCorpDistByDistName(String distName);    //根据企业分公司名查询该分公司下的公司

    List<TQueryHistory> getAllQueryHistory();   //查询所有搜索历史记录

    List<TCorp> getSomeCorpName(int i,String corpName); //两种集合中数量不足进行补充

    List<TCorpEvaluate> getAllCorpEvalates(int corpId);   //获取当前企业点评内容

    List<TCollectCorp> getCollectIds(int userId);   //根据用户ID查询收藏企业ID

    List<TAttentionCorp> getAttentionIds(int userId);   //根据用户ID查询关注企业ID

    TCorp getCollectAttentionCorps(int corpId);    //根据企业ID查询收藏与关注企业信息

    void deleteCollect(int userId, int corpId);     //根据用户Id与收藏企业ID删除收藏企业

    void deleteAttention(int userId, int corpId);   //根据用户Id与关注企业ID删除关注企业

    int attentionCorp(TAttentionCorp attentionCorp);  //根据用户Id与关注企业ID添加关注企业

    int collectCorp(TCollectCorp collectCorp);    //根据用户Id与收藏企业ID添加收藏企业

    int userEvaluate(TCorpEvaluate tCorpEvaluate);  //根据用户Id，添加企业点评

    String selectSearch(TQueryHistory history);     //根据用户账号查询是否已存在搜索记录

    void addSearchHistory(TQueryHistory queryHistory);  //根据用户账号添加搜索记录

    TCorp getTaxCorp(String corp_name);     //税号查询企业

    String advancedSearch(String top_inputName, String top_inputAddress,
                          String top_capiStart, String top_capiEnd,
                          String top_manName, String top_stockName, String top_inputScope); //高级查询企业

}
