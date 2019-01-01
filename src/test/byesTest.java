import entity.DrillSample;
import org.junit.Test;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;

/**
 * @author: yjl
 * @date: 2018/7/22
 */
public class byesTest {

    public static ArrayList<DrillSample> list = new ArrayList<>();
    static int data_length=0;

    @Test
    public void test(){
        String url = System.getProperty("user.dir")+"\\src\\main\\webapp\\WEB-INF\\resource\\DrillSample.txt";
        System.out.println(url);
        //读取数据，放入list容器中
        File file = new File(url);
        txt2String(file);
        //数据测试样本
        testData("High","Medium","Yes","No","No");
    }

    // 读取样本数据
    public static void txt2String(File file) {
        try {
            BufferedReader br = new BufferedReader(new FileReader(file));
            String s;
            while ((s = br.readLine()) != null) {
                data_length++;
                splitt(s);
            }
            br.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 存入ArrayList中
    public static void splitt(String str){
        String strr = str.trim();
        String[] abc = strr.split("[\\p{Space}]+");
        String num = abc[0];
        DrillSample sample = new DrillSample(num, abc[1], abc[2], abc[3], abc[4], abc[5]);
        list.add(sample);
    }

    // 训练样本，测试
    public static void testData(String num,String a,String b,String c,String d){
        //实际控股人是否个数
        int stock_yes=0;
        int stock_no=0;

        //股东人数
        int num_yes=0;
        int num_no=0;
        //投资比例
        int proportion_yes=0;
        int proportion_no=0;
        //投资比例是否最大
        int maxYN_yes=0;
        int maxYN_no=0;
        //是否法人
        int legalYN_yes=0;
        int legalYN_no=0;
        //比例是否大于法人两倍
        int doubleOperYN_yes=0;
        int doubleOperYN_no=0;

        //遍历List 获得数据
        for(int i = 0;i < list.size();i++){
            DrillSample sample = list.get(i);
            if(sample.getStockYN().equals("Yes")){
                stock_yes++;
                if(sample.getProportion().equals(a)){
                    proportion_yes++;
                }
                if(sample.getMaxYN().equals(b)){
                    maxYN_yes++;
                }
                if(sample.getLegalYN().equals(c)){
                    legalYN_yes++;
                }
                if(sample.getDoubleOperYN().equals(d)){
                    doubleOperYN_yes++;
                }
                if(sample.getNum().equals(num)){
                    num_yes++;
                }
            }else {
                stock_no++;
                if(sample.getProportion().equals(a)){
                    proportion_no++;
                }
                if(sample.getMaxYN().equals(b)){
                    maxYN_no++;
                }
                if(sample.getLegalYN().equals(c)){
                    legalYN_no++;
                }
                if(sample.getDoubleOperYN().equals(d)){
                    doubleOperYN_no++;
                }
                if(sample.getNum().equals(num)){
                    num_no++;
                }
            }
        }

        System.out.println("是实际控股人个数:"+ stock_yes);
        System.out.println("不是实际控股人个数:"+ stock_no);

        System.out.println("是的+num:"+num_yes);
        System.out.println("不是+num:"+num_no);

        System.out.println("是的+proportion:"+proportion_yes);
        System.out.println("不是+proportion:"+proportion_no);

        System.out.println("是的+maxYN:"+maxYN_yes);
        System.out.println("不是+maxYN:"+maxYN_no);

        System.out.println("是的+legalYN:"+legalYN_yes);
        System.out.println("不是+legalYN:"+legalYN_no);

        System.out.println("是的+doubleOperYN:"+doubleOperYN_yes);
        System.out.println("不是+doubleOperYN:"+doubleOperYN_no);

        //概率判断
        double judge_yes = stock_yes * 1.0 / data_length; // 是的概率
        double judge_no = stock_no * 1.0 / data_length; //  不是的概率
        System.out.println("训练数据中是的概率:"+ judge_yes);
        System.out.println("训练数据中不是的概率:"+ judge_no);
        //未知数据的判断
        double nb_judge_yes = (1.0*num_yes/stock_yes)*(1.0*proportion_yes/stock_yes)*(1.0*maxYN_yes/stock_yes)*(1.0*legalYN_yes/stock_yes)*(1.0*doubleOperYN_yes/stock_yes)*judge_yes;
        double nb_judge_no = (1.0*num_no/stock_no)*(1.0*proportion_no/stock_no)*(1.0*maxYN_no/stock_no)*(1.0*legalYN_no/stock_no)*(1.0*doubleOperYN_no/stock_no)*judge_no;
        System.out.println("新数据是的概率:"+ nb_judge_yes);
        System.out.println("新数据不是的概率:"+ nb_judge_no);
        if(nb_judge_yes > nb_judge_no){
            System.out.println("新数据是实际控股人");
        }else {
            System.out.println("新数据不是实际控股人");
        }
    }
}
