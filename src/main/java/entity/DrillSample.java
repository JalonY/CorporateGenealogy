package entity;

/**
 * 贝叶斯训练样本参数
 * @author: yjl
 * @date: 2018/7/22
 */
public class DrillSample {

    private String num;

    private String proportion;

    private String maxYN;

    private String legalYN;

    private String doubleOperYN;

    private String stockYN;

    public DrillSample() {
    }

    public DrillSample(String num, String proportion, String maxYN, String legalYN, String doubleOperYN, String stockYN) {
        this.num = num;
        this.proportion = proportion;
        this.maxYN = maxYN;
        this.legalYN = legalYN;
        this.doubleOperYN = doubleOperYN;
        this.stockYN = stockYN;
    }

    public String getNum() {
        return num;
    }

    public String getProportion() {
        return proportion;
    }

    public String getMaxYN() {
        return maxYN;
    }

    public String getLegalYN() {
        return legalYN;
    }

    public String getDoubleOperYN() {
        return doubleOperYN;
    }

    public String getStockYN() {
        return stockYN;
    }

    public void setNum(String num) {
        this.num = num;
    }

    public void setProportion(String proportion) {
        this.proportion = proportion;
    }

    public void setMaxYN(String maxYN) {
        this.maxYN = maxYN;
    }

    public void setLegalYN(String legalYN) {
        this.legalYN = legalYN;
    }

    public void setDoubleOperYN(String doubleOperYN) {
        this.doubleOperYN = doubleOperYN;
    }

    public void setStockYN(String stockYN) {
        this.stockYN = stockYN;
    }

    @Override
    public String toString() {
        return "DrillSample{" +
                "num='" + num + '\'' +
                ", proportion='" + proportion + '\'' +
                ", maxYN='" + maxYN + '\'' +
                ", legalYN='" + legalYN + '\'' +
                ", doubleOperYN='" + doubleOperYN + '\'' +
                ", stockYN='" + stockYN + '\'' +
                '}';
    }
}
