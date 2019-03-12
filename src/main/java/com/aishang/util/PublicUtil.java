package com.aishang.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

/**
 * @Author: ZGX
 * @Date: 2019/2/24 17:16
 * @Description:
 *          通用工具类
 */

public class PublicUtil {

    //判断是否为空
    public static boolean isEmpty(Object obj) {
        boolean flag = true;
        if(obj==null &&obj==""){
            flag=false;
        }
        return flag;
    }
    //生成不重复订单号
    public static String getOrderIdByUUId() {
        Date date = new Date();
        DateFormat format = new SimpleDateFormat("yyyyMMdd");
        String time = format.format(date);
        int hashCodeV = UUID.randomUUID().toString().hashCode();
        if (hashCodeV < 0) {//有可能是负数
            hashCodeV = -hashCodeV;
        }
        // 0 代表前面补充0
        // 4 代表长度为4
        // d 代表参数为正数型
        return time + String.format("%011d", hashCodeV);

    }
    //上传文件
    public static String upload(MultipartFile file, String contextPath){
        // 随机生成32位随机UUID防止文件名称出现重复
        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
        uuid = uuid + "_"+file.getOriginalFilename();
        //按日期创建文件夹
        Calendar now = Calendar.getInstance();
        String path = "\\images\\fileImages\\" + now.get(Calendar.YEAR) + "\\"
                + (now.get(Calendar.MONTH) + 1) + "\\"
                + now.get(Calendar.DAY_OF_MONTH);
        // 创建一个存盘目录对象
        String rootPath = contextPath + path;
        File storyDirectory = new File(rootPath);
        // 如果此目录不存在，需要创建，有的话，就不管了
        if (!storyDirectory.exists()) {
            storyDirectory.mkdirs(); // 创建多级目录
        }
        File put = new File(storyDirectory, uuid);
        try {
            file.transferTo(put);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return path+"\\"+uuid;
    }

    public static void delPic(String path) {
        // TODO Auto-generated method stub
        // 通过传来的文件路径+项目路径
        File file = new File(path);
        if (file.exists()) {
            file.delete();
        }
        String parentPath = getParentPath(path);
        File parentFile = new File(parentPath);
        String[] list = parentFile.list();
        if(parentFile.exists()){
            if (parentFile == null || list.length == 0) {
                delFolder(parentPath);
            }
        }
    }

    // 删除文件夹
    // param folderPath 文件夹完整绝对路径
    public static void delFolder(String folderPath) {
        try {
            // delAllFile(folderPath); // 删除完里面所有内容
            String filePath = folderPath;
            filePath = filePath.toString();
            java.io.File myFilePath = new java.io.File(filePath);
            myFilePath.delete(); // 删除空文件夹
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 删除指定文件夹下所有文件
    // param path 文件夹完整绝对路径
    public static boolean delAllFile(String path) {
        boolean flag = false;
        File file = new File(path);
        if (!file.exists()) {
            return flag;
        }
        if (!file.isDirectory()) {
            return flag;
        }
        String[] tempList = file.list();
        File temp = null;
        for (int i = 0; i < tempList.length; i++) {
            if (path.endsWith(File.separator)) {
                temp = new File(path + tempList[i]);
            } else {
                temp = new File(path + File.separator + tempList[i]);
            }
            if (temp.isFile()) {
                temp.delete();
            }
            if (temp.isDirectory()) {
                delAllFile(path + "/" + tempList[i]);// 先删除文件夹里面的文件
                delFolder(path + "/" + tempList[i]);// 再删除空文件夹
                flag = true;
            }
        }
        return flag;
    }
    // 得到该文件的父类文件的路径
    public static String getParentPath(String path) {
        File file = new File(path);
        StringBuilder sb = new StringBuilder();
        File temp = file;
        while (temp.getParentFile() != null
                && temp.getParentFile().getName().length() != 0) {
            sb.insert(0, "/" + temp.getParentFile().getName());
            temp = temp.getParentFile();
        }
        sb.append("/");
        return sb.toString();

    }

}
