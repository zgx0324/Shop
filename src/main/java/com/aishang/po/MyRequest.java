package com.aishang.po;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.io.UnsupportedEncodingException;
import java.util.Map;

/**
 * @Author: ZGX
 * @Date: 2019/2/15 15:22
 * @Description: request 包装类
 */

public class MyRequest extends HttpServletRequestWrapper {
    private String encode = "iso-8859-1";
    private HttpServletRequest request;
    private boolean flag = true;

    public MyRequest(HttpServletRequest request) {
        super(request);
        this.request = request;
    }

    public MyRequest(HttpServletRequest request, String encode) {
        super(request);
        this.encode = encode;
        this.request = request;
    }

    /**
     * 重写getParameter
     */
    @Override
    public String getParameter(String name) {
        String parameter = super.getParameter(name);
        try {
            if (parameter != null && !parameter.trim().equals(""))
                parameter = new String(parameter.getBytes("iso-8859-1"), encode);
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return parameter;
    }

    /**
     * 重写getParameterMap
     */
    @Override
    public Map<String, String[]> getParameterMap() {
        // TODO 重写getParameterMap
        Map<String, String[]> parameterMap = request.getParameterMap();
        if (flag && !parameterMap.isEmpty()) {
            for (Map.Entry<String, String[]> m : parameterMap.entrySet()) {
                String[] values = m.getValue();
                for (int i = 0; i < values.length; i++) {
                    try {
                        values[i] = new String(
                                values[i].getBytes("iso-8859-1"), encode);
                    } catch (UnsupportedEncodingException e) {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                }
            }
            flag = false;
        }
        return parameterMap;
    }

    /**
     * 重写getParameterValues
     */
    @Override
    public String[] getParameterValues(String name) {
        // TODO 重写getParameterValues
        String[] parameterValues = super.getParameterValues(name);
        try {
            if (parameterValues!=null) {
                for (int i = 0; i < parameterValues.length; i++) {
                    parameterValues[i] = new String( parameterValues[i].getBytes("iso-8859-1"), encode);
                }
            }
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return parameterValues;
    }
}
