package com.uni.sellers.common;
import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Hex;
import org.springframework.stereotype.Repository;
 
@Repository("commonAppSecurity")
public class CommonAppSecurity {
 
	// 암호화 함수 인자값은 ("실제비밀번호", "유니포인트와 디유넷이 만들 규칙 키")
	public String Encryption(String str, String pw) throws Exception{
	    byte[] bytes = pw.getBytes();
	    SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
	    sr.setSeed(bytes);
	    KeyGenerator kgen = KeyGenerator.getInstance("AES");
	    kgen.init(128, sr);
	    
	    SecretKey skey = kgen.generateKey();
	    SecretKeySpec skeySpec = new SecretKeySpec(skey.getEncoded(), "AES");
	    Cipher c = Cipher.getInstance("AES");
	    c.init(Cipher.ENCRYPT_MODE, skeySpec);
	    
	    byte[] encrypted = c.doFinal(str.getBytes());
	    return Hex.encodeHexString(encrypted);
	}
	 
	// 복호화 함수 인자값은 ("암호화된 비밀번호", "유니포인트와 디유넷이 만들 규칙 키")
	public String Decryption(String str, String pw) throws Exception{
	    byte[] bytes = pw.getBytes();
	    SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
	    sr.setSeed(bytes);
	    KeyGenerator kgen = KeyGenerator.getInstance("AES");
	    kgen.init(128, sr);
	    
	    SecretKey skey = kgen.generateKey();
	    SecretKeySpec skeySpec = new SecretKeySpec(skey.getEncoded(), "AES");
	    
	    Cipher c = Cipher.getInstance("AES");
	    c.init(Cipher.DECRYPT_MODE, skeySpec);
	    byte[] decrypted = c.doFinal(Hex.decodeHex(str.toCharArray()));
	    return new String(decrypted);
	}
	  
	public static void main(String[] args) throws Exception{
		//암호화 !!
		System.out.println(new CommonAppSecurity().Encryption("uni123","sellersDunetUnipoint"));
		
		//복호화 !!
		System.out.println(new CommonAppSecurity().Decryption("1d9280dbcbd0833d56e50c976c8a36ec","sellersDunetUnipoint"));
	}
}