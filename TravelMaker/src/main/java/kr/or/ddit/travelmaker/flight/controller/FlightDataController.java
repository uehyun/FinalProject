package kr.or.ddit.travelmaker.flight.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import kr.or.ddit.travelmaker.flight.service.IFlightService;
import kr.or.ddit.travelmaker.flight.vo.FlightVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/data")
@Slf4j
public class FlightDataController {

	@Inject
	private IFlightService flightService;

	@RequestMapping(value = "/fdp", method = RequestMethod.GET)
	public String flightDataPage() {
		return "flight/flightData";
	}

	public String parsingData(String departTime, String departAirport, String arriveAirport) {
		try {
			StringBuilder urlBuilder = new StringBuilder(
					"http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getFlightOpratInfoList");
			urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8")
					+ "=StrwU1QJEQTAnpdA3iOEUtDhf0CU5yoHRPMJ7iNArDeFjPIAbR6CpnFd7Lndzg0qV%2BU%2B5djKAacTKsQ7ZhrF4Q%3D%3D");
			urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
			urlBuilder.append(
					"&" + URLEncoder.encode("depAirportId", "UTF-8") + "=" + URLEncoder.encode(departAirport, "UTF-8"));
			urlBuilder.append(
					"&" + URLEncoder.encode("arrAirportId", "UTF-8") + "=" + URLEncoder.encode(arriveAirport, "UTF-8"));
			urlBuilder.append(
					"&" + URLEncoder.encode("depPlandTime", "UTF-8") + "=" + URLEncoder.encode(departTime, "UTF-8"));
			URL url = new URL(urlBuilder.toString());
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");

			log.info("Response code: " + conn.getResponseCode());

			BufferedReader rd = null;

			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}
			StringBuilder sb = new StringBuilder();
			String line;

			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
			conn.disconnect();
			System.out.println(sb.toString());
			return sb.toString();
		} catch (Exception e) {
			return null;
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public String flightDataList(String departTime, String departAirport, String arriveAirport) {
		/*
		 * LocalDate date = LocalDate.parse(departTime);
		 * 
		 */
		String data = parsingData(departTime, departAirport, arriveAirport);

		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(data);
		JsonObject response = element.getAsJsonObject().get("response").getAsJsonObject();
		JsonObject body = response.getAsJsonObject().get("body").getAsJsonObject();
		JsonObject items = body.getAsJsonObject().get("items").getAsJsonObject();

		Gson gson = new Gson();
		JsonArray item = items.getAsJsonObject().get("item").getAsJsonArray();

		List<FlightVO> flightList = new ArrayList<>();

		// DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
//		SimpleDateFormat fommatter = new SimpleDateFormat("YYYYMMDDHHMI");

		List<Map<String, String>> list = gson.fromJson(item, new TypeToken<List<Map<String, String>>>() {}.getType());
		for (Map<String, String> map : list) {
			  FlightVO vo = new FlightVO();
			  vo.setFlightAirline(map.get("airlineNm").toString());
			  vo.setFlightModel(map.get("vihicleId").toString());
			  vo.setFlightDepartTime(map.get("depPlandTime").toString());
			  vo.setFlightArriveTime(map.get("arrPlandTime").toString());
			  vo.setDepartAirport(map.get("depAirportNm").toString());
			  vo.setArriveAirport(map.get("arrAirportNm").toString());
			  
			  flightList.add(vo);
		}
		 flightService.insertFlightData(flightList);
		 log.info("비행기 데이터 들어갔는지..");
		return "";
	}
}
