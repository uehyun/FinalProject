package kr.or.ddit.travelmaker.admin.vo;

import java.util.List;

import lombok.Data;

@Data
public class MemberManageVO {
   private String memNo;
   private String memId;
   private String memName;
   private String memPhone;
   private String memEmail;
   private String memAgree;
   private String memRegDate;
   private String memDelDate;
   private String enabled;
   private String memDel;
   private String memProfilePath;
   private String memBlameCount;
   private String memPreLanguage;
   private String memPreCurrency;
}
