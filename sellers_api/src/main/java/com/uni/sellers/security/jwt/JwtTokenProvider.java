package com.uni.sellers.security.jwt;

import java.io.IOException;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@Component("JwtTokenProvider")
public class JwtTokenProvider {
	
	@Value("#{config['spring.jwt.secret']}")
	private String secretKey;
	
	@Value("#{config['spring.jwt.access.header']}")
	private String accessTokenHeader;
	
	@Value("#{config['spring.jwt.refresh.header']}")
	private String refreshTokenHeader;
	
	private long AccessTokenValidMillisecond = 1000L * 60 * 60; // 1시간만 토큰 유효
//	private long AccessTokenValidMillisecond = 1L; // 1시간만 토큰 유효
	private long refreshTokenValidMillisecond = 1000L * 60 * 60 * 24 * 14; // 2주 토큰 유효
	
	
	@PostConstruct
	protected void init() {
	    secretKey = Base64.getEncoder().encodeToString(secretKey.getBytes());
	}
	
	/**
	 * JWT 토큰 생성
	 * @param userPk
	 * @param roles
	 * @param userInfo
	 * @param type	1: Access Token, 2: Refresh Token
	 * @return
	 */
	public String createToken(String userPk, List<String> roles, Map<String, Object> userInfo, int type) {
		Map<String, Object> authMap = new HashMap<>();
		authMap.put("auth", roles.toString());
		
		Claims claims = Jwts.claims().setSubject(userPk);
		claims.put("authMap", authMap);
		claims.put("userInfo", userInfo);
		
		Date now = new Date();
		long expireTime = 0;
		if(type == 1) {
			expireTime = AccessTokenValidMillisecond;
		}else {
			expireTime = refreshTokenValidMillisecond;
		}
		
		return Jwts.builder()
				.setClaims(claims) // 데이터
				.setIssuedAt(now)  // 토큰 발행일자
				.setExpiration(new Date(now.getTime() + expireTime)) // 만료 시간
				.signWith(SignatureAlgorithm.HS256, secretKey) // 암호화 알고리즘, secret 값 세팅
				.compact();
	}
	
	/**
	 * Request의 Header에서 token 파싱
	 * @param req
	 * @param type 1: Access Token 2: Refresh Token
	 * @return
	 */
	public String resolveToken(HttpServletRequest req, int type) {
		if(type == 1) {
			return req.getHeader(accessTokenHeader);
		}else {
			return req.getHeader(refreshTokenHeader);
		}
	}
	
	/**
	 * Jwt 토큰으로 인증 정보를 조회
	 */
	/*public Authentication getAuthentication(String token) {
		UserDetails userDetails = userDetailsService.loadUserByUsername(this.getUserPk(token));
		return new UsernamePasswordAuthenticationToken(userDetails, "", userDetails.getAuthorities());
	}*/
	
	/**
	 * Jwt 토큰에서 회원 구별 정보 추출
	 */
	public String getUserPk(String token) {
		return Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token).getBody().getSubject();
	}
	
	public Map<String, Object> getUserInfo(String token, String infoKey) {
		return (Map<String, Object>)Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token).getBody().get(infoKey);
	}
	
	/**
	 * Jwt 토큰의 유효성 + 만료일자 확인
	 * @throws IOException 
	 */
	public boolean validateToken(String jwtToken, HttpServletResponse response) throws IOException {
		try {
			Jws<Claims> claims = Jwts.parser().setSigningKey(secretKey).parseClaimsJws(jwtToken);
			return !claims.getBody().getExpiration().before(new Date());
		}catch(ExpiredJwtException e) {
			response.sendError(HttpServletResponse.SC_FORBIDDEN, "ExpiredToken");
			return false;
		}catch(Exception e) {
			response.sendError(HttpServletResponse.SC_FORBIDDEN);
			return false;
		}
	}
}