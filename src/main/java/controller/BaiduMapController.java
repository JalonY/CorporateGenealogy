package controller;

import entity.BaiduMapCorp;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import service.BaiduMapService;

import java.util.List;

/**
 * @author: zsl
 * @date: 2018/08/14 08:58
 */
@Controller
public class BaiduMapController {

    @Autowired
    BaiduMapService baiduMapService;


    //获取地图上所有企业
    @GetMapping("/mapCorp.do")
    @ResponseBody
    public List<BaiduMapCorp> mapPointList() {
        List<BaiduMapCorp> mapList = baiduMapService.getAllMapCorp();
        return mapList;
    }


    //获得当前位置所有公司
    @RequestMapping("/mapInside.do")
    @ResponseBody
    public List<BaiduMapCorp> getCorpInsideMap(@RequestParam(value = "leftLongitude") double leftLongitude,
                                               @RequestParam(value = "leftLatitude") double leftLatitude,
                                               @RequestParam(value = "rightLongitude") double rightLongitude,
                                               @RequestParam(value = "rightLatitude") double rightLatitude) {
        return baiduMapService.getCorpInsideMap(leftLongitude, leftLatitude, rightLongitude, rightLatitude);
    }

    //datatable获取地图上所有企业
    @RequestMapping(value = "/tableCorp.do", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String getTableCorp() {
        List<BaiduMapCorp> mapList = baiduMapService.getTableCorp();
        String result = "{" +"\"data\""+":"+ JSONArray.fromObject(mapList).toString()+"}";
        System.out.println(result);
        return result;
    }

}
