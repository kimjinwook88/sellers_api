package com.uni.sellers.security;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

public class AuthenticationFilterAnotherParam extends UsernamePasswordAuthenticationFilter {
	
	@Autowired
	@Override
    public void setAuthenticationManager(AuthenticationManager authenticationManager) {
        super.setAuthenticationManager(authenticationManager);
    }
	
	@Autowired
	@Override
	public void setAuthenticationSuccessHandler(AuthenticationSuccessHandler successHandler) {
		// TODO Auto-generated method stub
		super.setAuthenticationSuccessHandler(successHandler);
	}
	
    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
        //final String company_cd = request.getParameter("company_cd");
        final String member_id_num = request.getParameter("member_id_num");
        final String password_enc = request.getParameter("password_enc");
        //request.getSession().setAttribute("company_cd", company_cd);
        request.getSession().setAttribute("member_id_num", member_id_num);
        request.getSession().setAttribute("password_enc", password_enc);
        return super.attemptAuthentication(request, response);
    }
	
    /*@Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response,FilterChain filter, Authentication authResult) throws IOException, ServletException {
        super.successfulAuthentication(request, response,filter, authResult);
    }*/
	
	@Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response, AuthenticationException failed) throws IOException, ServletException {
        request.getSession().removeAttribute("company_cd");
        request.getSession().removeAttribute("member_id_num");
        request.getSession().removeAttribute("password_enc");
        setAuthenticationFailureHandler(new SimpleUrlAuthenticationFailureHandler("/loginFail.do"));
        super.unsuccessfulAuthentication(request, response, failed);
    }

}
