import org.junit.Test;

/**
 * @author: yjl
 * @date: 2018/7/26
 */
public class textTest {

    @Test
    public void test(){
        String str = "我是测试文本苏州瑞华云财务共享科技有限公司仅仅用于测试！";
        String s = ".*苏州瑞华云财务共享科技有限公司.*";
        System.out.println(str.matches(s));
    }
}
