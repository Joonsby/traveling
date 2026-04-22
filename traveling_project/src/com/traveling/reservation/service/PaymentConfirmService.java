package com.traveling.reservation.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

public class PaymentConfirmService {
	private static final String SECRET_KEY = "test_sk_Poxy1XQL8R1Kp2547w69r7nO5Wml"; 
	
	public static String confirm(String paymentKey, String orderId, String amount) throws Exception {
		String encodedAuth = Base64.getEncoder().encodeToString((SECRET_KEY + ":").getBytes(StandardCharsets.UTF_8));
		
		URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
		
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		
	    conn.setRequestMethod("POST");
	    conn.setRequestProperty("Authorization", "Basic " + encodedAuth);
	    conn.setRequestProperty("Content-Type", "application/json");
	    conn.setDoOutput(true);
		
	    String body = "{"
	            + "\"paymentKey\":\"" + paymentKey + "\","
	            + "\"orderId\":\"" + orderId + "\","
	            + "\"amount\":" + amount
	            + "}";
        
        OutputStream os = conn.getOutputStream();
        os.write(body.getBytes());
        os.close();
        
        BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream())
            );
        
        StringBuilder response = new StringBuilder();
        String line;

        while ((line = br.readLine()) != null) {
            response.append(line);
        }

        return response.toString();
	}
}
