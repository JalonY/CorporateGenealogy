package service.impl;

import dao.JedisClient;
import dao.SearchCorpDao;
import entity.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.SearchCorpService;
import util.JsonUtils;

import java.util.List;

/**
 * service层，处理‘查企业’主要请求
 *
 * @author: yjl
 * @date: 2018/4/9
 */
@Service
public class SearchCorpServiceImpl implements SearchCorpService {

    @Autowired
    SearchCorpDao searchCorpDao;
    @Autowired
    JedisClient jedisClient;

    private String hkey = "SEARCH_CORP";// 这个名称相当于数据库中表的名称，这个表里面存储的key-value

    /**
     * redis使用说明：
     * 1、redis也是数据库，存储的内容和数据库没有区别
     * 2、redis里存储的都是value是JSON形式的，所以要有JsonUtils工具类，来把相关对象转成JSON格式
     * 3、redis的数据不会主动跟数据中的数据同步
     * @return
     */

    //获取数据库所有企业名称添加至搜索引擎
    @Override
    public List<TCorp> getAllCorpName() {
        return searchCorpDao.getAllCorpName();
    }

    //获取最新注册的企业
    @Override
    public List<TCorp> getAllNewRegCorps() {
        //1、先尝试从redis读取，如果有数据就直接return
        //2、redis没有数据，就会直接从数据库读取，然后把读取的内容加入到redis中，下次就会直接从数据库中读取
        String key = "AllNewRegCorps";
        // 从Redis缓存中取数据
        try {
            String result = jedisClient.hget(hkey, key);
            if (!StringUtils.isBlank(result)) {
                List<TCorp> nameList = JsonUtils.jsonToList(result, TCorp.class);
                System.out.println("从Redis缓存读取成功! " + "key:" + key);
                return nameList;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("从Redis缓存读取数据失败");
        }
        // 直接从数据库里读取
        List<TCorp> AllNewRegCorps = searchCorpDao.getAllNewRegCorps();
        System.out.println("直接数据库里读成功！");

        // 向redis缓存添加内容
        try {
            String cacheString = JsonUtils.objectToJson(AllNewRegCorps);
            jedisClient.hset(hkey, key, cacheString);
            System.out.println("Redis缓存添加内容成功！ " + "key:" + key);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Redis缓存添加内容失败");
        }
        return AllNewRegCorps;
    }

    //获取最新上市的企业
    @Override
    public List<TCorp> getAllNewMarCorps() {
        //1、先尝试从redis读取，如果有数据就直接return
        //2、redis没有数据，就会直接从数据库读取，然后把读取的内容加入到redis中，下次就会直接从数据库中读取
        String key = "AllNewMarCorps";
        // 从Redis缓存中取数据
        try {
            String result = jedisClient.hget(hkey, key);
            if (!StringUtils.isBlank(result)) {
                List<TCorp> nameList = JsonUtils.jsonToList(result, TCorp.class);
                System.out.println("从Redis缓存读取成功! " + "key:" + key);
                return nameList;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("从Redis缓存读取数据失败");
        }
        // 直接从数据库里读取
        List<TCorp> AllNewMarCorps = searchCorpDao.getAllNewMarCorps();
        System.out.println("直接数据库里读成功！");

        // 向redis缓存添加内容
        try {
            String cacheString = JsonUtils.objectToJson(AllNewMarCorps);
            jedisClient.hset(hkey, key, cacheString);
            System.out.println("Redis缓存添加内容成功！ " + "key:" + key);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Redis缓存添加内容失败");
        }
        return AllNewMarCorps;
    }

    //获取最新融资的企业
    @Override
    public List<TCorp> getAllNewFinCorps() {
        //1、先尝试从redis读取，如果有数据就直接return
        //2、redis没有数据，就会直接从数据库读取，然后把读取的内容加入到redis中，下次就会直接从数据库中读取
        String key = "AllNewFinCorps";
        // 从Redis缓存中取数据
        try {
            String result = jedisClient.hget(hkey, key);
            if (!StringUtils.isBlank(result)) {
                List<TCorp> nameList = JsonUtils.jsonToList(result, TCorp.class);
                System.out.println("从Redis缓存读取成功! " + "key:" + key);
                return nameList;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("从Redis缓存读取数据失败");
        }
        // 直接从数据库里读取
        List<TCorp> AllNewFinCorps = searchCorpDao.getAllNewFinCorps();
        System.out.println("直接数据库里读成功！");

        // 向redis缓存添加内容
        try {
            String cacheString = JsonUtils.objectToJson(AllNewFinCorps);
            jedisClient.hset(hkey, key, cacheString);
            System.out.println("Redis缓存添加内容成功！ " + "key:" + key);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Redis缓存添加内容失败");
        }
        return AllNewFinCorps;
    }

    //获取所有企业招聘信息
    @Override
    public List<TCorpRecruit> getAllCorpRecruit() {
        //1、先尝试从redis读取，如果有数据就直接return
        //2、redis没有数据，就会直接从数据库读取，然后把读取的内容加入到redis中，下次就会直接从数据库中读取
        String key = "AllCorpRecruit";
        // 从Redis缓存中取数据
        try {
            String result = jedisClient.hget(hkey, key);
            if (!StringUtils.isBlank(result)) {
                List<TCorpRecruit> recruitList = JsonUtils.jsonToList(result, TCorpRecruit.class);
                System.out.println("从Redis缓存读取成功! " + "key:" + key);
                return recruitList;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("从Redis缓存读取数据失败");
        }
        // 直接从数据库里读取
        List<TCorpRecruit> AllCorpRecruit = searchCorpDao.getAllCorpRecruit();
        System.out.println("直接数据库里读成功！");

        // 向redis缓存添加内容
        try {
            String cacheString = JsonUtils.objectToJson(AllCorpRecruit);
            jedisClient.hset(hkey, key, cacheString);
            System.out.println("Redis缓存添加内容成功！ " + "key:" + key);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Redis缓存添加内容失败");
        }
        return AllCorpRecruit;
    }

    //根据名称查询相关企业
    @Override
    public List<TCorp> getListCorpByName(String userInput) {
        return searchCorpDao.getListCorpByName(userInput);
    }

    //根据法人/股东查询相关企业
    @Override
    public List<TCorp> getListCorpByStock(String userInput) {
        return searchCorpDao.getListCorpByStock(userInput);
    }

    //根据高管查询相关企业
    @Override
    public List<TCorp> getListCorpByManager(String userInput) {
        return searchCorpDao.getListCorpByManager(userInput);
    }

    //根据所属行业查询相关企业
    @Override
    public List<TCorp> getListCorpByIndu(String userInput) {
        return searchCorpDao.getListCorpByIndu(userInput);
    }

    //根据地址查询相关企业
    @Override
    public List<TCorp> getListCorpByAddress(String corp_address) {
        return searchCorpDao.getListCorpByAddress(corp_address);
    }

    //根据日期获取相关企业
    @Override
    public List<TCorp> getListCorpByDate(String new_before_date, String new_after_date) {
        return searchCorpDao.getListCorpByDate(new_before_date, new_after_date);
    }

    //根据企业ID查询企业详情
    @Override
    public List<TCorp> getCorpInfo(int corp_id) {
        return searchCorpDao.getCorpInfo(corp_id);
    }

    //根据企业名称返回信息
    @Override
    public TCorp getCorpByName(String corpName) {
        return searchCorpDao.getCorpByName(corpName);
    }

    //税号查询企业
    @Override
    public TCorp getTaxCorp(String corp_name) {
        return searchCorpDao.getTaxCorp(corp_name);
    }

    //高级查询企业
    @Override
    public String advancedSearch(String top_inputName, String top_inputAddress, String top_capiStart,
                                 String top_capiEnd, String top_manName, String top_stockName,
                                 String top_inputScope) {
        return searchCorpDao.advancedSearch(top_inputName,top_inputAddress,top_capiStart,
                top_capiEnd,top_manName,top_stockName,top_inputScope);
    }

    //根据企业ID查询公司主要人员
    @Override
    public List<TCorpPertains> getCorpPertains(int corp_id) {
        return searchCorpDao.getCorpPertains(corp_id);
    }

    //根据企业ID查询公司主要股东
    @Override
    public List<TCorpStock> getCorpStock(int corp_id) {
        return searchCorpDao.getCorpStock(corp_id);
    }

    //获取企业股东投资比例计算实际控股人
    @Override
    public List<TCorpStock> getStockRatio(int corp_id) {
        return searchCorpDao.getStockRatio(corp_id);
    }

    //根据企业ID查询公司分支机构
    @Override
    public List<TCorpDist> getCorpDist(int corp_id) {
        return searchCorpDao.getCorpDist(corp_id);
    }

    //根据人员姓名查询所属企业名
    @Override
    public List<TCorp> getCorpNameByPersonNames(String Name) {
        return searchCorpDao.getCorpNameByPersonNames(Name);
    }

    //根据公司注册号查询股东id
    @Override
    public List<TCorpStock> getStockIdByRegNo(String corpRegNo) {
        return searchCorpDao.getStockIdByRegNo(corpRegNo);
    }

    //根据股东id查询对外投资情况
    @Override
    public List<TCorp> getStockCorpByStockId(int stock_id) {
        return searchCorpDao.getStockCorpByStockId(stock_id);
    }

    //根据股东注册号关联企业查询该企业的股东
    @Override
    public List<TCorpStock> getCorpStockByStockCertificateNo(String certificateNo) {
        return searchCorpDao.getCorpStockByStockCertificateNo(certificateNo);
    }

    //根据企业分公司名查询该分公司下的公司
    @Override
    public List<TCorpStock> getCorpDistByDistName(String distName) {
        return searchCorpDao.getCorpDistByDistName(distName);
    }

    //查询所有搜索历史记录
    @Override
    public List<TQueryHistory> getAllQueryHistory() {
        //1、先尝试从redis读取，如果有数据就直接return
        //2、redis没有数据，就会直接从数据库读取，然后把读取的内容加入到redis中，下次就会直接从数据库中读取
        String key = "AllQueryHistory";
        // 从Redis缓存中取数据
        try {
            String result = jedisClient.hget(hkey, key);
            if (!StringUtils.isBlank(result)) {
                List<TQueryHistory> nameList = JsonUtils.jsonToList(result, TQueryHistory.class);
                System.out.println("从Redis缓存读取成功! " + "key:" + key);
                return nameList;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("从Redis缓存读取数据失败");
        }
        // 直接从数据库里读取
        List<TQueryHistory> AllQueryHistory = searchCorpDao.getAllQueryHistory();
        System.out.println("直接数据库里读成功！");

        // 向redis缓存添加内容
        try {
            String cacheString = JsonUtils.objectToJson(AllQueryHistory);
            jedisClient.hset(hkey, key, cacheString);
            System.out.println("Redis缓存添加内容成功！ " + "key:" + key);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Redis缓存添加内容失败");
        }
        return AllQueryHistory;
    }

    //两种集合中数量不足进行补充
    @Override
    public List<TCorp> getSomeCorpName(int i, String corpName) {
        return searchCorpDao.getSomeCorpName(i, corpName);
    }

    //获取当前企业点评内容
    @Override
    public List<TCorpEvaluate> getAllCorpEvalates(int corpId) {
        return searchCorpDao.getAllCorpEvalates(corpId);
    }

    //根据用户ID查询收藏企业ID
    @Override
    public List<TCollectCorp> getCollectIds(int userId) {
        return searchCorpDao.getCollectIds(userId);
    }

    //根据用户ID查询关注企业ID
    @Override
    public List<TAttentionCorp> getAttentionIds(int userId) {
        return searchCorpDao.getAttentionIds(userId);
    }

    //根据企业ID查询收藏与关注企业信息
    @Override
    public TCorp getCollectAttentionCorps(int corpId) {
        return searchCorpDao.getCollectAttentionCorps(corpId);
    }

    //根据用户Id与收藏企业ID删除收藏企业
    @Override
    public void deleteCollect(int userId, int corpId) {
        searchCorpDao.deleteCollect(userId, corpId);
    }

    //根据用户Id与关注企业ID删除关注企业
    @Override
    public void deleteAttention(int userId, int corpId) {
        searchCorpDao.deleteAttention(userId, corpId);
    }

    //根据用户Id与关注企业ID添加关注企业
    @Override
    public int attentionCorp(TAttentionCorp attentionCorp) {
        return searchCorpDao.attentionCorp(attentionCorp);
    }

    //根据用户Id与收藏企业ID添加收藏企业
    @Override
    public int collectCorp(TCollectCorp collectCorp) {
        return searchCorpDao.collectCorp(collectCorp);
    }

    //根据用户Id，添加企业点评
    @Override
    public int userEvaluate(TCorpEvaluate tCorpEvaluate) {
        return searchCorpDao.userEvaluate(tCorpEvaluate);
    }

    //根据用户账号查询是否已存在搜索记录
    @Override
    public String selectSearch(TQueryHistory history) {
        return searchCorpDao.selectSearch(history);
    }

    //根据用户账号添加搜索记录
    @Override
    public void addSearchHistory(TQueryHistory queryHistory) {
        searchCorpDao.addSearchHistory(queryHistory);
    }


}
