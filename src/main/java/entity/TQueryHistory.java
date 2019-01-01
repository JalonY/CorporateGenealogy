package entity;

/**
 * 用户搜索历史记录
 * @author: yjl
 * @date: 2018/5/24
 */
public class TQueryHistory {

    private Integer id;

    private String userAccount;

    private String queryCorpName;

    public TQueryHistory() {
    }

    public TQueryHistory(String userAccount, String queryCorpName) {
        this.userAccount = userAccount;
        this.queryCorpName = queryCorpName;
    }

    public TQueryHistory(Integer id, String userAccount, String queryCorpName) {
        this.id = id;
        this.userAccount = userAccount;
        this.queryCorpName = queryCorpName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(String userAccount) {
        this.userAccount = userAccount;
    }

    public String getQueryCorpName() {
        return queryCorpName;
    }

    public void setQueryCorpName(String queryCorpName) {
        this.queryCorpName = queryCorpName;
    }


    @Override
    public String toString() {
        return "TQueryHistory{" +
                "id=" + id +
                ", userAccount='" + userAccount + '\'' +
                ", queryCorpName='" + queryCorpName + '\'' +
                '}';
    }
}
