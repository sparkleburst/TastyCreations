package com.mgilhespy.tastycreations.services;

import com.spoonacular.DefaultApi;
import com.spoonacular.client.ApiClient;
import com.spoonacular.client.ApiException;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class ApiService {
    @Autowired
    private RestTemplate restTemplate;

    @Getter
    @Value("${api.key}")
    private String apiKey;

    public Object getRandomFoodJoke() throws ApiException {
        ApiClient apiClient = new ApiClient();
        apiClient.addDefaultHeader("x-api-key", apiKey);
        DefaultApi apiInstance = new DefaultApi(apiClient);

        Object result = null;
        try {
            result = apiInstance.getARandomFoodJoke();
            System.out.println(result);
        } catch (ApiException e) {
            System.err.println(e.getResponseBody());
            e.printStackTrace();
        }
        return result;
    }

}
