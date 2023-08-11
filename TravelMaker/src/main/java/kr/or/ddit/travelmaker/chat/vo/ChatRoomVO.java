package kr.or.ddit.travelmaker.chat.vo;

import lombok.Data;

@Data
public class ChatRoomVO {
	private String chatroomNo;
	private String memNo;
	private String accNo;
	private String hostNo;
	private String chatroomRegDate;
	private String memProfilePath;
	private String hostProfilePath;
	private String chatMessageContent;
	
	private String message;
	private int state;
}
