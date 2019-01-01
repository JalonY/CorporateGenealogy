package service.impl;

import dao.LoginRegistDao;
import dao.SearchCorpDao;
import entity.TUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import service.LoginRegistService;

import java.util.List;

/**
 * @author: yjl
 * @date: 2018/6/20
 */
@Service
public class LoginRegistServiceImpl implements LoginRegistService {

    @Autowired
    LoginRegistDao loginRegistDao;

    //验证登录
    @Override
    public List<TUser> judgeUserLogin(TUser userLogin) { return loginRegistDao.judgeUserLogin(userLogin); }

    //验证注册
    @Override
    public String judgeUserRegist(String regist_account) {
        return loginRegistDao.judgeUserRegist(regist_account);
    }

    //用户注册
    @Override
    public int dealUserRegist(TUser userRegist) {
        return loginRegistDao.dealUserRegist(userRegist);
    }
}
