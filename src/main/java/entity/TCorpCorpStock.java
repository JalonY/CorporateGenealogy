package entity;

import java.util.List;

/**
 * 公司/企业与股东关联实体类
 * @author: yjl
 * @date: 2018/5/8
 */
public class TCorpCorpStock {

    private Integer id;

    private Integer corpId;

    private Integer stockId;

    private List<TCorpStock> stockList;

    public TCorpCorpStock() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCorpId() {
        return corpId;
    }

    public void setCorpId(Integer corpId) {
        this.corpId = corpId;
    }

    public Integer getStockId() {
        return stockId;
    }

    public void setStockId(Integer stockId) {
        this.stockId = stockId;
    }

    public List<TCorpStock> getStockList() {
        return stockList;
    }

    public void setStockList(List<TCorpStock> stockList) {
        this.stockList = stockList;
    }

    @Override
    public String toString() {
        return "TCorpCorpStock{" +
                "id=" + id +
                ", corpId=" + corpId +
                ", stockId=" + stockId +
                ", stockList=" + stockList +
                '}';
    }
}
