package kr.or.ddit.travelmaker.member.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberSocial {
	private String memNo;
	private String socialType;
	private String socialId;
}
