package controller;

import entity.TCorp;
import entity.TCorpPertains;
import net.sf.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.SearchRelaService;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * controller层，处理‘查关系’相关请求
 * @author: yjl
 * @date: 2018/8/25
 */
@Controller
public class SearchRelaController {
    @Autowired
    SearchRelaService searchRelaService;

    //根据一个人员姓名查询所属企业名
    @RequestMapping(value="/getCorpNameByOnePersonName.do")
    @ResponseBody
    public void getCorpNameByOnePersonName(@RequestParam(value= "PersonName") String PersonName,HttpServletResponse response) throws IOException {
        List<TCorp> tcorpList;
        tcorpList = searchRelaService.getCorpNameByOnePersonName(PersonName);

        response.setContentType("text/html; charset=utf-8");
        String json = JSONArray.fromObject(tcorpList).toString();
        //System.out.println(json);
        PrintWriter pwriter = response.getWriter();
        pwriter.println(json);
        pwriter.flush();
        pwriter.close();
    }

    //根据分公司名查询公司
    @RequestMapping(value="/getCorpNameByDistName.do")
    @ResponseBody
    public void getCorpNameByDistName(@RequestParam(value= "distName") String distName, HttpServletResponse response) throws IOException {
        List<TCorp> tcorpList = searchRelaService.getCorpNameByDistName(distName);
        response.setContentType("text/html; charset=utf-8");

        String json = JSONArray.fromObject(tcorpList).toString();
        //System.out.println(json);
        PrintWriter pwriter = response.getWriter();
        pwriter.println(json);
        pwriter.flush();
        pwriter.close();
    }


    //根据公司名查询公司人员
    @RequestMapping(value="/getPeopleByCorpName.do")
    @ResponseBody
    public void getPeopleByCorpName(@RequestParam(value= "corpName") String corpName, HttpServletResponse response) throws IOException {
        List<TCorpPertains> pertainsList = searchRelaService.getPeopleByCorpName(corpName);
        response.setContentType("text/html; charset=utf-8");

        String json = JSONArray.fromObject(pertainsList).toString();
        //System.out.println(json);
        PrintWriter pwriter = response.getWriter();
        pwriter.println(json);
        pwriter.flush();
        pwriter.close();
    }
}
