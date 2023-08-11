package kr.or.ddit.travelmaker.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component("aopController")
@Aspect
@Slf4j
public class AOPController {
	@Around("execution(* kr.or.ddit.travelmaker.host.service.IHostService2.*(..))")
	public Object timeLog(ProceedingJoinPoint pjp) throws Throwable {
		long startTime = System.currentTimeMillis();
		log.info("[@Around] start : " + Arrays.toString(pjp.getArgs()));
		
		Object result = pjp.proceed();
		
		long endTime = System.currentTimeMillis();
		log.info("[@Around] end : " + Arrays.toString(pjp.getArgs()));
		
		log.info("[@Around] : " + pjp.getSignature().getName() + "  메소드 실행 시간 : " + ((endTime-startTime)/1000));
		
		return result;
	}
}
