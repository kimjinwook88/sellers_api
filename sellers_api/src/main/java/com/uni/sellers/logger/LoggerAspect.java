package com.uni.sellers.logger;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;

// 어떤 계층의 어떤 메서드가 실행되었는지를 보여주는 역할
@Aspect
public class LoggerAspect {
    protected Log log = LogFactory.getLog(LoggerAspect.class);
    static String name = "";
    static String type = "";
     
    @Around("execution(* com..*Controller.*(..)) or execution(* com..*Service.*(..)) or execution(* com..*DAO.*(..))")
    public Object logPrint(ProceedingJoinPoint joinPoint) throws Throwable {
        type = joinPoint.getSignature().getDeclaringTypeName();
         
        if (type.indexOf("Controller") > -1) {
            name = "Controller  \t:  ";
        }
        else if (type.indexOf("Service") > -1) {
            name = "Service  \t:  ";
        }
        else if (type.indexOf("DAO") > -1) {
            name = "DAO  \t\t:  ";
        }
        log.info(name + type + "." + joinPoint.getSignature().getName() + "()");
        return joinPoint.proceed();
    }
}