package service;

import entity.BaiduMapCorp;

import java.util.List;

/**
 * @author: zsl
 * @date: 2018/08/14 13:18
 */
public interface BaiduMapService {

    //获得所有的公司坐标地址
    List<BaiduMapCorp> getAllMapCorp();

    //获得当前位置所有公司
    List<BaiduMapCorp> getCorpInsideMap(double leftLongitude, double leftLatitude, double rightLongitude, double rightLatitude);

    //获得当前位置所有公司用于表格
    List<BaiduMapCorp> getTableCorp();
}
