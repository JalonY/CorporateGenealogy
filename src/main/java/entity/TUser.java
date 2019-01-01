package entity;

import java.util.List;

/**
 * 用户实体类
 * @author: yjl
 * @date: 2018/6/20
 */
public class TUser {

    private Integer id;

    private String account;

    private String password;

    private String name;

    private List<Integer> collectCorp;

    private List<Integer> attentionCorp;

    public TUser() {
    }

    public TUser(String account, String password) {
        this.account = account;
        this.password = password;
    }

    public TUser(String account, String password, String name) {
        this.account = account;
        this.password = password;
        this.name = name;
    }

    public Integer getId() {
        return id;
    }

    public String getAccount() {
        return account;
    }

    public String getPassword() {
        return password;
    }

    public String getName() {
        return name;
    }

    public List<Integer> getCollectCorp() {
        return collectCorp;
    }

    public List<Integer> getAttentionCorp() {
        return attentionCorp;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCollectCorp(List<Integer> collectCorp) {
        this.collectCorp = collectCorp;
    }

    public void setAttentionCorp(List<Integer> attentionCorp) {
        this.attentionCorp = attentionCorp;
    }

    @Override
    public String toString() {
        return "TUser{" +
                "id=" + id +
                ", account='" + account + '\'' +
                ", password='" + password + '\'' +
                ", name='" + name + '\'' +
                ", collectCorp=" + collectCorp +
                ", attentionCorp=" + attentionCorp +
                '}';
    }
}
