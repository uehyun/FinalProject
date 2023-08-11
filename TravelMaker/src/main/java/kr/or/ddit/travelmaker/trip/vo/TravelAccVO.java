package kr.or.ddit.travelmaker.trip.vo;

import java.util.List;

import kr.or.ddit.travelmaker.utils.vo.FileVO;
import lombok.Data;

@Data
public class TravelAccVO {
	private String aresNo;
    private String memNo;
    private String memName;
    private String memProfilePath;
    private String memEmail;
    private String accNo;
    private String accName;
    private String accLocation;
    private String accLogitide;
    private String accLatitude;
    private String travelDate;
    private String aresCheckinDate;
    private String aresCheckoutDate;
    private String aresCheckin;
    private String aresCheckout;
    private List<FileVO> imgList;
}
