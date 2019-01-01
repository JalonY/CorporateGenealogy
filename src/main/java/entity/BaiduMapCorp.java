package entity;

/**
 * 百度地图坐标点
 *
 * @author: zsl
 * @date: 2018/08/14 08:55
 */
public class BaiduMapCorp {

    private Integer id;         //ID

    private String corpName;    //公司名称

    private double longitude;   //经度

    private double latitude;    //维度

    private String corpAddr;    //公司地址

    private Integer corpId;     //公司ID

    private String operManName; //公司法人

    private Integer regCapi;    //注册资本

    private String corpLogo;    //企业logo

    private String belongTrade; //所属行业

    private String admitMain;   //企业大类

    public BaiduMapCorp() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCorpName() {
        return corpName;
    }

    public void setCorpName(String corpName) {
        this.corpName = corpName;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public String getCorpAddr() {
        return corpAddr;
    }

    public void setCorpAddr(String corpAddr) {
        this.corpAddr = corpAddr;
    }

    public Integer getCorpId() {
        return corpId;
    }

    public void setCorpId(Integer corpId) {
        this.corpId = corpId;
    }

    public String getOperManName() {
        return operManName;
    }

    public void setOperManName(String operManName) {
        this.operManName = operManName;
    }

    public Integer getRegCapi() {
        return regCapi;
    }

    public void setRegCapi(Integer regCapi) {
        this.regCapi = regCapi;
    }

    public String getCorpLogo() {
        return corpLogo;
    }

    public void setCorpLogo(String corpLogo) {
        this.corpLogo = corpLogo;
    }

    public String getBelongTrade() {
        return belongTrade;
    }

    public void setBelongTrade(String belongTrade) {
        this.belongTrade = belongTrade;
    }

    public String getAdmitMain() {
        return admitMain;
    }

    public void setAdmitMain(String admitMain) {
        this.admitMain = admitMain;
    }

}
