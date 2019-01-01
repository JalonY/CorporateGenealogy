package entity;

/**
 * 企业招聘实体类
 * @author: yjl
 * @date: 2018/7/21
 */
public class TCorpRecruit {

    private Integer id;

    private Integer corpId;

    private String corpName;

    private String jobName;

    private String jobAddress;

    private String jobMoney;

    private String publicDate;

    public TCorpRecruit() {
    }

    public TCorpRecruit(Integer id, Integer corpId, String corpName, String jobName, String jobAddress, String jobMoney, String publicDate) {
        this.id = id;
        this.corpId = corpId;
        this.corpName = corpName;
        this.jobName = jobName;
        this.jobAddress = jobAddress;
        this.jobMoney = jobMoney;
        this.publicDate = publicDate;
    }

    public Integer getId() {
        return id;
    }

    public Integer getCorpId() {
        return corpId;
    }

    public String getCorpName() {
        return corpName;
    }

    public String getJobName() {
        return jobName;
    }

    public String getJobAddress() {
        return jobAddress;
    }

    public String getJobMoney() {
        return jobMoney;
    }

    public String getPublicDate() {
        return publicDate;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setCorpId(Integer corpId) {
        this.corpId = corpId;
    }

    public void setCorpName(String corpName) {
        this.corpName = corpName;
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    public void setJobAddress(String jobAddress) {
        this.jobAddress = jobAddress;
    }

    public void setJobMoney(String jobMoney) {
        this.jobMoney = jobMoney;
    }

    public void setPublicDate(String publicDate) {
        this.publicDate = publicDate;
    }

    @Override
    public String toString() {
        return "TCorpRecruit{" +
                "id=" + id +
                ", corpId=" + corpId +
                ", corpName='" + corpName + '\'' +
                ", jobName='" + jobName + '\'' +
                ", jobAddress='" + jobAddress + '\'' +
                ", jobMoney='" + jobMoney + '\'' +
                ", publicDate='" + publicDate + '\'' +
                '}';
    }
}
