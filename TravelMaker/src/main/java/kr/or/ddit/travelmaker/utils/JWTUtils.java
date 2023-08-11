package kr.or.ddit.travelmaker.utils;

import java.util.Date;

import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Component;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class JWTUtils {
	private final String SECRET = "TravelMakerAuthentication";
	
	//토큰 발급
    public String generateToken(User user) {
        Claims claims = Jwts.claims();
        claims.put("username", user.getUsername());
        return createToken(claims, user.getUsername()); 
    }
    
    //토큰 생성
    private String createToken(Claims claims, String userName) {
        return Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + 1000 * 10))
                .signWith(SignatureAlgorithm.HS256, SECRET)
                .compact();
    }

    //토큰의 유효 여부
    public Boolean isValidToken(String token, User user) {
        log.info("isValidToken token = {}", token);
        String username = getUsernameFromToken(token);
        return (username.equals(user.getUsername()) && !isTokenExpired(token));
    }
    
    //claim에서 아이디값 가져오기
    public String getUsernameFromToken(String token) {
        String username = String.valueOf(getAllClaims(token).get("username"));
        log.info("getUsernameFormToken subject = {}", username);
        return username;
    }
    
    //토큰의 claim 디코딩
    private Claims getAllClaims(String token) {
        log.info("getAllClaims token = {}", token);
        return Jwts.parser()
                .setSigningKey(SECRET)
                .parseClaimsJws(token)
                .getBody();
    }

    //토큰 만료기한
    public Date getExpirationDate(String token) {
        Claims claims = getAllClaims(token);
        return claims.getExpiration();
    }
    
    //만료 토큰 여부
    private boolean isTokenExpired(String token) {
        return getExpirationDate(token).before(new Date());
    }
}
