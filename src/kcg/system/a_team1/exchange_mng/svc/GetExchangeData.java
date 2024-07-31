package kcg.system.a_team1.exchange_mng.svc;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

public class GetExchangeData {
	//1. 변수 세팅
	private static HttpURLConnection connection;
    private static BigDecimal defaultExchangeRate = BigDecimal.valueOf(1300);
    
    public static JSONArray getExchangeRate () {
        //API 응답을 읽기 위한 객체
        BufferedReader reader;
        //각 줄을 읽기 위한 변수
        String line;
        //응답 내용을 저장할 객체
        StringBuffer responseContent = new StringBuffer();
        //JSON 파싱을 위한 객체
        //안되면 임포트 바꿔보기
        JSONParser parser = new JSONParser();

        //API 인증키
        String authKey = "qJ9Ix3brcEAtwLnwxub2gZWSuUuNKu0p";
        
        //오늘 날짜
        //오늘이 토요일,일요일일때는 API가 응답을 안 하기 때문에 비교하기 위해 요일을 불러온다
        DayOfWeek dayOfWeek = LocalDate.now().getDayOfWeek();
        String currentDOW = dayOfWeek.getDisplayName(TextStyle.FULL, Locale.KOREAN);
        //하루 전, 이틀 전의 날짜 계산을 위해 Calendar타입의 객체를 선언
        Calendar calendar = new GregorianCalendar(Locale.KOREA);
        //날짜를 yyyyMMdd형식의 String으로 변환하기 위한 SimpleDateFormat 선언 
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        String searchDate = null;
        //토요일이면 하루 전, 일요일이면 이틀 전의 날짜를 사용한다.
        if(currentDOW.equals("토요일")) {        	
        	calendar.add(Calendar.DATE, -1);        	
        	Date friday = calendar.getTime();
        	searchDate = dateFormat.format(friday);
        } else if (currentDOW.equals("일요일")) {
        	calendar.add(Calendar.DATE, -2);
        	Date friday = calendar.getTime();
        	searchDate = dateFormat.format(friday);
        } else {
        	searchDate = dateFormat.format(new Date());
        } 
        
        //데이터 유형
        String dataType = "AP01";
        //환율 정보를 저장할 객체
        BigDecimal exchangeRate = null;
        JSONArray exchangeRateInfoList =null;

        try {
            // Request URL
            //API 요청을 위한 URL을 구성하고, 'HttpURLConnection' 객체 생성
            URL url = new URL("https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=" + authKey + "&searchdate=" + searchDate + "&data=" + dataType);
        	
        	//새벽에 안되서 쓴 url, 나중에 바꿔야 함
//            URL url = new URL("https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=" + authKey + "&searchdate=20240621&data=" + dataType);
            connection = (HttpURLConnection) url.openConnection();


            //요청 초기 세팅, HTTP 요청 설정(HTTP메서드를 GET으로 설정하고 연결 및 읽기 타임아웃을 5초로 설정)
            connection.setRequestMethod("GET");
            connection.setConnectTimeout(5000);
            connection.setReadTimeout(5000);

            //서버로부터 응답 코드를 받음
            int status = connection.getResponseCode();

            //API 호출 실패 했을 경우 - Connection Close
            if (status > 299) {
                System.out.println("status 오류");
                reader = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
                while ((line = reader.readLine()) != null) {
                    responseContent.append(line);
                }
                reader.close();
            } else {
                //API 호출 성공 했을 경우 - 환율 정보 추출
                //입력 스트림에서 JSON데이터를 읽어와 파싱
                reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                while ((line = reader.readLine()) != null) {
                    exchangeRateInfoList = (JSONArray) parser.parse(line);

                    // KRW -> USD에 대한 환율 정보 조회
                    for (Object o : exchangeRateInfoList) {
                        JSONObject exchangeRateInfo = (JSONObject) o;
                        if (exchangeRateInfo.get("cur_unit").equals("USD")) {

                            // 쉼표가 포함되어 String 형태로 들어오는 데이터를 Double로 파싱하기 위한 부분
                            NumberFormat format = NumberFormat.getInstance(Locale.getDefault());
                            exchangeRate = new BigDecimal(format.parse(exchangeRateInfo.get("deal_bas_r").toString()).doubleValue());
                        }
                    }
                }
                reader.close();
            }
            System.out.println(responseContent.toString());

        } catch (MalformedURLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        } catch (java.text.ParseException e) {
            throw new RuntimeException(e);
        } finally {
            connection.disconnect();
        }

//        if (exchangeRate == null) {
//            exchangeRate = defaultExchangeRate;
//        }

        //환율 정보를 반환하고 exchangeRate가 null인 경우 기본 환율 defaultRate를 반환합니다.
        return exchangeRateInfoList;
    }
}
