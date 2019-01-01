package entity;

import java.util.List;

/**
 * 公司/企业与高管关联实体类
 * @author: yjl
 * @date: 2018/5/8
 */
public class TCorpCorpPertains {

    private Integer id;

    private Integer corpId;

    private Integer pertainsId;

    private List<TCorpPertains> pertainsList;

    public TCorpCorpPertains() {
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

    public Integer getPertainsId() {
        return pertainsId;
    }

    public void setPertainsId(Integer pertainsId) {
        this.pertainsId = pertainsId;
    }

    public void setPertainsList(List<TCorpPertains> pertainsList) {
        this.pertainsList = pertainsList;
    }

    public List<TCorpPertains> getPertainsList() {
        return pertainsList;
    }

    @Override
    public String toString() {
        return "TCorpCorpPertains{" +
                "id=" + id +
                ", corpId=" + corpId +
                ", pertainsId=" + pertainsId +
                ", pertainsList=" + pertainsList +
                '}';
    }
}
