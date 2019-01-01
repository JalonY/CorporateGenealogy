package entity;

/**
 * @author: zsl
 * @date: 2018/06/05 17:12
 */
public class ElasticSearchResult {

    private double score;

    private String name;

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
