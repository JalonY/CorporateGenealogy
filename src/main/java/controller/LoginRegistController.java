package controller;

import entity.TUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.LoginRegistService;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * 处理"用户登录注册"的请求
 * @author: yjl
 * @date: 2018/6/20
 */
@Controller
public class LoginRegistController {
    @Autowired
    LoginRegistService loginRegistService;
    HttpSession session ;


    //验证登录
    @RequestMapping(value="/userLogin.do")
    @ResponseBody
    public String judgeUserLogin(@RequestParam(value = "login_account")String login_account,@RequestParam(value = "login_password")String login_password,HttpServletRequest request, HttpServletResponse response){
        String message;
        TUser userLogin = new TUser(login_account,login_password);
        session = request.getSession();

        List<TUser> tUserList = loginRegistService.judgeUserLogin(userLogin);
        if(tUserList.size() > 0){
            Cookie cookie = new Cookie("userLoginInfo",login_account + ":" + login_password);
            cookie.setMaxAge(30*60);
            response.addCookie(cookie);
            session.setAttribute("userLoginInfo", userLogin);
            message = "提示：登录成功！";
        }else{
            message = "提示：账号或密码输入有误！";
        }
        return message;
    }

    //用户注册
    @RequestMapping(value="/userRegist.do")
    @ResponseBody
    public String judgeUserRegist(@RequestParam(value = "regist_account")String regist_account,@RequestParam(value = "regist_password1")String regist_password1,
                                  @RequestParam(value = "regist_password2")String regist_password2,@RequestParam(value = "regist_name")String regist_name,
                                  HttpServletResponse response,HttpServletRequest request){
        String message;
        String userInfoYN = loginRegistService.judgeUserRegist(regist_account);
        if(userInfoYN == null || userInfoYN.isEmpty()){
            if(regist_password1.equals(regist_password2)){
                TUser userRegist = new TUser(regist_account,regist_password1,regist_name);
                int num = loginRegistService.dealUserRegist(userRegist);
                if (num > 0){
                    TUser userLogin = new TUser(regist_account,regist_password1);
                    session = request.getSession();
                    Cookie cookie = new Cookie("userLoginInfo",regist_account + ":" + regist_password1);
                    cookie.setMaxAge(10*60);
                    response.addCookie(cookie);
                    session.setAttribute("userLoginInfo", userLogin);
                    message = "提示：注册成功！";
                }else {
                    message = "提示：注册失败！";
                }
            }else{
                message = "提示：两次输入密码不一致！";
            }
        }else{
            message = "提示：当前账号已存在，请重新注册！";
        }
        return message;
    }

    //退出登录
    @RequestMapping(value="/loginOut.do")
    public String loginOut(HttpServletRequest request,HttpServletResponse response) {
        Cookie cookie = new Cookie("userLoginInfo","1234");
        cookie.setMaxAge(0);
        response.addCookie(cookie);
        session = request.getSession();
        session.removeAttribute("userLoginInfo");
        session.invalidate();

        return "redirect:/search_corp.do";
    }

}
