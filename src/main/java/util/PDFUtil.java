package util;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

import javax.imageio.ImageIO;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;

/**
 * @author: yjl
 * @date: 2018/5/16
 */
public class PDFUtil {
    private static Font headfont ; // 设置字体大小
    private static Font keyfont;   // 设置字体大小
    private static Font textfont;  // 设置字体大小

    static{
        BaseFont bfChinese;
        try {
            bfChinese = BaseFont.createFont("STSong-Light","UniGB-UCS2-H",BaseFont.NOT_EMBEDDED);
            headfont = new Font(bfChinese, 24, Font.BOLD,BaseColor.BLACK);// 设置字体大小
            keyfont = new Font(bfChinese, 12, Font.BOLD,BaseColor.BLACK);// 设置字体大小
            textfont = new Font(bfChinese, 10, Font.NORMAL,BaseColor.BLACK);// 设置字体大小
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //表格标题
    public static PdfPCell createHeadCell(String value){
        PdfPCell cell = new PdfPCell();
        cell.setVerticalAlignment(15);
        cell.setHorizontalAlignment(15);
        cell.setColspan(5);
        cell.setPhrase(new Phrase(value,headfont));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER); //水平居中
        cell.setPadding(10.0f);
        cell.setBorder(0);
        cell.setPaddingTop(5.0f);
        cell.setPaddingBottom(18.0f);
        return cell;
    }

    //表格表头样式1
    public static  PdfPCell createTitleCell_1(String value){
        PdfPCell cell = new PdfPCell();
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setPhrase(new Phrase(value, keyfont));
        cell.setBackgroundColor(new BaseColor(29, 181, 238));
        cell.setColspan(1);
        cell.setFixedHeight(35);
        return cell;
    }

    //表格表头样式2
    public static  PdfPCell createTitleCell_2(String value){
        PdfPCell cell = new PdfPCell();
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setPhrase(new Phrase(value, keyfont));
        cell.setBackgroundColor(new BaseColor(29, 181, 238));
        cell.setColspan(1);
        cell.setRowspan(3);
        cell.setFixedHeight(105);
        return cell;
    }

    //表格内容样式1
    public static PdfPCell createCell_1(String value){
        PdfPCell cell = new PdfPCell();
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setPhrase(new Phrase(value,textfont));
        cell.setBackgroundColor(new BaseColor(255, 255, 255));
        cell.setColspan(1);
        cell.setFixedHeight(35);
        return cell;
    }

    //表格内容样式2
    public static PdfPCell createCell_2(String value){
        PdfPCell cell = new PdfPCell();
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setPhrase(new Phrase(value,textfont));
        cell.setBackgroundColor(new BaseColor(255, 255, 255));
        cell.setColspan(1);
        cell.setRowspan(3);
        cell.setFixedHeight(105);
        return cell;
    }

    //表格内容样式3
    public static PdfPCell createCell_3(String value){
        PdfPCell cell = new PdfPCell();
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setPhrase(new Phrase(value,textfont));
        cell.setBackgroundColor(new BaseColor(255, 255, 255));
        cell.setColspan(2);
        cell.setFixedHeight(35);
        return cell;
    }

    //表格内容样式4
    public static PdfPCell createCell_4(String value){
        PdfPCell cell = new PdfPCell();
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setPhrase(new Phrase(value,textfont));
        cell.setBackgroundColor(new BaseColor(255, 255, 255));
        cell.setColspan(4);
        cell.setRowspan(3);
        cell.setFixedHeight(105);
        return cell;
    }

    //生成表格
    public static PdfPTable createTable(int colNumber){
        int widths[] = { 35,40,35,35,30 };
        PdfPTable baseTable  = new PdfPTable(colNumber);
        baseTable.setWidthPercentage(100);
        baseTable.setSpacingBefore(10);
        try {
            baseTable.setWidths(widths);
        } catch (DocumentException e) {
            e.printStackTrace();
        }
        return baseTable;
    }


    public static  void addImage(String input,String output,String realPath) throws Exception{
        BufferedOutputStream out = new BufferedOutputStream(
                new FileOutputStream(new File(output)));
        PdfReader reader = new PdfReader(input);
        PdfStamper stamper = new PdfStamper(reader, out);
        addWatermark(stamper,"测试添加水印文字");
        int total = reader.getNumberOfPages();
        try {
            Image image = Image.getInstance(realPath);
            image.setAbsolutePosition(350, 200);
            image.scaleToFit(160, 70);
            PdfContentByte content= stamper.getOverContent(total);// 在内容上方加水印
            content.addImage(image);
        }catch (Exception e){
            e.printStackTrace();
        }

        stamper.close();
        reader.close();
    }

    public static void addWatermark(PdfStamper pdfStamper, String waterMarkName) throws Exception {
        PdfContentByte content;
        BaseFont base = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H",
                BaseFont.NOT_EMBEDDED);
        Rectangle pageRect;
        PdfGState gs = new PdfGState();
        try {
            if (base == null || pdfStamper == null) {
                return;
            }
            // 设置透明度为0.4
            gs.setFillOpacity(0.3f);
            gs.setStrokeOpacity(0.3f);
            int toPage = pdfStamper.getReader().getNumberOfPages();
            for (int i = 1; i <= toPage; i++) {
                pageRect = pdfStamper.getReader().getPageSizeWithRotation(i);
                // 计算水印X,Y坐标
                float x = pageRect.getWidth() / 2;
                float y = pageRect.getHeight() / 2;
                // 获得PDF最顶层
                content = pdfStamper.getOverContent(i);
                content.saveState();
                // set Transparency
                content.setGState(gs);
                content.beginText();
                content.setColorFill(BaseColor.GRAY);
                content.setFontAndSize(base, 30);
                // 水印文字成45度角倾斜
                content.showTextAligned(Element.ALIGN_CENTER, waterMarkName, x,
                        y, 45);
                content.endText();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
