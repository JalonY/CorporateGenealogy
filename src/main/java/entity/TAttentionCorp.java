package entity;

/**
 * 用户关注企业实体类
 * @author: yjl
 * @date: 2018/6/23
 */
public class TAttentionCorp {

    private Integer id;

    private Integer userId;

    private Integer corpId;

    public TAttentionCorp() {
    }

    public TAttentionCorp(Integer userId, Integer corpId) {
        this.userId = userId;
        this.corpId = corpId;
    }

    public Integer getId() {
        return id;
    }

    public Integer getUserId() {
        return userId;
    }

    public Integer getCorpId() {
        return corpId;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public void setCorpId(Integer corpId) {
        this.corpId = corpId;
    }

    @Override
    public String toString() {
        return "TCollectCorp{" +
                "id=" + id +
                ", userId=" + userId +
                ", corpId=" + corpId +
                '}';
    }
}
