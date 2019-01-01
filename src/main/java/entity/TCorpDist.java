package entity;

import java.util.Date;

/**
 * 企业分支机构实体类
 * @author: yjl
 * @date: 2018/4/25
 */
public class TCorpDist{

    private Integer id;

    private String distUniScid;

    private String distName;

    private String distBelongOrg;

    private String farePlace;

    private String operManIdentNo;

    private String operManName;

    private String fareScope;

    private String startDate;

    private String checkDate;

    private String createDate;

    private TCorpCorpDist corpCorpDist;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDistUniScid() {
        return distUniScid;
    }

    public void setDistUniScid(String distUniScid) {
        this.distUniScid = distUniScid;
    }

    public String getDistName() {
        return distName;
    }

    public void setDistName(String distName) {
        this.distName = distName == null ? null : distName.trim();
    }

    public String getDistBelongOrg() {
        return distBelongOrg;
    }

    public void setDistBelongOrg(String distBelongOrg) {
        this.distBelongOrg = distBelongOrg == null ? null : distBelongOrg.trim();
    }

    public String getFarePlace() {
        return farePlace;
    }

    public void setFarePlace(String farePlace) {
        this.farePlace = farePlace == null ? null : farePlace.trim();
    }

    public String getOperManIdentNo() {
        return operManIdentNo;
    }

    public void setOperManIdentNo(String operManIdentNo) {
        this.operManIdentNo = operManIdentNo == null ? null : operManIdentNo.trim();
    }

    public String getOperManName() {
        return operManName;
    }

    public void setOperManName(String operManName) {
        this.operManName = operManName == null ? null : operManName.trim();
    }

    public String getFareScope() {
        return fareScope;
    }

    public void setFareScope(String fareScope) {
        this.fareScope = fareScope == null ? null : fareScope.trim();
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

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public TCorpCorpDist getCorpCorpDist() {
        return corpCorpDist;
    }

    public void setCorpCorpDist(TCorpCorpDist corpCorpDist) {
        this.corpCorpDist = corpCorpDist;
    }

    @Override
    public String toString() {
        return "TCorpDist{" +
                "id=" + id +
                ", distUniScid='" + distUniScid + '\'' +
                ", distName='" + distName + '\'' +
                ", distBelongOrg='" + distBelongOrg + '\'' +
                ", farePlace='" + farePlace + '\'' +
                ", operManIdentNo='" + operManIdentNo + '\'' +
                ", operManName='" + operManName + '\'' +
                ", fareScope='" + fareScope + '\'' +
                ", startDate='" + startDate + '\'' +
                ", checkDate='" + checkDate + '\'' +
                ", createDate='" + createDate + '\'' +
                ", corpCorpDist=" + corpCorpDist +
                '}';
    }
}