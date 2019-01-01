package util;

import java.util.ArrayList;
import java.util.List;

/**
 * @Description: FPTree的相关变量
 * @author: yjl
 * @date: 2018/5/24
 */
public class FPTreeNode {

    private String name;                    //节点名称
    private int count;                      //频数
    private FPTreeNode parent;              //父节点
    private List<FPTreeNode> children;      //子节点
    private FPTreeNode nextHomonym;         //下一个节点（由表头项维护的那个链表）
    private FPTreeNode tail;                //末节点（由表头项维护的那个链表）



    public FPTreeNode() {
    }

    public FPTreeNode(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCount() {
        return this.count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public FPTreeNode getParent() {
        return this.parent;
    }

    public void setParent(FPTreeNode parent) {
        this.parent = parent;
    }

    public List<FPTreeNode> getChildren() {
        return this.children;
    }

    public void setChildren(List<FPTreeNode> children) {
        this.children = children;
    }

    public FPTreeNode getNextHomonym() {
        return this.nextHomonym;
    }

    public void setNextHomonym(FPTreeNode nextHomonym) {
        this.nextHomonym = nextHomonym;
    }

    public FPTreeNode getTail() {
        return tail;
    }

    public void setTail(FPTreeNode tail) {
        this.tail = tail;
    }

    //添加子节点
    public void addChild(FPTreeNode child) {
        if (getChildren() == null) {
            List<FPTreeNode> list = new ArrayList<>();
            list.add(child);
            setChildren(list);
        } else {
            getChildren().add(child);
        }
    }

    //查询子节点
    public FPTreeNode findChild(String name) {
        List<FPTreeNode> children = getChildren();
        if (children != null) {
            for (FPTreeNode child : children) {
                if (child.getName().equals(name)) {
                    return child;
                }
            }
        }
        return null;
    }


    public void countIncrement(int n) {
        this.count += n;
    }


    @Override
    public String toString() {
        return name;
    }
}
