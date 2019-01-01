package entity;

import java.util.List;

/**
 * 公司/企业实体类
 * @author: yjl
 * @date: 2018/4/25
 */
public class TCorp{

    private Integer id;

    private String regNo;

    private String corpName;

    private String corpAddr;

    private String belongOrg;

    private String belongDistOrg;

    private String belongTrade;

    private String econKind;

    private String admitMain;

    private String startDate;

    private String checkDate;

    private String operManIdentNo;

    private String operManName;

    private String corpStatus;

    private Integer regCapi;

    private Integer paidCapi;

    private String fareTermStart;

    private String fareTermEnd;

    private String fareScope;

    private String uniScid;

    private String corpTel;

    private String corpWebUrl;

    private String corpEmail;

    private String corpLogo;

    private String pracPersonNum;

    private String orgInstCode;

    private String taxpayNum;

    private String staffSize;

    private String englishName;

    private String formerName;

    private String createDate;

    private Integer createOrg;

    private String corpInfo;

    private String value;

    private TCorpPertains tcorppertains;

    private List<TCorpDist> corpDistList;

    private List<TCorpPertains> corpPertainsList;

    private List<TCorpStock> corpStockList;


    public TCorp() {
        super();
    }

    public TCorp(Integer id, String regNo, String corpName, String corpAddr, String belongOrg,
                 String belongDistOrg, String belongTrade, String econKind, String admitMain,
                 String startDate, String checkDate, String operManIdentNo, String operManName,
                 String corpStatus, Integer regCapi, Integer paidCapi, String fareTermStart,
                 String fareTermEnd, String fareScope, String uniScid, String corpTel, String corpWebUrl,
                 String corpEmail, String pracPersonNum, String orgInstCode, String taxpayNum,
                 String staffSize, String englishName, String formerName, String createDate,
                 Integer createOrg, String corpInfo, String value, TCorpPertains tcorppertains,
                 List<TCorpDist> corpDistList, List<TCorpPertains> corpPertainsList,
                 List<TCorpStock> corpStockList) {
        this.id = id;
        this.regNo = regNo;
        this.corpName = corpName;
        this.corpAddr = corpAddr;
        this.belongOrg = belongOrg;
        this.belongDistOrg = belongDistOrg;
        this.belongTrade = belongTrade;
        this.econKind = econKind;
        this.admitMain = admitMain;
        this.startDate = startDate;
        this.checkDate = checkDate;
        this.operManIdentNo = operManIdentNo;
        this.operManName = operManName;
        this.corpStatus = corpStatus;
        this.regCapi = regCapi;
        this.paidCapi = paidCapi;
        this.fareTermStart = fareTermStart;
        this.fareTermEnd = fareTermEnd;
        this.fareScope = fareScope;
        this.uniScid = uniScid;
        this.corpTel = corpTel;
        this.corpWebUrl = corpWebUrl;
        this.corpEmail = corpEmail;
        this.pracPersonNum = pracPersonNum;
        this.orgInstCode = orgInstCode;
        this.taxpayNum = taxpayNum;
        this.staffSize = staffSize;
        this.englishName = englishName;
        this.formerName = formerName;
        this.createDate = createDate;
        this.createOrg = createOrg;
        this.corpInfo = corpInfo;
        this.value = value;
        this.tcorppertains = tcorppertains;
        this.corpDistList = corpDistList;
        this.corpPertainsList = corpPertainsList;
        this.corpStockList = corpStockList;
    }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRegNo() {
        return regNo;
    }

    public void setRegNo(String regNo) {
        this.regNo = regNo;
    }

    public String getCorpName() {
        return corpName;
    }

    public void setCorpName(String corpName) {
        this.corpName = corpName;
    }

    public String getCorpAddr() {
        return corpAddr;
    }

    public void setCorpAddr(String corpAddr) {
        this.corpAddr = corpAddr;
    }

    public String getBelongOrg() {
        return belongOrg;
    }

    public void setBelongOrg(String belongOrg) {
        this.belongOrg = belongOrg;
    }

    public String getBelongDistOrg() {
        return belongDistOrg;
    }

    public void setBelongDistOrg(String belongDistOrg) {
        this.belongDistOrg = belongDistOrg;
    }

    public String getBelongTrade() {
        return belongTrade;
    }

    public void setBelongTrade(String belongTrade) {
        this.belongTrade = belongTrade;
    }

    public String getEconKind() {
        return econKind;
    }

    public void setEconKind(String econKind) {
        this.econKind = econKind;
    }

    public String getAdmitMain() {
        return admitMain;
    }

    public void setAdmitMain(String admitMain) {
        this.admitMain = admitMain;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getCheckDate() {
        return checkDate;
    }

    public void setCheckDate(String checkDate) {
        this.checkDate = checkDate;
    }

    public String getOperManIdentNo() {
        return operManIdentNo;
    }

    public void setOperManIdentNo(String operManIdentNo) {
        this.operManIdentNo = operManIdentNo;
    }

    public String getOperManName() {
        return operManName;
    }

    public void setOperManName(String operManName) {
        this.operManName = operManName;
    }

    public String getCorpStatus() {
        return corpStatus;
    }

    public void setCorpStatus(String corpStatus) {
        this.corpStatus = corpStatus;
    }

    public Integer getRegCapi() {
        return regCapi;
    }

    public void setRegCapi(Integer regCapi) {
        this.regCapi = regCapi;
    }

    public Integer getPaidCapi() {
        return paidCapi;
    }

    public void setPaidCapi(Integer paidCapi) {
        this.paidCapi = paidCapi;
    }

    public String getFareTermStart() {
        return fareTermStart;
    }

    public void setFareTermStart(String fareTermStart) {
        this.fareTermStart = fareTermStart;
    }

    public String getFareTermEnd() {
        return fareTermEnd;
    }

    public void setFareTermEnd(String fareTermEnd) {
        this.fareTermEnd = fareTermEnd;
    }

    public String getFareScope() {
        return fareScope;
    }

    public void setFareScope(String fareScope) {
        this.fareScope = fareScope;
    }

    public String getUniScid() {
        return uniScid;
    }

    public void setUniScid(String uniScid) {
        this.uniScid = uniScid;
    }

    public String getCorpTel() {
        return corpTel;
    }

    public void setCorpTel(String corpTel) {
        this.corpTel = corpTel;
    }

    public String getCorpWebUrl() {
        return corpWebUrl;
    }

    public void setCorpWebUrl(String corpWebUrl) {
        this.corpWebUrl = corpWebUrl;
    }

    public String getCorpEmail() {
        return corpEmail;
    }

    public String getCorpLogo() {
        return corpLogo;
    }

    public void setCorpLogo(String corpLogo) {
        this.corpLogo = corpLogo;
    }

    public void setCorpEmail(String corpEmail) {
        this.corpEmail = corpEmail;
    }

    public String getPracPersonNum() {
        return pracPersonNum;
    }

    public void setPracPersonNum(String pracPersonNum) {
        this.pracPersonNum = pracPersonNum;
    }

    public String getOrgInstCode() {
        return orgInstCode;
    }

    public void setOrgInstCode(String orgInstCode) {
        this.orgInstCode = orgInstCode;
    }

    public String getTaxpayNum() {
        return taxpayNum;
    }

    public void setTaxpayNum(String taxpayNum) {
        this.taxpayNum = taxpayNum;
    }

    public String getStaffSize() {
        return staffSize;
    }

    public void setStaffSize(String staffSize) {
        this.staffSize = staffSize;
    }

    public String getEnglishName() {
        return englishName;
    }

    public void setEnglishName(String englishName) {
        this.englishName = englishName;
    }

    public String getFormerName() {
        return formerName;
    }

    public void setFormerName(String formerName) {
        this.formerName = formerName;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public Integer getCreateOrg() {
        return createOrg;
    }

    public void setCreateOrg(Integer createOrg) {
        this.createOrg = createOrg;
    }

    public String getCorpInfo() {
        return corpInfo;
    }

    public void setCorpInfo(String corpInfo) {
        this.corpInfo = corpInfo;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public TCorpPertains getTcorppertains() {
        return tcorppertains;
    }

    public void setTcorppertains(TCorpPertains tcorppertains) {
        this.tcorppertains = tcorppertains;
    }

    public List<TCorpDist> getCorpDistList() {
        return corpDistList;
    }

    public void setCorpDistList(List<TCorpDist> corpDistList) {
        this.corpDistList = corpDistList;
    }

    public List<TCorpPertains> getCorpPertainsList() {
        return corpPertainsList;
    }

    public void setCorpPertainsList(List<TCorpPertains> corpPertainsList) {
        this.corpPertainsList = corpPertainsList;
    }

    public List<TCorpStock> getCorpStockList() {
        return corpStockList;
    }

    public void setCorpStockList(List<TCorpStock> corpStockList) {
        this.corpStockList = corpStockList;
    }



    @Override
    public String toString() {
        return "TCorp{" +
                "id=" + id +
                ", regNo='" + regNo + '\'' +
                ", corpName='" + corpName + '\'' +
                ", corpAddr='" + corpAddr + '\'' +
                ", belongOrg='" + belongOrg + '\'' +
                ", belongDistOrg='" + belongDistOrg + '\'' +
                ", belongTrade='" + belongTrade + '\'' +
                ", econKind='" + econKind + '\'' +
                ", admitMain='" + admitMain + '\'' +
                ", startDate='" + startDate + '\'' +
                ", checkDate='" + checkDate + '\'' +
                ", operManIdentNo='" + operManIdentNo + '\'' +
                ", operManName='" + operManName + '\'' +
                ", corpStatus='" + corpStatus + '\'' +
                ", regCapi=" + regCapi +
                ", paidCapi=" + paidCapi +
                ", fareTermStart='" + fareTermStart + '\'' +
                ", fareTermEnd='" + fareTermEnd + '\'' +
                ", fareScope='" + fareScope + '\'' +
                ", uniScid='" + uniScid + '\'' +
                ", corpTel='" + corpTel + '\'' +
                ", corpWebUrl='" + corpWebUrl + '\'' +
                ", corpEmail='" + corpEmail + '\'' +
                ", pracPersonNum='" + pracPersonNum + '\'' +
                ", orgInstCode='" + orgInstCode + '\'' +
                ", taxpayNum='" + taxpayNum + '\'' +
                ", staffSize='" + staffSize + '\'' +
                ", englishName='" + englishName + '\'' +
                ", formerName='" + formerName + '\'' +
                ", createDate='" + createDate + '\'' +
                ", createOrg=" + createOrg +
                ", corpInfo=" + corpInfo +
                ", value=" + value +
                ", tcorppertains=" + tcorppertains +
                ", corpDistList=" + corpDistList +
                ", corpPertainsList=" + corpPertainsList +
                ", corpStockList=" + corpStockList +
                '}';
    }

}