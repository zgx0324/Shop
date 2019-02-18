package com.aishang.controller;

import cn.dsna.util.images.ValidateCode;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsRequest;
import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import com.aliyuncs.profile.IClientProfile;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

/**
 * @Author: ZGX
 * @Date: 2019/2/13 14:19
 * @Description:实现注册的验证码功能以及验证码的前台验证
 *              --图片验证码生成及验证
 *              --短信验证码生成及验证
 */
@Controller
@RequestMapping
public class ValidateController {

    // TODO 注入参数
    @Resource
    HttpSession session;

    // TODO 生成图形验证码
    @RequestMapping("validate")
    public void validate(HttpServletResponse response) {

        //设置浏览器端缓存信息
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Pragrma", "no-cache");
        response.setDateHeader("Expires", 0);

        //创建ValidateCode对象生成图片文件以及向session中添加验证码信息
        ValidateCode validate = new ValidateCode(165, 65, 4, 100);
        String code = validate.getCode();
        //System.out.println(code);
        session.setAttribute("code", code);
        //System.out.println(session.getAttribute("code"));
        try {
            //向浏览器端响应图片字节流
            validate.write(response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //TODO 前台验证图形验证码
    @RequestMapping("doValidate")
    public void doValidate(String code, HttpServletResponse response) {

        try {
            PrintWriter out = response.getWriter();
            if (code.trim().equalsIgnoreCase((String) session.getAttribute("code"))) {
                out.print("true");
            } else {
                out.print("false");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    //TODO 短信验证码
    @RequestMapping("tel")
    public void tel(String tel, HttpServletResponse response) {
        try {
            //设置超时时间-可自行调整
            System.setProperty("sun.net.client.defaultConnectTimeout", "10000");
            System.setProperty("sun.net.client.defaultReadTimeout", "10000");
            //初始化ascClient需要的几个参数
            final String product = "Dysmsapi";//短信API产品名称（短信产品名固定，无需修改）
            final String domain = "dysmsapi.aliyuncs.com";//短信API产品域名（接口地址固定，无需修改）
            //替换成你的AK
            final String accessKeyId = "LTAIkJ1oC8ONcfRI";//你的accessKeyId,参考本文档步骤2
            final String accessKeySecret = "Nlb99miFJz16whaUFkjSU5r8rkkhpQ";//你的accessKeySecret，参考本文档步骤2
            //初始化ascClient,暂时不支持多region（请勿修改）
            IClientProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId,
                    accessKeySecret);

            DefaultProfile.addEndpoint("cn-hangzhou", "cn-hangzhou", product, domain);

            IAcsClient acsClient = new DefaultAcsClient(profile);
            //组装请求对象
            SendSmsRequest request = new SendSmsRequest();
            //使用post提交
            request.setMethod(MethodType.POST);
            //必填:待发送手机号。支持以逗号分隔的形式进行批量调用，批量上限为1000个手机号码,批量调用相对于单条调用及时性稍有延迟,验证码类型的短信推荐使用单条调用的方式；发送国际/港澳台消息时，接收号码格式为国际区号+号码，如“85200000000”
            request.setPhoneNumbers(tel);
            //必填:短信签名-可在短信控制台中找到
            request.setSignName("十七號");
            //必填:短信模板-可在短信控制台中找到，发送国际/港澳台消息时，请使用国际/港澳台短信模版
            request.setTemplateCode("SMS_131310008");
            //可选:模板中的变量替换JSON串,如模板内容为"亲爱的${name},您的验证码为${code}"时,此处的值为
            //友情提示:如果JSON中需要带换行符,请参照标准的JSON协议对换行符的要求,比如短信内容中包含\r\n的情况在JSON中需要表示成\\r\\n,否则会导致JSON在服务端解析失败
            String code = "";
            for (int i=0;i<6;i++){
               code=code+new Random().nextInt(9);
            }
            System.out.println(code);
            request.setTemplateParam("{\"code\":\""+code+"\"}");
            //可选-上行短信扩展码(扩展码字段控制在7位或以下，无特殊需求用户请忽略此字段)
            //request.setSmsUpExtendCode("90997");
            //可选:outId为提供给业务方扩展字段,最终在短信回执消息中将此值带回给调用者
            //request.setOutId("yourOutId");
            //请求失败这里会抛ClientException异常
            SendSmsResponse sendSmsResponse = acsClient.getAcsResponse(request);
            PrintWriter out = response.getWriter();
            if (sendSmsResponse.getCode() != null && sendSmsResponse.getCode().equals("OK")) {
                //请求成功
                System.out.println("发送成功");
                out.print(code);
            }else{
                System.out.println("发送失败");
            }

        } catch (ClientException e) {
            e.printStackTrace();

        }catch (Exception e) {
            e.printStackTrace();

        }
    }
}
