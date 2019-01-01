package util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.*;
import java.util.Map.Entry;

/**
 * @Description: FPTree强关联规则挖掘算法
 * @author: yjl
 * @date: 2018/5/24
 */
public class FPTree {

    private int minSuport;      //频繁模式的最小支持数
    private double confident;   //关联规则的最小置信度
    private int totalSize;      //事务项的总数
    private Map<List<String>, Integer> frequentMap = new HashMap<>();  //存储每个频繁项及其对应的计数
    private Set<String> decideAttr = null; //关联规则中，哪些项可作为被推导的结果，默认情况下所有项都可以作为被推导的结果



    public void setMinSuport(int minSuport) {
        this.minSuport = minSuport;
    }

    public void setConfident(double confident) {
        this.confident = confident;
    }

    public void setDecideAttr(Set<String> decideAttr) { this.decideAttr = decideAttr;}



    /**
     * 获取强关联规则
     * @return
     * @Description:
     */
    private List<FPStrongAssociationRule> getRules(List<String> list) {
        List<FPStrongAssociationRule> rect = new LinkedList<>();
        if (list.size() > 1) {
            for (int i = 0; i < list.size(); i++) {
                String result = list.get(i);
                if (decideAttr.contains(result)) {
                    List<String> condition = new ArrayList<>();
                    condition.addAll(list.subList(0, i));
                    condition.addAll(list.subList(i + 1, list.size()));
                    FPStrongAssociationRule rule = new FPStrongAssociationRule();
                    rule.condition = condition;
                    rule.result = result;
                    rect.add(rule);
                }
            }
        }
        return rect;
    }


    /**
     * 从若干个文件中读入Transaction Record，同时把所有项设置为decideAttr
     * @return
     * @Description:
     */
    public List<List<String>> readTransRocords(String[] filenames) {
        Set<String> set = new HashSet<>();
        List<List<String>> transaction = null;
        if (filenames.length > 0) {
            transaction = new LinkedList<>();
            for (String filename : filenames) {
                try {
                    FileReader fr = new FileReader(filename);
                    BufferedReader br = new BufferedReader(fr);
                    try {
                        String line;
                        // 一项事务占一行
                        while ((line = br.readLine()) != null) {
                            if (line.trim().length() > 0) {
                                // 每个item之间用","分隔
                                String[] str = line.split(",");
                                //每一项事务中的重复项需要排重
                                Set<String> record = new HashSet<>();
                                for (String w : str) {
                                    record.add(w);
                                    set.add(w);
                                }
                                List<String> rl = new ArrayList<>();
                                rl.addAll(record);
                                transaction.add(rl);
                            }
                        }
                    } finally {
                        br.close();
                    }
                } catch (IOException ex) {
                    System.out.println("Read transaction records failed." + ex.getMessage());
                    System.exit(1);
                }
            }
        }

        this.setDecideAttr(set);
        return transaction;
    }


    /**
     * 生成一个序列的各种子序列（序列是有顺序的）
     * @param residualPath
     * @param results
     */
    private void combine(LinkedList<FPTreeNode> residualPath, List<List<FPTreeNode>> results) {
        if (residualPath.size() > 0) {
            //如果residualPath太长，则会有太多的组合，内存会被耗尽的
            FPTreeNode head = residualPath.poll();
            List<List<FPTreeNode>> newResults = new ArrayList<>();
            for (List<FPTreeNode> list : results) {
                List<FPTreeNode> listCopy = new ArrayList<>(list);
                newResults.add(listCopy);
            }

            for (List<FPTreeNode> newPath : newResults) {
                newPath.add(head);
            }
            results.addAll(newResults);
            List<FPTreeNode> list = new ArrayList<>();
            list.add(head);
            results.add(list);
            combine(residualPath, results);
        }
    }

    /**
     * 判断是否为单节点
     * @param root
     */
    private boolean isSingleBranch(FPTreeNode root) {
        boolean rect = true;
        while (root.getChildren() != null) {
            if (root.getChildren().size() > 1) {
                rect = false;
                break;
            }
            root = root.getChildren().get(0);
        }
        return rect;
    }

    /**
     * 计算事务集中每一项的频数
     * @param transRecords
     * @return
     */
    private Map<String, Integer> getFrequency(List<List<String>> transRecords) {
        Map<String, Integer> rect = new HashMap<>();
        for (List<String> record : transRecords) {
            for (String item : record) {
                Integer cnt = rect.get(item);
                if (cnt == null) {
                    cnt = new Integer(0);
                }
                rect.put(item, ++cnt);
            }
        }
        return rect;
    }

    /**
     * 根据事务集合构建FPTree
     * @param transRecords
     * @Description:
     */
    public void buildFPTree(List<List<String>> transRecords) {
        totalSize = transRecords.size();
        //计算每项的频数
        final Map<String, Integer> freqMap = getFrequency(transRecords);
        //每条事务中的项按F1排序
        for (List<String> transRecord : transRecords) {
            Collections.sort(transRecord, (o1, o2) -> freqMap.get(o2) - freqMap.get(o1));
        }
        FPGrowth(transRecords, null);
    }


    /**
     * FP树递归生长，从而得到所有的频繁模式
     * @param cpb  条件模式基
     * @param postModel   后缀模式
     */
    private void FPGrowth(List<List<String>> cpb, LinkedList<String> postModel) {
        Map<String, Integer> freqMap = getFrequency(cpb);
        Map<String, FPTreeNode> headers = new HashMap<>();
        for (Entry<String, Integer> entry : freqMap.entrySet()) {
            String name = entry.getKey();
            int cnt = entry.getValue();
            //每一次递归时都有可能出现一部分模式的频数低于阈值
            if (cnt >= minSuport) {
                FPTreeNode node = new FPTreeNode(name);
                node.setCount(cnt);
                headers.put(name, node);
            }
        }

        FPTreeNode treeRoot = buildSubTree(cpb,headers);
        //如果只剩下虚根节点，则递归结束
        if ((treeRoot.getChildren() == null) || (treeRoot.getChildren().size() == 0)) {
            return;
        }

        //如果树是单枝的，则直接把“路径的各种组合+后缀模式”添加到频繁模式集中。这个技巧是可选的，即跳过此步进入下一轮递归也可以得到正确的结果
        if (isSingleBranch(treeRoot)) {
            LinkedList<FPTreeNode> path = new LinkedList<>();
            FPTreeNode currNode = treeRoot;
            while (currNode.getChildren() != null) {
                currNode = currNode.getChildren().get(0);
                path.add(currNode);
            }
            //调用combine时path不宜过长，否则会OutOfMemory
            if (path.size() <= 20) {
                List<List<FPTreeNode>> results = new ArrayList<>();
                combine(path, results);
                for (List<FPTreeNode> list : results) {
                    int cnt = 0;
                    List<String> rule = new ArrayList<>();
                    for (FPTreeNode node : list) {
                        rule.add(node.getName());
                        cnt = node.getCount();  //cnt最FPTree叶节点的计数
                    }
                    if (postModel != null) {
                        rule.addAll(postModel);
                    }
                    frequentMap.put(rule, cnt);
                }
                return;
            } else {
                System.err.println("length of path is too long: " + path.size());
            }
        }

        for (FPTreeNode header : headers.values()) {
            List<String> rule = new ArrayList<>();
            rule.add(header.getName());
            if (postModel != null) {
                rule.addAll(postModel);
            }
            //表头项+后缀模式  构成一条频繁模式（频繁模式内部也是按照F1排序的），频繁度为表头项的计数
            frequentMap.put(rule, header.getCount());
            //新的后缀模式：表头项+上一次的后缀模式（注意保持顺序，始终按F1的顺序排列）
            LinkedList<String> newPostPattern = new LinkedList<>();
            newPostPattern.add(header.getName());
            if (postModel != null) {
                newPostPattern.addAll(postModel);
            }
            //新的条件模式基
            List<List<String>> newCPB;
            newCPB = new LinkedList<>();
            FPTreeNode nextNode = header;
            while ((nextNode = nextNode.getNextHomonym()) != null) {
                int counter = nextNode.getCount();
                //获得从虚根节点（不包括虚根节点）到当前节点（不包括当前节点）的路径，即一条条件模式基。注意保持顺序：你节点在前，子节点在后，即始终保持频率高的在前
                LinkedList<String> path = new LinkedList<>();
                FPTreeNode parent = nextNode;
                while ((parent = parent.getParent()).getName() != null) {//虚根节点的name为null
                    path.push(parent.getName());//往表头插入
                }
                //事务要重复添加counter次
                while (counter-- > 0) {
                    newCPB.add(path);
                }
            }
            FPGrowth(newCPB, newPostPattern);
        }
    }

    /**
     * 把所有事务插入到一个FP树当中
     * @param transRecords
     * @param headers
     * @return
     */
    private FPTreeNode buildSubTree(List<List<String>> transRecords,final Map<String, FPTreeNode> headers) {
        FPTreeNode root = new FPTreeNode();//虚根节点
        for (List<String> transRecord : transRecords) {
            LinkedList<String> record = new LinkedList<>(transRecord);
            FPTreeNode subTreeRoot = root;
            FPTreeNode tmpRoot;
            if (root.getChildren() != null) {
                //延已有的分支，令各节点计数加1
                while (!record.isEmpty()
                        && (tmpRoot = subTreeRoot.findChild(record.peek())) != null) {
                    tmpRoot.countIncrement(1);
                    subTreeRoot = tmpRoot;
                    record.poll();
                }
            }
            //长出新的节点
            addNodes(subTreeRoot, record, headers);
        }
        return root;
    }

    /**
     * 往特定的节点下插入一串后代节点，同时维护表头项到同名节点的链表指针
     * @param ancestor
     * @param record
     * @param headers
     */
    private void addNodes(FPTreeNode ancestor, LinkedList<String> record,
                          final Map<String, FPTreeNode> headers) {
        while (!record.isEmpty()) {
            String item = record.poll();
            //单个项的出现频数必须大于最小支持数，否则不允许插入FP树。达到最小支持度的项都在headers中。每一次递归根据条件模式基本建立新的FPTree时，把要把频数低于minSuport的排除在外，这也正是FPTree比穷举法快的真正原因
            if (headers.containsKey(item)) {
                FPTreeNode leafnode = new FPTreeNode(item);
                leafnode.setCount(1);
                leafnode.setParent(ancestor);
                ancestor.addChild(leafnode);

                FPTreeNode header = headers.get(item);
                FPTreeNode tail=header.getTail();
                if(tail!=null){
                    tail.setNextHomonym(leafnode);
                }else{
                    header.setNextHomonym(leafnode);
                }
                header.setTail(leafnode);
                addNodes(leafnode, record, headers);
            }

        }
    }

    /**
     * 获取所有的强规则
     * @return
     */
    public List<FPStrongAssociationRule> getAssociateRule() {
        assert totalSize > 0;
        List<FPStrongAssociationRule> rect = new ArrayList<>();
        //遍历所有频繁模式
        for (Entry<List<String>, Integer> entry : frequentMap.entrySet()) {
            List<String> items = entry.getKey();
            int count1 = entry.getValue();
            //一条频繁模式可以生成很多关联规则
            List<FPStrongAssociationRule> rules = getRules(items);
            //计算每一条关联规则的支持度和置信度
            for (FPStrongAssociationRule rule : rules) {
                if (frequentMap.containsKey(rule.condition)) {
                    int count2 = frequentMap.get(rule.condition);
                    double confidence = 1.0 * count1 / count2;
                    if (confidence >= this.confident) {
                        rule.support = count1;
                        rule.confidence = confidence;
                        rect.add(rule);
                    }
                } else {
                    System.err.println(rule.condition + " is not a frequent pattern, however "
                            + items + " is a frequent pattern");
                }
            }
        }
        return rect;
    }

    /**
     * 限制List集合中企业数目为5条
     */
    private static void limitFiveCorp(List<String> corpList) {
        if(corpList.size() > 5){
            Random randomId = new Random();
            //对随机的5个企业名称排成原来的默认顺序
            List<Integer> indexes = new ArrayList<>();
            while(indexes.size() < 5) {
                int index = randomId.nextInt(corpList.size());
                if(!indexes.contains(index)) {
                    indexes.add(index);
                }
            }
            Collections.sort(indexes);
            //取出indexes对应的list放到newList
            List<String> tempRelationsCorpList = new ArrayList<>();
            for(int index : indexes) {
                tempRelationsCorpList.add(corpList.get(index));
            }
            corpList.clear();
            corpList.addAll(tempRelationsCorpList);
        }
    }


    public static Map<String, List<String>> introQueryHistory(String outfile,String corpName) {
        FPTree fpTree = new FPTree();

        //设置置信度与支持数
        fpTree.setConfident(0.3);
        fpTree.setMinSuport(3);

        List<List<String>> trans = fpTree.readTransRocords(new String[] { outfile });
        for(int i = 1;i < trans.size() - 1;i++){
            System.out.println("第"+i+"行数据："+ trans.get(i));
        }

        fpTree.buildFPTree(trans);

        List<FPStrongAssociationRule> rules = fpTree.getAssociateRule();
        DecimalFormat dfm = new DecimalFormat("#.##");

        Map<String, String> interestedCorpMap = new HashMap<>();  //需要返回的关联企业(您可能感兴趣的公司)
        Map<String, String> otherSearchCorpMap = new HashMap<>(); //需要返回的关联企业(其他人还搜过的公司)
        //根据置信度查询关联企业用于返回感兴趣的公司
        for (FPStrongAssociationRule rule : rules) {
            System.out.println(rule.condition + "->" + rule.result + "\t" + dfm.format(rule.support) + "\t" + dfm.format(rule.confidence));
            List<String> corpCondition = rule.condition;
            for(int i = 0;i < corpCondition.size();i++){
                if(corpName.equals(corpCondition.get(i))){
                    interestedCorpMap.put(rule.result,dfm.format(rule.confidence));
                }
            }
            if(corpName.equals(rule.result)){
                for(int i = 0;i < corpCondition.size();i++){
                    if(!corpName.equals(corpCondition.get(i))){
                        interestedCorpMap.put(corpCondition.get(i),dfm.format(rule.confidence));
                    }
                }
            }
        }

        //根据多项集查询关联企业用于返回其它搜过的公司
        for (FPStrongAssociationRule rule : rules) {
            List<String> corpCondition = rule.condition;
            for (int i = 0; i < corpCondition.size(); i++) {
                if (corpName.equals(corpCondition.get(i)) && corpCondition.size() > 1) {
                    for (int j = 0; j < corpCondition.size(); j++) {
                        if (!corpName.equals(corpCondition.get(j))) {
                            otherSearchCorpMap.put(corpCondition.get(j), "0.00");
                        }
                    }
                }
            }
        }


        List<String> interestedCorpList = new ArrayList<>();
        List<String> otherSearchCorpList = new ArrayList<>();
        for(Map.Entry<String,String> entry: interestedCorpMap.entrySet()){
            interestedCorpList.add(entry.getKey());
        }
        for(Map.Entry<String,String> entry: otherSearchCorpMap.entrySet()){
            otherSearchCorpList.add(entry.getKey());
        }

        limitFiveCorp(interestedCorpList);
        limitFiveCorp(otherSearchCorpList);

        Map<String, List<String>> corpMap = new HashMap<>();
        corpMap.put("interestedCorpList",interestedCorpList);
        corpMap.put("otherSearchCorpList",otherSearchCorpList);

        return corpMap;
    }


}
