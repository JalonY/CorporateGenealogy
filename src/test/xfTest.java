import org.junit.Test;
import util.XFUtil;

/**
 * @author: zsl
 * @date: 2018/07/21 14:40
 */
public class xfTest {

    @Test
    public void voiceToWord() {
        String word = XFUtil.voiceToWord();
        System.out.println(word);
    }
}