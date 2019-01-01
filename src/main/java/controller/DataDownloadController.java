package controller;

import entity.TCorp;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.SearchCorpService;
import util.PDFReport;
import util.PDFUtil;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author: yjl
 * @date: 2018/5/15
 */
@Controller
public class DataDownloadController {
    @Autowired
    SearchCorpService searchCorpService;

    //点击下载获取企业信息并存至Excel
    @RequestMapping(value="/downloadExcel.do")
    @ResponseBody
    public String downloadExcel(@RequestParam(value = "download_corp_id") String download_corp_id) throws Exception {

        List<TCorp> corpIfs = searchCorpService.getCorpInfo(Integer.parseInt(download_corp_id));
        TCorp tCorp = new TCorp();
        dealCorpInfo(corpIfs, tCorp);

        // 第一步，创建一个webbook，对应一个Excel文件
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet("企业信息表");
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow(0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();
        style.setFillForegroundColor(HSSFColor.SKY_BLUE.index); //设置背景颜色
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
        HSSFFont font = wb.createFont();   // 生成一个字体
        font.setColor(HSSFColor.BLACK.index);
        font.setFontHeightInPoints((short) 12);
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        style.setFont(font);   // 把字体应用到当前的样式

        HSSFCell cell = row.createCell((short) 0);
        cell.setCellValue("企业名称");
        cell.setCellStyle(style);
        cell = row.createCell((short) 1);
        cell.setCellValue("联系方式");
        cell.setCellStyle(style);
        cell = row.createCell((short) 2);
        cell.setCellValue("企业邮箱");
        cell.setCellStyle(style);
        cell = row.createCell((short) 3);
        cell.setCellValue("企业网址");
        cell.setCellStyle(style);
        cell = row.createCell((short) 4);
        cell.setCellValue("企业地址");
        cell.setCellStyle(style);
        cell = row.createCell((short) 5);
        cell.setCellValue("注册资本");
        cell.setCellStyle(style);
        cell = row.createCell((short) 6);
        cell.setCellValue("成立日期");
        cell.setCellStyle(style);
        cell = row.createCell((short) 7);
        cell.setCellValue("经营状态");
        cell.setCellStyle(style);
        cell = row.createCell((short) 8);
        cell.setCellValue("统一社会信用代码");
        cell.setCellStyle(style);
        cell = row.createCell((short) 9);
        cell.setCellValue("法定代表人");
        cell.setCellStyle(style);
        cell = row.createCell((short) 10);
        cell.setCellValue("纳税人识别号");
        cell.setCellStyle(style);
        cell = row.createCell((short) 11);
        cell.setCellValue("注册号");
        cell.setCellStyle(style);
        cell = row.createCell((short) 12);
        cell.setCellValue("组织机构代码");
        cell.setCellStyle(style);
        cell = row.createCell((short) 13);
        cell.setCellValue("公司类型");
        cell.setCellStyle(style);
        cell = row.createCell((short) 14);
        cell.setCellValue("人员规模");
        cell.setCellStyle(style);
        cell = row.createCell((short) 15);
        cell.setCellValue("营业期限");
        cell.setCellStyle(style);
        cell = row.createCell((short) 16);
        cell.setCellValue("登记机关");
        cell.setCellStyle(style);
        cell = row.createCell((short) 17);
        cell.setCellValue("核准日期");
        cell.setCellStyle(style);
        cell = row.createCell((short) 18);
        cell.setCellValue("英文名称");
        cell.setCellStyle(style);
        cell = row.createCell((short) 19);
        cell.setCellValue("曾用名称");
        cell.setCellStyle(style);
        cell = row.createCell((short) 20);
        cell.setCellValue("所属行业");
        cell.setCellStyle(style);
        cell = row.createCell((short) 21);
        cell.setCellValue("经营范围");
        cell.setCellStyle(style);

        // 第五步，写入实体数据
        List<TCorp> newCorpIfs = new ArrayList<>();
        newCorpIfs.add(tCorp);
        String fileName = "企业信息-千企查.xls";
        for (int i = 0; i < newCorpIfs.size(); i++)
        {
            row = sheet.createRow(i + 1);
            TCorp newtCorp = newCorpIfs.get(i);
            fileName = newtCorp.getCorpName() + "-千企查.xls";
            row.createCell((short) 0).setCellValue(newtCorp.getCorpName());
            row.createCell((short) 1).setCellValue(newtCorp.getCorpTel());
            row.createCell((short) 2).setCellValue(newtCorp.getCorpEmail());
            row.createCell((short) 3).setCellValue(newtCorp.getCorpWebUrl());
            row.createCell((short) 4).setCellValue(newtCorp.getCorpAddr());
            row.createCell((short) 5).setCellValue(newtCorp.getRegCapi());
            row.createCell((short) 6).setCellValue(newtCorp.getStartDate());
            row.createCell((short) 7).setCellValue(newtCorp.getCorpStatus());
            row.createCell((short) 8).setCellValue(newtCorp.getUniScid());
            row.createCell((short) 9).setCellValue(newtCorp.getOperManName());
            row.createCell((short) 10).setCellValue(newtCorp.getTaxpayNum());
            row.createCell((short) 11).setCellValue(newtCorp.getRegNo());
            row.createCell((short) 12).setCellValue(newtCorp.getOrgInstCode());
            row.createCell((short) 13).setCellValue(newtCorp.getEconKind());
            row.createCell((short) 14).setCellValue(newtCorp.getStaffSize());
            row.createCell((short) 15).setCellValue(newtCorp.getFareTermStart()+"至"+newtCorp.getFareTermEnd());
            row.createCell((short) 16).setCellValue(newtCorp.getBelongOrg());
            row.createCell((short) 17).setCellValue(newtCorp.getCheckDate());
            row.createCell((short) 18).setCellValue(newtCorp.getEnglishName());
            row.createCell((short) 19).setCellValue(newtCorp.getFormerName());
            row.createCell((short) 20).setCellValue(newtCorp.getBelongTrade());
            row.createCell((short) 21).setCellValue(newtCorp.getFareScope());
        }

        // 第六步，导出excel
        FileOutputStream fout = new FileOutputStream("C:\\Users\\Administrator\\Desktop\\"+fileName);
        wb.write(fout);
        fout.close();

        return "提示：数据导出成功!";

//        String path = "C:\\Users\\Administrator\\Desktop\\"+fileName;
//
//        try {
//            File file = new File(path);
//            String filename = file.getName();
//            InputStream fis = new BufferedInputStream(new FileInputStream(path));  // 以流的形式下载文件
//            byte[] buffer = new byte[fis.available()];
//            fis.read(buffer);
//            fis.close();
//            response.reset();  // 清空response
//            response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes()));  // 设置response的Header
//            response.addHeader("Content-Length", "" + file.length());
//            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
//            response.setContentType("application/vnd.ms-excel;charset=gb2312");
//            toClient.write(buffer);
//            toClient.flush();
//            toClient.close();
//        } catch (IOException ex) {
//            ex.printStackTrace();
//        }

    }

    //点击下载获取企业信息并存至Pdf
    @RequestMapping(value="/downloadPdf.do")
    @ResponseBody
    public String downloadPdf(@RequestParam(value = "download_corp_id") String download_corp_id, HttpServletRequest request) throws Exception {
        List<TCorp> corpIfs = searchCorpService.getCorpInfo(Integer.parseInt(download_corp_id));
        TCorp tCorp = new TCorp();
        for (TCorp corpInfo: corpIfs){
            tCorp.setId(corpInfo.getId());
            tCorp.setRegNo(corpInfo.getRegNo());
            tCorp.setCorpName(corpInfo.getCorpName());
            tCorp.setCorpAddr(corpInfo.getCorpAddr());
            tCorp.setBelongOrg(corpInfo.getBelongOrg());
            tCorp.setBelongDistOrg(corpInfo.getBelongDistOrg());
            tCorp.setBelongTrade(corpInfo.getBelongTrade());
            tCorp.setEconKind(corpInfo.getEconKind());
            tCorp.setAdmitMain(corpInfo.getAdmitMain());
            tCorp.setStartDate(corpInfo.getStartDate());
            tCorp.setCheckDate(corpInfo.getCheckDate());
            tCorp.setOperManIdentNo(corpInfo.getOperManIdentNo());
            tCorp.setOperManName(corpInfo.getOperManName());
            tCorp.setCorpStatus(corpInfo.getCorpStatus());
            tCorp.setRegCapi(corpInfo.getRegCapi());
            tCorp.setPaidCapi(corpInfo.getPaidCapi());
            tCorp.setFareTermStart(corpInfo.getFareTermStart());
            tCorp.setFareTermEnd(corpInfo.getFareTermEnd());
            tCorp.setFareScope(corpInfo.getFareScope());
            tCorp.setUniScid(corpInfo.getUniScid());
            tCorp.setCorpTel(corpInfo.getCorpTel());
            tCorp.setCorpWebUrl(corpInfo.getCorpWebUrl());
            tCorp.setCorpLogo(corpInfo.getCorpLogo());
            tCorp.setCorpEmail(corpInfo.getCorpEmail());
            tCorp.setPracPersonNum(corpInfo.getPracPersonNum());
            tCorp.setOrgInstCode(corpInfo.getOrgInstCode());
            tCorp.setTaxpayNum(corpInfo.getTaxpayNum());
            tCorp.setStaffSize(corpInfo.getStaffSize());
            tCorp.setEnglishName(corpInfo.getEnglishName());
            tCorp.setFormerName(corpInfo.getFormerName());
            tCorp.setCorpInfo(corpInfo.getCorpInfo());
            tCorp.setCreateDate(corpInfo.getCreateDate());
            tCorp.setCreateOrg(corpInfo.getCreateOrg());
        }

        String realPath = request.getSession().getServletContext().getRealPath("/") + "\\icon\\logo_64.png";
        PDFReport.settCorp(tCorp);
        new PDFReport("test.pdf").generatePDF();
        PDFUtil.addImage("test.pdf", "C:\\Users\\Administrator\\Desktop\\"+tCorp.getCorpName()+".pdf",realPath);

        return "提示：数据导出成功!";
    }

    //处理数据库查询到的企业数据
    static String dealCorpInfo(List<TCorp> corpIfs, TCorp tCorp) {
        String corpName = "";
        for (TCorp corpInfo: corpIfs){
            tCorp.setId(corpInfo.getId());
            tCorp.setRegNo(corpInfo.getRegNo());
            tCorp.setCorpName(corpInfo.getCorpName());
            corpName = corpInfo.getCorpName();
            tCorp.setCorpAddr(corpInfo.getCorpAddr());
            tCorp.setBelongOrg(corpInfo.getBelongOrg());
            tCorp.setBelongDistOrg(corpInfo.getBelongDistOrg());
            tCorp.setBelongTrade(corpInfo.getBelongTrade());
            tCorp.setEconKind(corpInfo.getEconKind());
            tCorp.setAdmitMain(corpInfo.getAdmitMain());
            tCorp.setStartDate(corpInfo.getStartDate());
            tCorp.setCheckDate(corpInfo.getCheckDate());
            tCorp.setOperManIdentNo(corpInfo.getOperManIdentNo());
            tCorp.setOperManName(corpInfo.getOperManName());
            tCorp.setCorpStatus(corpInfo.getCorpStatus());
            tCorp.setRegCapi(corpInfo.getRegCapi());
            tCorp.setPaidCapi(corpInfo.getPaidCapi());
            tCorp.setFareTermStart(corpInfo.getFareTermStart());
            tCorp.setFareTermEnd(corpInfo.getFareTermEnd());
            tCorp.setFareScope(corpInfo.getFareScope());
            tCorp.setUniScid(corpInfo.getUniScid());
            tCorp.setCorpTel(corpInfo.getCorpTel());
            tCorp.setCorpWebUrl(corpInfo.getCorpWebUrl());
            tCorp.setCorpLogo(corpInfo.getCorpLogo());
            tCorp.setCorpEmail(corpInfo.getCorpEmail());
            tCorp.setPracPersonNum(corpInfo.getPracPersonNum());
            tCorp.setOrgInstCode(corpInfo.getOrgInstCode());
            tCorp.setTaxpayNum(corpInfo.getTaxpayNum());
            tCorp.setStaffSize(corpInfo.getStaffSize());
            tCorp.setEnglishName(corpInfo.getEnglishName());
            tCorp.setFormerName(corpInfo.getFormerName());
            tCorp.setCorpInfo(corpInfo.getCorpInfo());
            tCorp.setCreateDate(corpInfo.getCreateDate());
            tCorp.setCreateOrg(corpInfo.getCreateOrg());
        }

        return corpName;

    }

    //点击批量导出联系方式并存至Excel
    @RequestMapping(value="/batchContact.do")
    @ResponseBody
    public String batchContact(@RequestParam(value = "corp_name") String corp_name) throws Exception {
        String message;
        List<TCorp> corpIfs = searchCorpService.getListCorpByName(corp_name);

        if(corpIfs.size() > 20){
            message = "提示：您的搜索词太宽泛，建议更换一下搜索词！";
        }else{

            // 第一步，创建一个webbook，对应一个Excel文件
            HSSFWorkbook wb = new HSSFWorkbook();
            // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
            HSSFSheet sheet = wb.createSheet("企业联系方式表");
            // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
            HSSFRow row = sheet.createRow(0);
            // 第四步，创建单元格，并设置值表头 设置表头居中
            HSSFCellStyle style = wb.createCellStyle();
            style.setFillForegroundColor(HSSFColor.SKY_BLUE.index); //设置背景颜色
            style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
            HSSFFont font = wb.createFont();   // 生成一个字体
            font.setColor(HSSFColor.BLACK.index);
            font.setFontHeightInPoints((short) 12);
            font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            style.setFont(font);   // 把字体应用到当前的样式

            HSSFCell cell = row.createCell((short) 0);
            cell.setCellValue("企业名称");
            cell.setCellStyle(style);
            cell = row.createCell((short) 1);
            cell.setCellValue("联系电话");
            cell.setCellStyle(style);

            // 第五步，写入实体数据
            String fileName = "企业联系方式-千企查.xls";
            for (int i = 0; i < corpIfs.size(); i++)
            {
                row = sheet.createRow(i + 1);
                TCorp newtCorp = corpIfs.get(i);
                row.createCell((short) 0).setCellValue(newtCorp.getCorpName());
                row.createCell((short) 1).setCellValue(newtCorp.getCorpTel());
            }

            // 第六步，导出excel
            FileOutputStream fout = new FileOutputStream("C:\\Users\\Administrator\\Desktop\\"+fileName);
            wb.write(fout);
            fout.close();

            message = "提示：数据导出成功！";
        }
        return message;
    }

    //点击批量导出企业信息并存至Excel
    @RequestMapping(value="/exportData.do")
    @ResponseBody
    public String exportData(@RequestParam(value = "corp_name") String corp_name) throws Exception {
        String message;
        List<TCorp> corpIfs = searchCorpService.getListCorpByName(corp_name);

        if(corpIfs.size() > 20){
            message = "提示：您的搜索词太宽泛，建议更换一下搜索词！";
        }else {

            // 第一步，创建一个webbook，对应一个Excel文件
            HSSFWorkbook wb = new HSSFWorkbook();
            // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
            HSSFSheet sheet = wb.createSheet("企业信息（简）表");
            // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
            HSSFRow row = sheet.createRow(0);
            // 第四步，创建单元格，并设置值表头 设置表头居中
            HSSFCellStyle style = wb.createCellStyle();
            style.setFillForegroundColor(HSSFColor.SKY_BLUE.index); //设置背景颜色
            style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
            HSSFFont font = wb.createFont();   // 生成一个字体
            font.setColor(HSSFColor.BLACK.index);
            font.setFontHeightInPoints((short) 12);
            font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            style.setFont(font);   // 把字体应用到当前的样式

            HSSFCell cell = row.createCell((short) 0);
            cell.setCellValue("企业名称");
            cell.setCellStyle(style);
            cell = row.createCell((short) 1);
            cell.setCellValue("注册号");
            cell.setCellStyle(style);
            cell = row.createCell((short) 2);
            cell.setCellValue("法人代表");
            cell.setCellStyle(style);
            cell = row.createCell((short) 3);
            cell.setCellValue("注册资本");
            cell.setCellStyle(style);
            cell = row.createCell((short) 4);
            cell.setCellValue("成立日期");
            cell.setCellStyle(style);
            cell = row.createCell((short) 5);
            cell.setCellValue("联系电话");
            cell.setCellStyle(style);
            cell = row.createCell((short) 6);
            cell.setCellValue("企业网站");
            cell.setCellStyle(style);

            // 第五步，写入实体数据
            String fileName = "企业信息（简）-千企查.xls";
            for (int i = 0; i < corpIfs.size(); i++) {
                row = sheet.createRow(i + 1);
                TCorp newtCorp = corpIfs.get(i);
                row.createCell((short) 0).setCellValue(newtCorp.getCorpName());
                row.createCell((short) 1).setCellValue(newtCorp.getRegNo());
                row.createCell((short) 2).setCellValue(newtCorp.getOperManName());
                row.createCell((short) 3).setCellValue(newtCorp.getRegCapi());
                row.createCell((short) 4).setCellValue(newtCorp.getStartDate());
                row.createCell((short) 5).setCellValue(newtCorp.getCorpTel());
                row.createCell((short) 6).setCellValue(newtCorp.getCorpWebUrl());
            }

            // 第六步，导出excel
            FileOutputStream fout = new FileOutputStream("C:\\Users\\Administrator\\Desktop\\" + fileName);
            wb.write(fout);
            fout.close();
            message = "提示：数据导出成功！";
        }
        return message;

    }

    //点击导出企业信息生成Excel
    @RequestMapping(value="/batExport.do")
    @ResponseBody
    public String batExport(@RequestParam(value = "corpList") List<String> corpList) throws Exception{
        String message;
        List corpIfs = new ArrayList();
        for(int i = 0;i < corpList.size();i++){
            TCorp tcorp = searchCorpService.getCorpByName(corpList.get(i));
            corpIfs.add(tcorp);
        }

        if(corpIfs.size() > 20){
            message = "提示：查询结果过多，建议减少输入文字！";
        }else {

            // 第一步，创建一个webbook，对应一个Excel文件
            HSSFWorkbook wb = new HSSFWorkbook();
            // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
            HSSFSheet sheet = wb.createSheet("企业信息（简）表");
            sheet.autoSizeColumn(1, true);
            // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
            HSSFRow row = sheet.createRow(0);
            // 第四步，创建单元格，并设置值表头 设置表头居中
            HSSFCellStyle style = wb.createCellStyle();
            style.setFillForegroundColor(HSSFColor.SKY_BLUE.index); //设置背景颜色
            style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
            HSSFFont font = wb.createFont();   // 生成一个字体
            font.setColor(HSSFColor.BLACK.index);
            font.setFontHeightInPoints((short) 12);
            font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            style.setFont(font);   // 把字体应用到当前的样式

            HSSFCell cell = row.createCell((short) 0);
            cell.setCellValue("企业名称");
            cell.setCellStyle(style);
            cell = row.createCell((short) 1);
            cell.setCellValue("注册号");
            cell.setCellStyle(style);
            cell = row.createCell((short) 2);
            cell.setCellValue("法人代表");
            cell.setCellStyle(style);
            cell = row.createCell((short) 3);
            cell.setCellValue("注册资本");
            cell.setCellStyle(style);
            cell = row.createCell((short) 4);
            cell.setCellValue("成立日期");
            cell.setCellStyle(style);
            cell = row.createCell((short) 5);
            cell.setCellValue("联系电话");
            cell.setCellStyle(style);
            cell = row.createCell((short) 6);
            cell.setCellValue("企业网站");
            cell.setCellStyle(style);

            // 第五步，写入实体数据
            String fileName = "企业信息（简）-千企查.xls";
            for (int i = 0; i < corpIfs.size(); i++) {
                row = sheet.createRow(i + 1);
                TCorp newtCorp = (TCorp) corpIfs.get(i);
                row.createCell((short) 0).setCellValue(newtCorp.getCorpName());
                row.createCell((short) 1).setCellValue(newtCorp.getRegNo());
                row.createCell((short) 2).setCellValue(newtCorp.getOperManName());
                row.createCell((short) 3).setCellValue(newtCorp.getRegCapi());
                row.createCell((short) 4).setCellValue(newtCorp.getStartDate());
                row.createCell((short) 5).setCellValue(newtCorp.getCorpTel());
                row.createCell((short) 6).setCellValue(newtCorp.getCorpWebUrl());
            }

            // 第六步，导出excel
            FileOutputStream fout = new FileOutputStream("C:\\Users\\Administrator\\Desktop\\" + fileName);
            wb.write(fout);
            fout.close();
            message = "提示：查询结果企业信息导出成功！";
        }


        return message;
    }
}
