import com.itextpdf.text.BadElementException;
import com.itextpdf.text.Image;
import org.junit.Test;

import java.io.IOException;

/**
 * @author: yjl
 * @date: 2018/5/17
 */

public class testPath {

    @Test
    public void testPath() throws IOException, BadElementException {
        String url = System.getProperty("user.dir")+"\\src\\main\\webapp\\WEB-INF\\resource\\DrillSample.txt";
        System.out.println(url);

        //Image image = Image.getInstance(url);
    }

}
