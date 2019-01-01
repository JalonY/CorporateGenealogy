package service;

import entity.TUser;

import java.util.List;

/**
 * service层接口，处理‘登录注册’主要请求
 * @author: yjl
 * @date: 2018/6/20
 */
public interface LoginRegistService {

    List<TUser> judgeUserLogin(TUser userLogin);    //验证登录

    String judgeUserRegist(String regist_account);  //验证注册

    int dealUserRegist(TUser userRegist);           //用户注册

}
