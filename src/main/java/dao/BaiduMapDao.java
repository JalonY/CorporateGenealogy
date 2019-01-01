package dao;

import entity.BaiduMapCorp;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author: zsl
 * @date: 2018/08/14 13:13
 */
public interface BaiduMapDao {

    //获取地图上所有企业
    List<BaiduMapCorp> getAllMapCorp();

    //获得当前位置所有公司
    List<BaiduMapCorp> getCorpInsideMap(@Param("leftLongitude") double leftLongitude,
                                        @Param("leftLatitude") double leftLatitude,
                                        @Param("rightLongitude") double rightLongitude,
                                        @Param("rightLatitude") double rightLatitude);

    //获得当前位置所有公司用于表格
    List<BaiduMapCorp> getTableCorp();
}
