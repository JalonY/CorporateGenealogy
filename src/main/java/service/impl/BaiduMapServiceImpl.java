package service.impl;

import dao.BaiduMapDao;
import entity.BaiduMapCorp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.BaiduMapService;

import java.util.List;

/**
 * @author: zsl
 * @date: 2018/08/14 13:20
 */
@Service
public class BaiduMapServiceImpl implements BaiduMapService {

    @Autowired
    BaiduMapDao baiduMapDao;

    //获得所有的公司坐标地址
    @Override
    public List<BaiduMapCorp> getAllMapCorp() {
        return baiduMapDao.getAllMapCorp();
    }

    //获得当前位置所有公司
    @Override
    public List<BaiduMapCorp> getCorpInsideMap(double leftLongitude, double leftLatitude, double rightLongitude, double rightLatitude) {
        return baiduMapDao.getCorpInsideMap(leftLongitude, leftLatitude, rightLongitude, rightLatitude);
    }

    //获得当前位置所有公司用于表格
    @Override
    public List<BaiduMapCorp> getTableCorp() {
        return baiduMapDao.getTableCorp();
    }
}
