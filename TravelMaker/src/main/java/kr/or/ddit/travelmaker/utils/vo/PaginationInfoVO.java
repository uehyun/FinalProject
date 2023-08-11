package kr.or.ddit.travelmaker.utils.vo;

import java.util.List;

public class PaginationInfoVO<T> {
	private int totalRecord;	//총 게시글 수 
	private int totalPage;		//총 페이지 수 
	private int currentPage;	//현재 페이지
	private int screenSize;		//페이지 당 게시글 수
	private int blockSize = 3;	//페이지 블록 수
	private int startRow;		//시작 row
	private int endRow;			//끝 row
	private int startPage;		//시작 페이지
	private int endPage;		//끝 페이지
	private List<T> dataList;	//결과를 넣을 데이터리스트 - 1페이지에 해당하는 게시글 목록을 담을 공간
	private String searchType;	//검색 타입
	private String searchWord;	//검색 단어
	private String memNo;	//회원 번호
	
	// 메인용
	private String juso;
	private String checkIn;
	private String checkOut;
	private int guest;
	private String category;
	
	public String getJuso() {
		return juso;
	}

	public void setJuso(String juso) {
		this.juso = juso;
	}

	public String getCheckIn() {
		return checkIn;
	}

	public void setCheckIn(String checkIn) {
		this.checkIn = checkIn;
	}

	public String getCheckOut() {
		return checkOut;
	}

	public void setCheckOut(String checkOut) {
		this.checkOut = checkOut;
	}

	public int getGuest() {
		return guest;
	}

	public void setGuest(int guest) {
		this.guest = guest;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	public PaginationInfoVO() {
		
	}
	
	public PaginationInfoVO(int screenSize, int blockSize) {
		this.screenSize = screenSize;
		this.blockSize = blockSize;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
		
		totalPage = (int) Math.ceil(totalRecord / (double) screenSize);
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
		endRow = currentPage * screenSize;		
		startRow = endRow - (screenSize - 1);	
		
		endPage = (currentPage + (blockSize - 1)) / blockSize * blockSize;
		startPage = endPage - (blockSize - 1);	
	}

	public int getScreenSize() {
		return screenSize;
	}

	public void setScreenSize(int screenSize) {
		this.screenSize = screenSize;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	public int getStartRow() {
		return startRow;
	}

	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}

	public int getEndRow() {
		return endRow;
	}

	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public List<T> getDataList() {
		return dataList;
	}

	public void setDataList(List<T> dataList) {
		this.dataList = dataList;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchWord() {
		return searchWord;
	}

	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	

	public String getPagingHTML() {
		StringBuffer html = new StringBuffer();
		
		html.append("<ul class='pagination model'>");
		
		if(startPage > 1) {
			html.append("<li><a href='' class='arrow left' data-page='" + (startPage - blockSize) + "'>&laquo;</a></li>");
		}
		
		for(int i = startPage; i <= (endPage < totalPage ? endPage : totalPage); i++) {
			if(i == currentPage) {
				html.append("<li><a class='active num'>" + i + "</li>");
			} else {
				html.append("<li><a href='' class='num' data-page='" + i + "'>" + i + "</a></li>");
			}
		}
		
		if(endPage < totalPage && totalPage > 1) {
			html.append("<li><a href='' class='arrow right' data-page='" + (endPage + 1) + "'>&raquo;</a></li>");
		}
		
		html.append("</ul>");
		
		return html.toString();
	}

	public String getMemNo() {
		return memNo;
	}

	public void setMemNo(String memNo) {
		this.memNo = memNo;
	}

}
