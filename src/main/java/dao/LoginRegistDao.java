package dao;

import entity.TUser;

import java.util.List;

/**
 * dao层，处理‘登录注册’主要请求
 * @author: yjl
 * @date: 2018/6/20
 */
public interface LoginRegistDao {

    //验证登录
    List<TUser> judgeUserLogin(TUser userLogin);

    //验证注册
    String judgeUserRegist(String regist_account);

    //用户注册
    int dealUserRegist(TUser userRegist);
}
