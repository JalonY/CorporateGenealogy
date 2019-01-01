package controller;

import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.iflytek.cloud.speech.*;
import entity.*;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.LoginRegistService;
import service.SearchCorpService;
import util.Bayes;
import util.FPTree;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * controller层，处理‘查企业’相关请求
 * @author: yjl
 * @date: 2018/4/9
 */
@Controller
public class SearchCorpController {
    @Autowired
    SearchCorpService searchCorpService;
    @Autowired
    LoginRegistService loginRegistService;
    HttpSession session ;

    //判断Cookie中用户的信息
    protected void getCookieInfo2(HttpServletRequest request, Cookie[] cookies) {
        String user_account;
        String user_password;
        if (cookies != null && cookies.length > 0) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("userLoginInfo")) {
                    String[] info = cookie.getValue().split(":");
                    user_account = info[0];
                    user_password = info[1];
                    TUser userLogin = new TUser(user_account,user_password);
                    List<TUser> tUserList = loginRegistService.judgeUserLogin(userLogin);

                    if(tUserList.size() > 0){
                        for (TUser tUser: tUserList){
                            request.setAttribute("loginUser",tUser );
                        }
                    }

                    session = request.getSession();
                    TUser tUser = (TUser) session.getAttribute("userLoginInfo");
                    getSessionInfo2(request, tUser);
                }else {
                    session = request.getSession();
                    TUser tUser = (TUser) session.getAttribute("userLoginInfo");
                    getSessionInfo2(request, tUser);
                }
            }
        }else if (cookies == null || cookies.length == 0) {
            request.setAttribute("status", "登录");
        }
    }
    //获取Session信息
    private void getSessionInfo2(HttpServletRequest request, TUser tUser) {
        PageJumpsController.getSession(request, tUser, loginRegistService.judgeUserLogin(tUser));
    }

    //获取最新注册的企业
    @RequestMapping(value="/getNewRegCorps.do")
    @ResponseBody
    public void getAllNewRegCorps(HttpServletResponse response) throws IOException {
        List<TCorp> allNewRegCorps = searchCorpService.getAllNewRegCorps();
        response.setContentType("text/html; charset=utf-8");
        String json = JSONArray.fromObject(allNewRegCorps).toString();
        //System.out.println(json);
        PrintWriter prier = response.getWriter();
        prier.println(json);
        prier.flush();
        prier.close();
    }

    //语音输入查询
    @RequestMapping(value="/voiceSearch.do")
    @ResponseBody
    public String voiceSearch(){
        SpeechUtility.createUtility(SpeechConstant.APPID + "=5b528510");
        String result = "";
        RecognizerListener mRecoListener = new RecognizerListener() {
            //音量值0~30
            @Override
            public void onVolumeChanged(int i) {
            }
            //开始录音
            @Override
            public void onBeginOfSpeech() {
                System.out.println("请说话");
            }
            //结束录音
            @Override
            public void onEndOfSpeech() {
                System.out.println("语音识别结束，识别结果如下");
            }
            //听写结果回调接口
            @Override
            public void onResult(RecognizerResult recognizerResult, boolean b) {
                String result = recognizerResult.getResultString();
                jsonExtract(result);
            }
            //会话发生错误回调接口
            @Override
            public void onError(SpeechError speechError) {
                speechError.getErrorDescription(true);
            }
            //扩展用接口
            @Override
            public void onEvent(int i, int i1, int i2, String s) {

            }
        };
        //1.创建SpeechRecognizer对象
        SpeechRecognizer mIat = SpeechRecognizer.createRecognizer();
        //2.设置听写参数，详见《MSC Reference Manual》SpeechConstant类
        mIat.setParameter(SpeechConstant.DOMAIN, "iat");
        mIat.setParameter(SpeechConstant.LANGUAGE, "zh_cn");
        mIat.setParameter(SpeechConstant.ACCENT, "mandarin ");
        //3.开始听写
        mIat.startListening(mRecoListener);
        // 因为异步的，没有这个，会直接输出
        while (mIat.isListening()) {
        }
         return result;
    }
    public void jsonExtract(String json) {
        Object object;
        // 判断是否符合json格式，因为如果不符合，会报错
        try {
            object = JSONObject.parse(json);
        } catch (JSONException e) {
            System.out.println("不符合json格式，" + e.getMessage());
            return;
        }
        JSONObject jsonObject;
        //JSON可能又多个元素
        if (object instanceof com.alibaba.fastjson.JSONArray) {
            com.alibaba.fastjson.JSONArray jsonArray = (com.alibaba.fastjson.JSONArray) object;
            for (int i = 0; i < jsonArray.size(); i++) {
                jsonObject = jsonArray.getJSONObject(i);
                dealJsonObject(jsonObject);
            }
        }
        // 单个元素时
        else if (object instanceof JSONObject) {
            jsonObject = (JSONObject) object;
            dealJsonObject(jsonObject);
        }
    }
    private void dealJsonObject(JSONObject jsonObject) {
        for (String key : jsonObject.keySet()) {
            String str = jsonObject.getString(key);
            if (key.equals("w")) {
                System.out.print(str);
                return;
            }
            jsonExtract(str);
        }
    }


    //高级查询企业
    @RequestMapping(value="/advancedSearch.do")
    @ResponseBody
    public String advancedSearch(@RequestParam(value = "top_inputName")String top_inputName,@RequestParam(value = "top_inputAddress")String top_inputAddress,
                                 @RequestParam(value = "top_CapiStart")String top_CapiStart,@RequestParam(value = "top_CapiEnd")String top_CapiEnd,
                                 @RequestParam(value = "top_ManName")String top_ManName,@RequestParam(value = "top_StockName")String top_StockName,
                                 @RequestParam(value = "top_inputScope")String top_inputScope){
        String message;
        String corpId = searchCorpService.advancedSearch(top_inputName,top_inputAddress,top_CapiStart,top_CapiEnd,top_ManName,top_StockName,top_inputScope);
        if(corpId == null || corpId.isEmpty()){
            message = "提示：未找到符合条件的企业！";
        }else{
            message = corpId;
        }

        return message;
    }


    //税号查询企业
    @RequestMapping(value="/getTaxCorp.do")
    @ResponseBody
    public void getTaxCorp(@RequestParam(value = "corp_name") String corp_name, HttpServletResponse response) throws IOException {
        TCorp taxCorpInfos = searchCorpService.getTaxCorp(corp_name);
        response.setContentType("text/html; charset=utf-8");
        String json = JSONArray.fromObject(taxCorpInfos).toString();
        //System.out.println(json);
        PrintWriter prier = response.getWriter();
        prier.println(json);
        prier.flush();
        prier.close();
    }


    //批量查询企业
    @RequestMapping(value="/batSearchCorp.do")
    @ResponseBody
    public String batSearchCorp(@RequestParam(value = "text")String text){
        String message = "";
        List<TCorp> tCorps = searchCorpService.getAllCorpName();
        for (TCorp tcorp: tCorps) {
            if(text.matches(".*"+tcorp.getCorpName()+".*") && !message.matches(".*"+tcorp.getCorpName()+".*")){
                message += tcorp.getCorpName()+"_"+tcorp.getId()+"&";
            }
        }

        return message;
    }


    //企业各种排序方式
    private static String corpOrderBy(@RequestParam(value = "pn", required = false, defaultValue = "1") Integer pn, String sort_type) {
        if(sort_type == null){
            sort_type = "默认排序";
        }

        if("注册资本升序".equals(sort_type)){
            String orderBy = "REG_CAPI" + " asc";
            PageHelper.startPage(pn, 5,orderBy);
        }else if("注册资本降序".equals(sort_type)){
            String orderBy = "REG_CAPI" + " desc";
            PageHelper.startPage(pn, 5,orderBy);
        }else if("注册时间升序".equals(sort_type)){
            String orderBy = "START_DATE" + " asc";
            PageHelper.startPage(pn, 5,orderBy);
        }else if("注册时间降序".equals(sort_type)){
            String orderBy = "START_DATE" + " desc";
            PageHelper.startPage(pn, 5,orderBy);
        }else{
            PageHelper.startPage(pn, 5);
        }
        return sort_type;
    }

    //根据名称获取相关企业并分页排序
    @RequestMapping(value="/select_corpByName.do")
    public String getListCorpByName(@RequestParam(value = "key") String userInput, @RequestParam(value = "pn",required = false,defaultValue = "1") Integer pn,
                                 Map<String,Object> map,HttpServletRequest request){
        String sort_type = request.getParameter("sort_type");

        sort_type = corpOrderBy(pn, sort_type);

        List<TCorp> listCorps = searchCorpService.getListCorpByName(userInput);
        PageInfo pageInfo = new PageInfo<>(listCorps,5);
        map.put("pageInfo",pageInfo);

        request.setAttribute("sort_type",sort_type);
        request.setAttribute("userInput",userInput);
        request.setAttribute("listCorps",listCorps);
        request.setAttribute("pageInfo",pageInfo);
        request.setAttribute("type_tip","select_corpByName");

        Cookie[] cookies = request.getCookies();
        getCookieInfo2(request, cookies);
        return "corp_list";
    }

    //根据法人/股东获取相关企业并分页排序
    @RequestMapping(value="/select_corpByStock.do")
    public String getListCorpByStock(@RequestParam(value = "key") String tip_other, @RequestParam(value = "pn",required = false,defaultValue = "1") Integer pn,
                                    Map<String,Object> map,HttpServletRequest request){
        String sort_type = request.getParameter("sort_type");

        sort_type = corpOrderBy(pn, sort_type);

        List<TCorp> listCorps = searchCorpService.getListCorpByStock(tip_other);
        PageInfo pageInfo = new PageInfo<>(listCorps,5);
        map.put("pageInfo",pageInfo);

        request.setAttribute("sort_type",sort_type);
        request.setAttribute("tip_other",tip_other);
        request.setAttribute("listCorps",listCorps);
        request.setAttribute("pageInfo",pageInfo);
        request.setAttribute("type_tip","select_corpByStock");

        Cookie[] cookies = request.getCookies();
        getCookieInfo2(request, cookies);
        return "corp_list";
    }

    //根据高管获取相关企业并分页排序
    @RequestMapping(value="/select_corpByManager.do")
    public String getListCorpByManager(@RequestParam(value = "key") String tip_other, @RequestParam(value = "pn",required = false,defaultValue = "1") Integer pn,
                                    Map<String,Object> map,HttpServletRequest request){
        String sort_type = request.getParameter("sort_type");

        sort_type = corpOrderBy(pn, sort_type);

        List<TCorp> listCorps = searchCorpService.getListCorpByManager(tip_other);
        PageInfo pageInfo = new PageInfo<>(listCorps,5);
        map.put("pageInfo",pageInfo);

        request.setAttribute("sort_type",sort_type);
        request.setAttribute("tip_other",tip_other);
        request.setAttribute("listCorps",listCorps);
        request.setAttribute("pageInfo",pageInfo);
        request.setAttribute("type_tip","select_corpByManager");

        Cookie[] cookies = request.getCookies();
        getCookieInfo2(request, cookies);
        return "corp_list";
    }

    //根据所属行业获取相关企业并分页排序
    @RequestMapping(value="/select_corpByIndu.do")
    public String getListCorpByIndu(@RequestParam(value = "key") String tip_other, @RequestParam(value = "pn",required = false,defaultValue = "1") Integer pn,
                                    Map<String,Object> map,HttpServletRequest request){
        String sort_type = request.getParameter("sort_type");

        sort_type = corpOrderBy(pn, sort_type);

        List<TCorp> listCorps = searchCorpService.getListCorpByIndu(tip_other);
        PageInfo pageInfo = new PageInfo<>(listCorps,5);
        map.put("pageInfo",pageInfo);

        request.setAttribute("sort_type",sort_type);
        request.setAttribute("tip_other",tip_other);
        request.setAttribute("listCorps",listCorps);
        request.setAttribute("pageInfo",pageInfo);
        request.setAttribute("type_tip","select_corpByIndu");

        Cookie[] cookies = request.getCookies();
        getCookieInfo2(request, cookies);
        return "corp_list";
    }


    //根据地址获取相关企业并分页排序
    @RequestMapping(value="/select_corpByAddress.do")
    public String getListCorpByAddress(@RequestParam(value = "key") String full_address, @RequestParam(value = "pn",required = false,defaultValue = "1") Integer pn,
                                       Map<String,Object> map,HttpServletRequest request){
        String city_name = full_address.substring(full_address.indexOf("-")+1, full_address.lastIndexOf("-"));
        String county_name = full_address.substring(full_address.indexOf("-",full_address.indexOf("-")+1 ) + 1,full_address.length());
        String sort_type = request.getParameter("sort_type");

        sort_type = corpOrderBy(pn, sort_type);

        List<TCorp> listCorps;
        if("市辖区".equals(county_name)){
            listCorps = searchCorpService.getListCorpByAddress(city_name);
        }else{
            listCorps = searchCorpService.getListCorpByAddress(county_name);
        }
        PageInfo pageInfo = new PageInfo<>(listCorps,5);
        map.put("pageInfo",pageInfo);

        request.setAttribute("sort_type",sort_type);
        request.setAttribute("listCorps",listCorps);
        request.setAttribute("pageInfo",pageInfo);
        request.setAttribute("tip_address",full_address);
        request.setAttribute("type_tip","select_corpByAddress");

        Cookie[] cookies = request.getCookies();
        getCookieInfo2(request, cookies);
        return "corp_list";
    }

    //根据日期获取相关企业并分页排序
    @RequestMapping(value="/select_corpByDate.do")
    public String getListCorpByDate(@RequestParam(value = "key") String date_input, @RequestParam(value = "pn",required = false,defaultValue = "1") Integer pn,
                                       Map<String,Object> map,HttpServletRequest request){
        //将输入框的字符截取分为before_date、after_date
        String before_date = date_input.substring(0,date_input.indexOf(" "));
        String after_date = date_input.substring(date_input.indexOf(" ",date_input.indexOf(" ")+1 ) + 1,date_input.length());

        //将before_date格式化为日期new_before_date
        String before_date_month = before_date.substring(0,before_date.indexOf("/"));
        String before_date_day = before_date.substring(before_date.indexOf("/") + 1,before_date.indexOf("/",before_date.indexOf("/")+1 ));
        String before_date_year = before_date.substring(before_date.indexOf("/",before_date.indexOf("/")+1 ) + 1,before_date.length());
        if(Integer.parseInt(before_date_year) >= 0 && Integer.parseInt(before_date_year) <= 20){
            before_date_year = "20" + before_date_year;
        }else{
            before_date_year = "19" + before_date_year;
        }
        String new_before_date = before_date_year + "-" + before_date_month + "-" + before_date_day;

        //将after_date格式化为日期new_after_date
        String after_date_month = after_date.substring(0,after_date.indexOf("/"));
        String after_date_day = after_date.substring(after_date.indexOf("/") + 1,after_date.indexOf("/",after_date.indexOf("/")+1 ));
        String after_date_year = after_date.substring(after_date.indexOf("/",date_input.indexOf("/")+1 ) + 1,after_date.length());
        if(Integer.parseInt(after_date_year) >= 0 && Integer.parseInt(after_date_year) <= 20){
            after_date_year = "20" + after_date_year;
        }else{
            after_date_year = "19" + after_date_year;
        }
        String new_after_date = after_date_year + "-" + after_date_month + "-" + after_date_day;

        String sort_type = request.getParameter("sort_type");

        sort_type = corpOrderBy(pn, sort_type);

        List<TCorp> listCorps = searchCorpService.getListCorpByDate(new_before_date,new_after_date);

        PageInfo pageInfo = new PageInfo<>(listCorps,5);
        map.put("pageInfo",pageInfo);

        request.setAttribute("sort_type",sort_type);
        request.setAttribute("listCorps",listCorps);
        request.setAttribute("pageInfo",pageInfo);
        request.setAttribute("tip_date",date_input);
        request.setAttribute("type_tip","select_corpByDate");

        Cookie[] cookies = request.getCookies();
        getCookieInfo2(request, cookies);
        return "corp_list";
    }


    //设置文件写入规则
    private static String joinList(List<String> list) {
        if (list == null || list.size() == 0) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (String ele : list) {
            sb.append(ele);
            sb.append(",");
        }
        return sb.substring(0, sb.length() - 1);
    }

    //两种集合中数量不足进行补充
    private void getSomeCorpName(List<String> corpList,String corpName) {
        if(corpList.size() < 5){
            int corpNum = corpList.size();
            List<TCorp> someCorpNames = searchCorpService.getSomeCorpName(5-corpNum,corpName);
            for(TCorp someCorpName: someCorpNames){
                corpList.add(someCorpName.getCorpName());
            }
        }
    }

    //点击企业名称获取企业信息
    @RequestMapping(value="/see_details.do")
    public String toCorpInfoPage(@RequestParam(value = "corp_id") int corp_id, HttpServletRequest request) throws IOException {
        List<TCorp> corpIfs = searchCorpService.getCorpInfo(corp_id);
        TCorp tCorp = new TCorp();
        String corpName = DataDownloadController.dealCorpInfo(corpIfs, tCorp);
        request.setAttribute("Corp_Info",tCorp);

        //获取所有用户的搜索记录
        List<TQueryHistory> allQueryHistory = searchCorpService.getAllQueryHistory();

        //根据账号分类去重
        Map<String, Integer> accountMap = new HashMap();
        for(TQueryHistory tQueryHistory: allQueryHistory){
            accountMap.put(tQueryHistory.getUserAccount(),0);
        }

        //根据已分类账号重新分配
        Map<String,List<String>> newQueryHistoryMap = new HashMap<>();
        for(Map.Entry<String,Integer> entry: accountMap.entrySet()){
            String account = entry.getKey();
            List<String> accountTQueryHistoryList = new ArrayList<>();
            for(TQueryHistory tQueryHistory: allQueryHistory){
                if(tQueryHistory.getUserAccount().equals(account)){
                    accountTQueryHistoryList.add(tQueryHistory.getQueryCorpName());
                }
            }
            newQueryHistoryMap.put(account,accountTQueryHistoryList);
        }

        //遍历Map将企业名称写入文件outfile，并传至FPTree
        String outfile = "QueryHistory.txt";
        BufferedWriter bw = new BufferedWriter(new FileWriter(outfile));
        for(Map.Entry<String,List<String>> entry: newQueryHistoryMap.entrySet()){
            List<String> corpNameList = entry.getValue();

            bw.write(joinList(corpNameList));
            bw.newLine();
        }
        bw.close();

        //Map取值分别放入对应的集合
        Map<String, List<String>> corpMap = FPTree.introQueryHistory(outfile,corpName);
        List<String> interestedCorpList = new ArrayList<>();
        List<String> otherSearchCorpList = new ArrayList<>();
        for(Map.Entry<String,List<String>> entry: corpMap.entrySet()){
            if("interestedCorpList".equals(entry.getKey())){
                interestedCorpList = entry.getValue();
            }
            if("otherSearchCorpList".equals(entry.getKey())){
                otherSearchCorpList = entry.getValue();
            }
        }

        getSomeCorpName(interestedCorpList,corpName);
        getSomeCorpName(otherSearchCorpList,corpName);

        request.setAttribute("interestedCorpLists",interestedCorpList);
        request.setAttribute("otherSearchCorpLists",otherSearchCorpList);

        //获取当前企业点评内容
        List<TCorpEvaluate> tCorpEvaluates = searchCorpService.getAllCorpEvalates(corp_id);
        request.setAttribute("tCorpEvaluates",tCorpEvaluates);


        Cookie[] cookies = request.getCookies();
        getCookieInfo2(request, cookies);

        //根据用户账号查找搜索记录并写入
        for(Cookie cookie:cookies){
            if(cookie.getName().equals("userLoginInfo")){
                String valueString = cookie.getValue();
                if(null != valueString || valueString != ""){
                    String userAccount = valueString.substring(0,valueString.indexOf(":"));
                    TQueryHistory history = new TQueryHistory(userAccount,corpName);
                    String searchName = searchCorpService.selectSearch(history);
                    if(null == searchName || searchName.length() == 0){
                        TQueryHistory queryHistory = new TQueryHistory(userAccount,corpName);
                        searchCorpService.addSearchHistory(queryHistory);
                    }
                }
            }
        }

        return "corp_info";
    }

    //根据企业ID与法定代表人的得到疑似控股人
    @RequestMapping(value="/getStockRatio.do")
    @ResponseBody
    public String getStockRatio(@RequestParam(value = "id") int corp_id,@RequestParam(value = "operManName") String operManName){
        //获取企业股东投资比例计算实际控股人模块
        List<TCorpStock> ratioLists = searchCorpService.getStockRatio(corp_id);
        TCorpStock suspectedStock = getSuspectedStock(ratioLists,operManName);

        return suspectedStock.getStockName()+":"+suspectedStock.getStockPercent();
    }
    //得出企业疑似控股人
    private TCorpStock getSuspectedStock(List<TCorpStock> ratioLists,String operManName) {
        TCorpStock newStrock = new TCorpStock("  ？  ","  ？  ");
        if(null == ratioLists || ratioLists.size() == 0){
            newStrock = new TCorpStock(operManName,"  ？  ");
        }else{
            for (TCorpStock tCorpStock: ratioLists) {
                if(ratioLists.size() == 1){
                    double temp = Double.valueOf(tCorpStock.getStockPercent()).doubleValue();
                    String newString = StringUtils.rightPad(Double.toString(temp),8,"0");

                    return new TCorpStock(tCorpStock.getStockName(),newString.substring(0,7)+"%");
                }else if(ratioLists.size() == 2){
                    double temp = Double.valueOf(tCorpStock.getStockPercent()).doubleValue();
                    if(temp > (66.6666)){
                        String legalYN = tCorpStock.getStockName().equals(operManName)?"Yes":"No";
                        String doubleOperYN = doubleStrockYN(ratioLists,operManName,temp);
                        boolean flag = Bayes.importData("Medium","High","Yes",legalYN,doubleOperYN);

                        if(flag){
                            String newString = StringUtils.rightPad(Double.toString(temp),8,"0");
                            return new TCorpStock(tCorpStock.getStockName(),newString.substring(0,7)+"%");
                        }
                    }else if((33.3333)<=temp  && temp<=(66.6666) && tCorpStock.getStockName().equals(operManName)){
                        String maxStrockYN = maxStrockYN(ratioLists,temp);
                        String doubleOperYN = doubleStrockYN(ratioLists,operManName,temp);
                        boolean flag = Bayes.importData("Medium","Medium",maxStrockYN,"Yes",doubleOperYN);

                        if (flag){
                            String newString = StringUtils.rightPad(Double.toString(temp),8,"0");
                            return new TCorpStock(tCorpStock.getStockName(),newString.substring(0,7)+"%");
                        }
                    }
                }else if(ratioLists.size() >= 3){
                    double temp = Double.valueOf(tCorpStock.getStockPercent()).doubleValue();
                    if(temp > (66.6666)){
                        String legalYN = tCorpStock.getStockName().equals(operManName)?"Yes":"No";
                        String doubleOperYN = doubleStrockYN(ratioLists,operManName,temp);
                        boolean flag = Bayes.importData("High","High","Yes",legalYN,doubleOperYN);

                        if(flag){
                            String newString = StringUtils.rightPad(Double.toString(temp),8,"0");
                            return new TCorpStock(tCorpStock.getStockName(),newString.substring(0,7)+"%");
                        }
                    }else if((33.3333)<=temp  && temp<=(66.6666) && tCorpStock.getStockName().equals(operManName)){
                        String maxStrockYN = maxStrockYN(ratioLists,temp);
                        String doubleOperYN = doubleStrockYN(ratioLists,operManName,temp);
                        boolean flag = Bayes.importData("High","Medium",maxStrockYN,"Yes",doubleOperYN);

                        if (flag){
                            String newString = StringUtils.rightPad(Double.toString(temp),8,"0");
                            return new TCorpStock(tCorpStock.getStockName(),newString.substring(0,7)+"%");
                        }
                    }else{
                        String legalYN = tCorpStock.getStockName().equals(operManName)?"Yes":"No";
                        String maxStrockYN = maxStrockYN(ratioLists,temp);
                        String doubleOperYN = doubleStrockYN(ratioLists,operManName,temp);
                        boolean flag = Bayes.importData("High","Low",maxStrockYN,legalYN,doubleOperYN);

                        if (flag){
                            String newString = StringUtils.rightPad(Double.toString(temp),8,"0");
                            return new TCorpStock(tCorpStock.getStockName(),newString.substring(0,7)+"%");
                        }
                    }
                }else{
                    newStrock = new TCorpStock("  ？  ","  ？  ");
                }
            }
        }

        return newStrock;
    }
    //判断是否是投资最大
    private String maxStrockYN(List<TCorpStock> ratioLists,double stock){
        double maxStrock = 0;
        for (TCorpStock tCorpStock: ratioLists) {
            double temp = Double.valueOf(tCorpStock.getStockPercent()).doubleValue();
            if(temp > maxStrock){
                maxStrock = temp;
            }
        }

        if(stock >= maxStrock){
            return "Yes";
        }else {
            return "No";
        }
    }
    //判断当前投资比例与法人投资比例
    private String doubleStrockYN(List<TCorpStock> ratioLists,String operManName,double stock){
        double operStrock = 0;
        for (TCorpStock tCorpStock: ratioLists) {
            double temp = Double.valueOf(tCorpStock.getStockPercent()).doubleValue();
            if(tCorpStock.getStockName().equals(operManName)){
                operStrock = temp;
            }
        }

        if(stock > 2 * operStrock){
            return "Yes";
        }else {
            return "No";
        }
    }


    //根据企业ID查询公司主要人员
    @RequestMapping(value="/getCorpPertains.do")
    @ResponseBody
    public void getCorpPertains(@RequestParam(value = "corp_id1") int corp_id, HttpServletResponse response) throws IOException {
        List<TCorpPertains> list1 = searchCorpService.getCorpPertains(corp_id);

        response.setContentType("text/html; charset=utf-8");
        String json = JSONArray.fromObject(list1).toString();
        //System.out.println(json);
        PrintWriter pwriter = response.getWriter();
        pwriter.println(json);
        pwriter.flush();
        pwriter.close();
    }

    //根据企业ID查询公司主要股东
    @RequestMapping(value="/getCorpStock.do")
    @ResponseBody
    public void getCorpStock(@RequestParam(value = "corp_id2") int corp_id,HttpServletResponse response) throws IOException {
        List<TCorpStock> list2 = searchCorpService.getCorpStock(corp_id);

        response.setContentType("text/html; charset=utf-8");
        String json = JSONArray.fromObject(list2).toString();
        //System.out.println(json);
        PrintWriter pwriter = response.getWriter();
        pwriter.println(json);
        pwriter.flush();
        pwriter.close();
    }

    //根据企业ID查询公司分支机构
    @RequestMapping(value="/getCorpDist.do")
    @ResponseBody
    public void getCorpDist(@RequestParam(value = "corp_id3") int corp_id,HttpServletResponse response) throws IOException {
        List<TCorpDist> list3 = searchCorpService.getCorpDist(corp_id);

        response.setContentType("text/html; charset=utf-8");
        String json = JSONArray.fromObject(list3).toString();
        //System.out.println(json);
        PrintWriter pwriter = response.getWriter();
        pwriter.println(json);
        pwriter.flush();
        pwriter.close();
    }

    //根据人员姓名查询所属企业名
    @RequestMapping(value="/getCorpNameByPersonName.do")
    @ResponseBody
    public void getCorpNameByPersonName(@RequestParam(value= "list") List list,HttpServletResponse response) throws IOException {
        List<TCorp> tcorpList;
        List newList = new ArrayList();
        for(int i = 0;i < list.size();i++){
            tcorpList = searchCorpService.getCorpNameByPersonNames((String)list.get(i));
            for (int j = 0;j < tcorpList.size();j++){
                newList.add(tcorpList.get(j));
            }

        }
        response.setContentType("text/html; charset=utf-8");
        String json = JSONArray.fromObject(newList).toString();
        //System.out.println(json);
        PrintWriter pwriter = response.getWriter();
        pwriter.println(json);
        pwriter.flush();
        pwriter.close();
    }

    //根据公司注册号查询股东以及再查询对外投资情况
    @RequestMapping(value="/getStockAndDistByRegNo.do")
    @ResponseBody
    public void getStockAndDistByRegNo(@RequestParam(value = "corpRegNo") String corpRegNo,HttpServletResponse response) throws IOException {
        List newList = new ArrayList();
        List<TCorpStock> list = searchCorpService.getStockIdByRegNo(corpRegNo);
        for(int i = 0;i < list.size();i++){
            List<TCorp>  tcorpList = searchCorpService.getStockCorpByStockId(list.get(i).getId());
            for (int j = 0;j < tcorpList.size();j++){
                newList.add(tcorpList.get(j));
            }

        }

        response.setContentType("text/html; charset=utf-8");
        String json = JSONArray.fromObject(newList).toString();
        //System.out.println(json);
        PrintWriter pwriter = response.getWriter();
        pwriter.println(json);
        pwriter.flush();
        pwriter.close();
    }

    //根据股东注册号关联企业查询该企业的股东
    @RequestMapping(value="/getCorpStockByStockCertificateNo.do")
    @ResponseBody
    public void getCorpStockByStockCertificateNo(@RequestParam(value = "certificateNo") String certificateNo,HttpServletResponse response) throws IOException {
        List<TCorpStock> list = searchCorpService.getCorpStockByStockCertificateNo(certificateNo);
        response.setContentType("text/html; charset=utf-8");
        String json = JSONArray.fromObject(list).toString();
        //System.out.println(json);
        PrintWriter pwriter = response.getWriter();
        pwriter.println(json);
        pwriter.flush();
        pwriter.close();
    }

    //根据企业分公司名查询该分公司下的公司
    @RequestMapping(value="/getCorpDistByDistName.do")
    @ResponseBody
    public void getCorpDistByDistName(@RequestParam(value = "distName") String distName,HttpServletResponse response) throws IOException {
        List<TCorpStock> list = searchCorpService.getCorpDistByDistName(distName);
        response.setContentType("text/html; charset=utf-8");
        String json = JSONArray.fromObject(list).toString();
        //System.out.println(json);
        PrintWriter pwriter = response.getWriter();
        pwriter.println(json);
        pwriter.flush();
        pwriter.close();
    }


    //根据用户Id获取收藏企业
    @RequestMapping(value="/showCollect.do")
    @ResponseBody
    public void showCollect(@RequestParam(value = "userId") int userId,HttpServletResponse response) throws IOException {
        List<TCollectCorp> collectCorpIds = searchCorpService.getCollectIds(userId);
        List userCollectCorps = new ArrayList();
        for (TCollectCorp collectCorp: collectCorpIds) {
            userCollectCorps.add(searchCorpService.getCollectAttentionCorps(collectCorp.getCorpId()));
        }

        response.setContentType("text/html; charset=utf-8");
        String json = JSONArray.fromObject(userCollectCorps).toString();
        //System.out.println(json);
        PrintWriter pwriter = response.getWriter();
        pwriter.println(json);
        pwriter.flush();
        pwriter.close();
    }

    //根据用户Id获取关注企业
    @RequestMapping(value="/showAttention.do")
    @ResponseBody
    public void showAttention(@RequestParam(value = "userId") int userId,HttpServletResponse response) throws IOException {
        List<TAttentionCorp> attentionCorpIds = searchCorpService.getAttentionIds(userId);
        List userAttentionCorps = new ArrayList();
        for (TAttentionCorp attentionCorp: attentionCorpIds) {
            userAttentionCorps.add(searchCorpService.getCollectAttentionCorps(attentionCorp.getCorpId()));
        }

        response.setContentType("text/html; charset=utf-8");
        String json = JSONArray.fromObject(userAttentionCorps).toString();
        //System.out.println(json);
        PrintWriter pwriter = response.getWriter();
        pwriter.println(json);
        pwriter.flush();
        pwriter.close();
    }

    //根据用户Id与收藏企业ID删除收藏企业
    @RequestMapping(value="/deleteCollect.do")
    public String deleteCollect(@RequestParam(value = "userId") int userId,@RequestParam(value = "corpId") int corpId){
        searchCorpService.deleteCollect(userId,corpId);
        return "redirect:/see_details.do?corp_id="+corpId;
    }

    //根据用户Id与关注企业ID删除关注企业
    @RequestMapping(value="/deleteAttention.do")
    public String deleteAttention(@RequestParam(value = "userId") int userId,@RequestParam(value = "corpId") int corpId){
        searchCorpService.deleteAttention(userId,corpId);
        return "redirect:/see_details.do?corp_id="+corpId;
    }

    //根据用户Id与收藏企业ID添加收藏企业
    @RequestMapping(value="/collectCorp.do")
    @ResponseBody
    public void collectCorp(@RequestParam(value = "userId") Integer userId,@RequestParam(value = "corpId") Integer corpId,HttpServletResponse response) throws IOException {
        TCollectCorp collectCorp = new TCollectCorp(userId,corpId);
        int num1 = searchCorpService.collectCorp(collectCorp);

        response.setContentType("text/html; charset=utf-8");
        String json = JSONArray.fromObject(num1).toString();
        //System.out.println(json);
        PrintWriter pwriter = response.getWriter();
        pwriter.println(json);
        pwriter.flush();
        pwriter.close();
    }

    //根据用户Id与关注企业ID添加关注企业
    @RequestMapping(value="/attentionCorp.do")
    @ResponseBody
    public void attentionCorp(@RequestParam(value = "userId") Integer userId,@RequestParam(value = "corpId") Integer corpId,HttpServletResponse response) throws IOException {
        TAttentionCorp attentionCorp = new TAttentionCorp(userId,corpId);
        int num2 = searchCorpService.attentionCorp(attentionCorp);

        response.setContentType("text/html; charset=utf-8");
        String json = JSONArray.fromObject(num2).toString();
        //System.out.println(json);
        PrintWriter pwriter = response.getWriter();
        pwriter.println(json);
        pwriter.flush();
        pwriter.close();
    }

    //根据用户Id，添加企业点评
    @RequestMapping(value="/userEvaluate.do")
    @ResponseBody
    public String userEvaluate(@RequestParam(value = "corpId") Integer corpId,@RequestParam(value = "userId") Integer userId,
                               @RequestParam(value = "evaluate_info") String evaluate_info,@RequestParam(value = "label1") Integer label1,
                               @RequestParam(value = "label2") Integer label2,@RequestParam(value = "label3") Integer label3){
        String message = "";
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String dateNowStr = sdf.format(d);

        TCorpEvaluate tCorpEvaluate = new TCorpEvaluate(corpId,userId,evaluate_info,dateNowStr,label1,label2,label3);
        int i = searchCorpService.userEvaluate(tCorpEvaluate);
        if(i > 0){
            message = "提示：您为当前企业点评成功！";
        }
        return message;
    }

}
