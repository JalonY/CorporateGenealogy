package entity;

/**
 * 企业点评实体类
 * @author: yjl
 * @date: 2018/7/24
 */
public class TCorpEvaluate {

    private Integer id;

    private Integer corpId;

    private Integer userId;

    private String evaluateInfo;

    private String evaluateDate;

    private Integer goodNum;

    private Integer label1;

    private Integer label2;

    private Integer label3;

    private TUser user;

    public TCorpEvaluate() {
    }

    public TCorpEvaluate(Integer id, Integer corpId, Integer userId, String evaluateInfo, String evaluateDate, Integer goodNum, Integer label1, Integer label2, Integer label3, TUser user) {
        this.id = id;
        this.corpId = corpId;
        this.userId = userId;
        this.evaluateInfo = evaluateInfo;
        this.evaluateDate = evaluateDate;
        this.goodNum = goodNum;
        this.label1 = label1;
        this.label2 = label2;
        this.label3 = label3;
        this.user = user;
    }

    public TCorpEvaluate(Integer corpId, Integer userId, String evaluateInfo, String evaluateDate, Integer label1, Integer label2, Integer label3) {
        this.corpId = corpId;
        this.userId = userId;
        this.evaluateInfo = evaluateInfo;
        this.evaluateDate = evaluateDate;
        this.label1 = label1;
        this.label2 = label2;
        this.label3 = label3;
    }

    public Integer getId() {
        return id;
    }

    public Integer getCorpId() {
        return corpId;
    }

    public Integer getUserId() {
        return userId;
    }

    public String getEvaluateInfo() {
        return evaluateInfo;
    }

    public String getEvaluateDate() {
        return evaluateDate;
    }

    public Integer getGoodNum() {
        return goodNum;
    }

    public Integer getLabel1() {
        return label1;
    }

    public Integer getLabel2() {
        return label2;
    }

    public Integer getLabel3() {
        return label3;
    }

    public TUser getUser() {
        return user;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setCorpId(Integer corpId) {
        this.corpId = corpId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public void setEvaluateInfo(String evaluateInfo) {
        this.evaluateInfo = evaluateInfo;
    }

    public void setEvaluateDate(String evaluateDate) {
        this.evaluateDate = evaluateDate;
    }

    public void setGoodNum(Integer goodNum) {
        this.goodNum = goodNum;
    }

    public void setLabel1(Integer label1) {
        this.label1 = label1;
    }

    public void setLabel2(Integer label2) {
        this.label2 = label2;
    }

    public void setLabel3(Integer label3) {
        this.label3 = label3;
    }

    public void setUser(TUser user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "TCorpEvaluate{" +
                "id=" + id +
                ", corpId=" + corpId +
                ", userId=" + userId +
                ", evaluateInfo='" + evaluateInfo + '\'' +
                ", evaluateDate='" + evaluateDate + '\'' +
                ", goodNum=" + goodNum +
                ", label1=" + label1 +
                ", label2=" + label2 +
                ", label3=" + label3 +
                ", user=" + user +
                '}';
    }
}
