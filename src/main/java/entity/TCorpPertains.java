package entity;

/**
 * 企业员工实体类
 * @author: yjl
 * @date: 2018/4/25
 */
public class TCorpPertains {

    private Integer id;

    private String certificateType;

    private String personName;

    private String personType;

    private String certificateNo;

    private String selectType;

    private String holdpostStart;

    private String holdpostEdn;

    private String personSex;

    private Integer personAge;

    private String personCountry;

    private String createDate;

    private TCorpCorpPertains corpCorpPertains;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCertificateType() {
        return certificateType;
    }

    public void setCertificateType(String certificateType) {
        this.certificateType = certificateType == null ? null : certificateType.trim();
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName == null ? null : personName.trim();
    }

    public String getPersonType() {
        return personType;
    }

    public void setPersonType(String personType) {
        this.personType = personType == null ? null : personType.trim();
    }

    public String getCertificateNo() {
        return certificateNo;
    }

    public void setCertificateNo(String certificateNo) {
        this.certificateNo = certificateNo == null ? null : certificateNo.trim();
    }

    public String getSelectType() {
        return selectType;
    }

    public void setSelectType(String selectType) {
        this.selectType = selectType == null ? null : selectType.trim();
    }

    public String getHoldpostStart() {
        return holdpostStart;
    }

    public void setHoldpostStart(String holdpostStart) {
        this.holdpostStart = holdpostStart;
    }

    public String getHoldpostEdn() {
        return holdpostEdn;
    }

    public void setHoldpostEdn(String holdpostEdn) {
        this.holdpostEdn = holdpostEdn;
    }

    public String getPersonSex() {
        return personSex;
    }

    public void setPersonSex(String personSex) {
        this.personSex = personSex == null ? null : personSex.trim();
    }

    public Integer getPersonAge() {
        return personAge;
    }

    public void setPersonAge(Integer personAge) {
        this.personAge = personAge;
    }

    public String getPersonCountry() {
        return personCountry;
    }

    public void setPersonCountry(String personCountry) {
        this.personCountry = personCountry == null ? null : personCountry.trim();
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public TCorpCorpPertains getCorpCorpPertains() {
        return corpCorpPertains;
    }

    public void setCorpCorpPertains(TCorpCorpPertains corpCorpPertains) {
        this.corpCorpPertains = corpCorpPertains;
    }

    @Override
    public String toString() {
        return "TCorpPertains{" +
                "id=" + id +
                ", certificateType='" + certificateType + '\'' +
                ", personName='" + personName + '\'' +
                ", personType='" + personType + '\'' +
                ", certificateNo='" + certificateNo + '\'' +
                ", selectType='" + selectType + '\'' +
                ", holdpostStart='" + holdpostStart + '\'' +
                ", holdpostEdn='" + holdpostEdn + '\'' +
                ", personSex='" + personSex + '\'' +
                ", personAge=" + personAge +
                ", personCountry='" + personCountry + '\'' +
                ", createDate='" + createDate + '\'' +
                ", corpCorpPertains=" + corpCorpPertains +
                '}';
    }
}