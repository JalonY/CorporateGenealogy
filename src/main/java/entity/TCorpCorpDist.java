package entity;

import java.util.List;

/**
 * 公司/企业与分公司关联实体类
 * @author: yjl
 * @date: 2018/5/8
 */
public class TCorpCorpDist {

    private Integer id;

    private Integer corpId;

    private Integer distId;

    private List<TCorpDist> distList;

    public TCorpCorpDist() {
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

    public Integer getDistId() {
        return distId;
    }

    public void setDistId(Integer distId) {
        this.distId = distId;
    }

    public List<TCorpDist> getDistList() {
        return distList;
    }

    public void setDistList(List<TCorpDist> distList) {
        this.distList = distList;
    }

    @Override
    public String toString() {
        return "TCorpCorpDist{" +
                "id=" + id +
                ", corpId=" + corpId +
                ", distId=" + distId +
                ", distList=" + distList +
                '}';
    }
}
