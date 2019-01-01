package util;

import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import entity.TCorp;

import java.io.File;
import java.io.FileOutputStream;

/**
 * @author: yjl
 * @date: 2018/5/16
 */
public class PDFReport {
    private static TCorp tCorp;

    Document document = new Document();// 建立一个Document对象

    public PDFReport(String out) {
        try {
            File file = new File(out);
            file.createNewFile();
            Rectangle pageSize = new Rectangle(PageSize.A4);
            document.setPageSize(pageSize);
            PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(file));
            PDFBuilder builder = new PDFBuilder();
            writer.setPageEvent(builder);
            document.open();
            PdfPTable table = generatePDF();
            document.add(table);
            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void settCorp(TCorp tCorp) {
        PDFReport.tCorp = tCorp;
    }


    public PdfPTable generatePDF() {
        //设置单元格为5列
        PdfPTable table = PDFUtil.createTable(5);

        table.addCell(PDFUtil.createHeadCell("企业信息列表"));
        table.addCell(PDFUtil.createTitleCell_1("企业名称"));
        table.addCell(PDFUtil.createCell_1(tCorp.getCorpName()));
        table.addCell(PDFUtil.createTitleCell_1("联系方式"));
        table.addCell(PDFUtil.createCell_1(tCorp.getCorpTel()));
        table.addCell(PDFUtil.createCell_2("Logo"));

        table.addCell(PDFUtil.createTitleCell_1("企业邮箱"));
        table.addCell(PDFUtil.createCell_1(tCorp.getCorpEmail()));
        table.addCell(PDFUtil.createTitleCell_1("网址"));
        table.addCell(PDFUtil.createCell_1(tCorp.getCorpWebUrl()));

        table.addCell(PDFUtil.createTitleCell_1("企业地址"));
        table.addCell(PDFUtil.createCell_1(tCorp.getCorpAddr()));
        table.addCell(PDFUtil.createTitleCell_1("注册/实缴"));
        table.addCell(PDFUtil.createCell_1(String.valueOf(tCorp.getRegCapi())+"万 / "+String.valueOf(tCorp.getPaidCapi())+"万"));

        table.addCell(PDFUtil.createTitleCell_1("成立日期"));
        table.addCell(PDFUtil.createCell_1(tCorp.getStartDate()));
        table.addCell(PDFUtil.createTitleCell_1("统一社会信用代码"));
        table.addCell(PDFUtil.createCell_3(tCorp.getUniScid()));

        table.addCell(PDFUtil.createTitleCell_1("法定代表人"));
        table.addCell(PDFUtil.createCell_1(tCorp.getOperManName()));
        table.addCell(PDFUtil.createTitleCell_1("纳税人识别号"));
        table.addCell(PDFUtil.createCell_3(tCorp.getTaxpayNum()));

        table.addCell(PDFUtil.createTitleCell_1("注册号"));
        table.addCell(PDFUtil.createCell_1(tCorp.getRegNo()));
        table.addCell(PDFUtil.createTitleCell_1("组织机构代码"));
        table.addCell(PDFUtil.createCell_3(tCorp.getOrgInstCode()));

        table.addCell(PDFUtil.createTitleCell_1("公司类型"));
        table.addCell(PDFUtil.createCell_1(tCorp.getEconKind()));
        table.addCell(PDFUtil.createTitleCell_1("人员规模"));
        table.addCell(PDFUtil.createCell_3(tCorp.getStaffSize()));

        table.addCell(PDFUtil.createTitleCell_1("营业期限"));
        table.addCell(PDFUtil.createCell_1(tCorp.getFareTermStart()+" 至 "+tCorp.getFareTermEnd()));
        table.addCell(PDFUtil.createTitleCell_1("登记机关"));
        table.addCell(PDFUtil.createCell_3(tCorp.getBelongOrg()));

        table.addCell(PDFUtil.createTitleCell_1("核准日期"));
        table.addCell(PDFUtil.createCell_1(tCorp.getCheckDate()));
        table.addCell(PDFUtil.createTitleCell_1("所属行业"));
        table.addCell(PDFUtil.createCell_3(tCorp.getBelongTrade()));

        table.addCell(PDFUtil.createTitleCell_1("英文名称"));
        table.addCell(PDFUtil.createCell_1(tCorp.getEnglishName()));
        table.addCell(PDFUtil.createTitleCell_1("曾用名"));
        table.addCell(PDFUtil.createCell_3(tCorp.getFormerName()));

        table.addCell(PDFUtil.createTitleCell_2("经营范围"));
        table.addCell(PDFUtil.createCell_4(tCorp.getFareScope()));

        return table;
    }
}
