package entity;

/**
 * 企业股东实体类
 * @author: yjl
 * @date: 2018/4/25
 */
public class TCorpStock {

    private Integer id;

    private String stockType;

    private String stockCountry;

    private String certificateType;

    private String certificateNo;

    private String stockName;

    private String stockCapiType;

    private Double stockCapi;

    private Double stockCapiDollar;

    private Double stockCapiRmb;

    private String stockPercent;

    private Double stockRateRmb;

    private Double stockRateDollar;

    private String createDate;

    private TCorpCorpStock corpCorpStock;

    public TCorpStock() {
    }

    public TCorpStock(String stockName, String stockPercent) {
        this.stockName = stockName;
        this.stockPercent = stockPercent;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getStockType() {
        return stockType;
    }

    public void setStockType(String stockType) {
        this.stockType = stockType == null ? null : stockType.trim();
    }

    public String getStockCountry() {
        return stockCountry;
    }

    public void setStockCountry(String stockCountry) {
        this.stockCountry = stockCountry == null ? null : stockCountry.trim();
    }

    public String getCertificateType() {
        return certificateType;
    }

    public void setCertificateType(String certificateType) {
        this.certificateType = certificateType == null ? null : certificateType.trim();
    }

    public String getCertificateNo() {
        return certificateNo;
    }

    public void setCertificateNo(String certificateNo) {
        this.certificateNo = certificateNo == null ? null : certificateNo.trim();
    }

    public String getStockName() {
        return stockName;
    }

    public void setStockName(String stockName) {
        this.stockName = stockName == null ? null : stockName.trim();
    }

    public String getStockCapiType() {
        return stockCapiType;
    }

    public void setStockCapiType(String stockCapiType) {
        this.stockCapiType = stockCapiType == null ? null : stockCapiType.trim();
    }

    public Double getStockCapi() {
        return stockCapi;
    }

    public void setStockCapi(Double stockCapi) {
        this.stockCapi = stockCapi;
    }

    public Double getStockCapiDollar() {
        return stockCapiDollar;
    }

    public void setStockCapiDollar(Double stockCapiDollar) {
        this.stockCapiDollar = stockCapiDollar;
    }

    public Double getStockCapiRmb() {
        return stockCapiRmb;
    }

    public void setStockCapiRmb(Double stockCapiRmb) {
        this.stockCapiRmb = stockCapiRmb;
    }

    public String getStockPercent() {
        return stockPercent;
    }

    public void setStockPercent(String stockPercent) {
        this.stockPercent = stockPercent == null ? null : stockPercent.trim();
    }

    public Double getStockRateRmb() {
        return stockRateRmb;
    }

    public void setStockRateRmb(Double stockRateRmb) {
        this.stockRateRmb = stockRateRmb;
    }

    public Double getStockRateDollar() {
        return stockRateDollar;
    }

    public void setStockRateDollar(Double stockRateDollar) {
        this.stockRateDollar = stockRateDollar;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public TCorpCorpStock getCorpCorpStock() {
        return corpCorpStock;
    }

    public void setCorpCorpStock(TCorpCorpStock corpCorpStock) {
        this.corpCorpStock = corpCorpStock;
    }

    @Override
    public String toString() {
        return "TCorpStock{" +
                "id=" + id +
                ", stockType='" + stockType + '\'' +
                ", stockCountry='" + stockCountry + '\'' +
                ", certificateType='" + certificateType + '\'' +
                ", certificateNo='" + certificateNo + '\'' +
                ", stockName='" + stockName + '\'' +
                ", stockCapiType='" + stockCapiType + '\'' +
                ", stockCapi=" + stockCapi +
                ", stockCapiDollar=" + stockCapiDollar +
                ", stockCapiRmb=" + stockCapiRmb +
                ", stockPercent='" + stockPercent + '\'' +
                ", stockRateRmb=" + stockRateRmb +
                ", stockRateDollar=" + stockRateDollar +
                ", createDate='" + createDate + '\'' +
                ", corpCorpStock=" + corpCorpStock +
                '}';
    }
}