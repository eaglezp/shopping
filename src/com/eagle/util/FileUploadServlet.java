package com.eagle.util;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@WebServlet(name = "FileUploadServlet")
public class FileUploadServlet extends HttpServlet{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //1,工厂
        FileItemFactory fileItemFactory = new DiskFileItemFactory();
        //2,核心类
        ServletFileUpload servletFileUpload = new ServletFileUpload(fileItemFactory);
        //3,解析request,List存放FileItem（表单元素的封装对象,一个<input>对应一个对象）
        try {
            List<FileItem> fileItemList = servletFileUpload.parseRequest(request);
            //4,遍历集合，获取数据
            for(FileItem fileItem : fileItemList){
                if(fileItem.isFormField()){
                    //5,是否是表单字段（普通表单元素）
                    //5.1表单字段名称
                    String fieldName = fileItem.getFieldName();
                    System.out.println("表单字段名称:"+fieldName);
                    //5.2表单字段值
                    String fileValue = fileItem.getString();
                    System.out.println("表单字段值:"+fileValue);//中文会出现乱码
                } else {
                    //6,上传字段（上传表单元素）
                    //6.1表单字段名称 fileItem.getFieldName();
                    //6.2上传文件名
                    String  fileName = fileItem.getName();
                    // * 兼容浏览器， IE ： C:\Users\xxx\Desktop\abc.txt  ; 其他浏览器 ： abc.txt
                    fileName = fileName.substring(fileName.lastIndexOf("\\")+1);
                    System.out.println("fileName:"+fileName);//中文会出现乱码
                    //6.3上传内容
                    InputStream inputStream = fileItem.getInputStream();//获取输入流
                    String parentDir = this.getServletContext().getRealPath("/WEB-INF/upload");
                    File file = new File(parentDir,fileName);
                    System.out.println("file:"+file+",,,file.getParentFile:"+file.getParentFile());

                    if(!file.getParentFile().exists()){//父目录不存在
                        file.getParentFile().mkdirs();//创建文件夹，如果父目录没有，也一起创建出来
                    }
                    FileOutputStream fileOutputStream =  new FileOutputStream(file);
                    byte[] buf = new byte[1024];
                    int len = -1;
                    while ((len=inputStream.read()) != -1){
                        fileOutputStream.write(buf,0,len);
                    }
                    fileOutputStream.close();
                    inputStream.close();
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
