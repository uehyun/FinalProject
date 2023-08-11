package kr.or.ddit.travelmaker.utils;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.or.ddit.travelmaker.host.mapper.SHGHostMapper;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class SchedulerUtils {
	@Inject
	private SHGHostMapper mapper;
	
	@Scheduled(cron="0 1 0 * * ?")
	public void deleteBeforeDate() {
		log.info("날짜 지우기 스케줄러 실행");
		mapper.deleteBeforeDate();
	}
	
	@Scheduled(cron = "0 */3 * * * *")
	public void updateCategoryRank() {
		log.info("카테고리 순위 업데이트 실행");
		
		List<Map<String, Object>> list = mapper.selectPopular();
		
		for (Map<String, Object> map : list) {
			mapper.updateCategoryRank(map);
		}
	}
}
