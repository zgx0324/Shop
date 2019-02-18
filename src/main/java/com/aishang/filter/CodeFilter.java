package com.aishang.filter;

import com.aishang.po.MyRequest;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @Author: ZGX
 * @Date: 2019/2/15 15:11
 * @Description: 编码过滤器
 */

public class CodeFilter implements Filter {
    private FilterConfig config;

    @Override
    public void init(FilterConfig config) throws ServletException {
        this.config=config;
    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse response = (HttpServletResponse)servletResponse;
        HttpServletRequest request = (HttpServletRequest)servletRequest;

        response.setContentType("text/html;charset=UTF-8");
        String encode = config.getInitParameter("encoding");

        MyRequest myRequest = new MyRequest(request,encode);
        chain.doFilter(myRequest,response);

    }

    @Override
    public void destroy() {

    }
}
