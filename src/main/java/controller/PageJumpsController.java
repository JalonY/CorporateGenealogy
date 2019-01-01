package controller;

import entity.TCorp;
import entity.TCorpRecruit;
import entity.TUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import service.LoginRegistService;
import service.SearchCorpService;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 处理跳转界面的请求
 * @author: yjl
 * @date: 2018/4/12
 */
@Controller
public class PageJumpsController {
    @Autowired
    SearchCorpService searchCorpService;
    @Autowired
    LoginRegistService loginRegistService;
    HttpSession session ;

    //判断Cookie中用户的信息
    protected void getCookieInfo1(HttpServletRequest request, Cookie[] cookies) {
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
                    getSessionInfo1(request, tUser);
                }else {
                    session = request.getSession();
                    TUser tUser = (TUser) session.getAttribute("userLoginInfo");
                    getSessionInfo1(request, tUser);
                }
            }
        }else if (cookies == null || cookies.length == 0) {
            request.setAttribute("status", "登录");
        }
    }
    //获取Session信息
    private void getSessionInfo1(HttpServletRequest request, TUser tUser) {
        getSession(request, tUser, loginRegistService.judgeUserLogin(tUser));
    }
    //判断Session中用户的信息
    static void getSession(HttpServletRequest request, TUser tUser, List<TUser> tUsers2) {
        if(tUser != null){
            List<TUser> tUsers = tUsers2;
            for(TUser user: tUsers){
                request.setAttribute("status", user.getName());
                request.setAttribute("loginUser",user );
            }
        }else {
            request.setAttribute("status", "登录");
        }
    }

    //跳转至‘查企业’页面
    @RequestMapping(value="/search_corp.do")
    public String toSearchCorpPage(HttpServletRequest request){
        Cookie[] cookies = request.getCookies();
        getCookieInfo1(request, cookies);

        List<TCorp> allNewMarCorps = searchCorpService.getAllNewMarCorps();
        List<TCorp> allNewFinCorps = searchCorpService.getAllNewFinCorps();
        List<TCorpRecruit> allCorpRecruit = searchCorpService.getAllCorpRecruit();

        request.setAttribute("allNewMarCorps",allNewMarCorps);
        request.setAttribute("allNewFinCorps",allNewFinCorps);
        request.setAttribute("allCorpRecruits",allCorpRecruit);
        return "search_corp";
    }

    //跳转至‘查老板’页面
    @RequestMapping(value="/search_boss.do")
    public String toSearchBossPage(HttpServletRequest request){
        Cookie[] cookies = request.getCookies();
        getCookieInfo1(request, cookies);
        return "search_boss";
    }

    //跳转至‘查关系’页面
    @RequestMapping(value="/search_rela.do")
    public String toSearchRelaPage(HttpServletRequest request){
        Cookie[] cookies = request.getCookies();
        getCookieInfo1(request, cookies);

        return "search_rela";
    }

    //跳转至‘联系我们’页面
    @RequestMapping(value="/contact_us.do")
    public String toContactUsPage(HttpServletRequest request){
        Cookie[] cookies = request.getCookies();
        getCookieInfo1(request, cookies);

        return "contact_us";
    }

    //跳转至‘地图查询’页面
    @RequestMapping(value="/search_map.do")
    public String toSearchMapPage(HttpServletRequest request){
        Cookie[] cookies = request.getCookies();
        getCookieInfo1(request, cookies);

        return "search_map";
    }

}
