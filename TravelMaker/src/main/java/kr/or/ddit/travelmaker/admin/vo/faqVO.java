package kr.or.ddit.travelmaker.admin.vo;

import lombok.Data;

@Data
public class faqVO {
	private String faqBoardNo ;	//faq게시판 번호
	private String faqBoardTitle; 	//faq 게시판 제목
	private String faqBoardContent;	//faq 게시판 내용
	private int faqBoardHit;	//faq 게시판 조회수
	private String faqBoardRegDate;	//faq 게시판 등록 일자
	private String faqBoardModDate;	//faq 게시판 수정 일자
	private String faqBoardDelDate;	//faq 게시판 삭제 일자
	private String faqBoardDelYN;	//faq 게시판 삭제 여부
	private String faqAttGroupNo;	//첨부파일그룹 번호
	private String faqBoardWriter;	//faq 게시판 작성자
}
