package com.uni.sellers.logger;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Repository;
import org.springframework.util.StopWatch;

/**
 * @author  : 욱이
 * @date : 2016. 12. 28.
 * @explain : 쿼리 시간 로그 클래스
 */
@Aspect
@Repository("proceedAdvice")
public class ProceedAdvice {
	protected Log log = LogFactory.getLog(ProceedAdvice.class);
	
	@Around("execution(* com..*DAO.*(..))")
	public Object aroundMethod(ProceedingJoinPoint joinPoint) throws Throwable {
		
		String methodName = joinPoint.getSignature().getName();
		String className = joinPoint.getTarget().getClass().getSimpleName();
		StopWatch stopWatch = new StopWatch();
		stopWatch.start();


		
		Object retVal = joinPoint.proceed();
		stopWatch.stop();
		log.info(className + "." + methodName + " proceed end. execute time: "  + stopWatch.getTotalTimeSeconds() + "s");
		
		return retVal;
	}
	
}

