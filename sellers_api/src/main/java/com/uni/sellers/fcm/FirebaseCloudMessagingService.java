package com.uni.sellers.fcm;


import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;


//최영완
@Service("firebaseCloudMessagingService")
public class FirebaseCloudMessagingService {
	
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	@Value("#{config['ip.addr']}")
	private String addr;
	
	@Value("#{config['fcm.webApiKey']}")
	private String webApiKey;
	
	@Value("#{config['fcm.serverKey']}")
	private String serverKey;
	
	@SuppressWarnings("unchecked")
	public void sendToFcm(Map<String, Object> map, List<Map<String, Object>> list) throws IOException {
		//List<Map<String,Object>> tokenList = fcmService.loadFCMInfoList(vo); 
        final String apiKey = "AAAAyVDh3nI:APA91bF7mC8KDdwzT9ovZhIJwoxZl8c7OETGJavQXw3U2z38-HvbmcbsncnA7UpeTcYorn8gvOPy-cSj4vCrtfYAocTS6xPYaUh9Wxzl5ZDIO1JBUW8BGtXUy7u9Jy-1vXcJZd4nr4Q9";
        URL url = new URL("https://fcm.googleapis.com/fcm/send");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        

        JSONArray jArray = new JSONArray();
        for(int i=0; i<list.size(); i++){
        	jArray.add(i, list.get(i).get("DEVICE_KEY"));
        }

        String title = (String) map.get("title");
        String message = (String) map.get("body");
        String Url = (String) map.get("pushUrl");
        // FMC 메시지 생성 start
        JSONObject root = new JSONObject();
        JSONObject data = new JSONObject();
        data.put("title", title);
        data.put("body", message);
        data.put("Url", Url);
        data.put("click_action", "OPEN_ACTIVITY"); // click_action 추가!
        //root.put("to", "/topics/ALL"); //단일 대상(토큰)이나 그룹(토픽)으로 푸시전송
        root.put("registration_ids", jArray); //복수 대상(토큰) 푸시전송
        root.put("data", data);
        
        conn.setDoOutput(true);
        conn.setDoInput(true);
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Authorization", "key=" + apiKey);
        
        // FMC 메시지 생성 end
        OutputStream os = conn.getOutputStream();
        os.write(root.toString().getBytes("UTF-8"));
        os.flush();
        //os.close();
        conn.getResponseCode();

        /*
        int responseCode = conn.getResponseCode();
        System.out.println("\nSending 'POST' request to URL : " + url);
        System.out.println("Post parameters : " + root.toString());
        System.out.println("Response Code : " + responseCode);
        
      
        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        StringBuffer response = new StringBuffer();

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        	}
        in.close();
        // print result
        System.out.println(response.toString());
        */
        
        //return "jsonView";
	}
}
