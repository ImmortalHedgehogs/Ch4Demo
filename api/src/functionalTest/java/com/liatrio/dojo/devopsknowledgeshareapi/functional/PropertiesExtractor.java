package com.liatrio.dojo.devopsknowledgeshareapi.functional;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.util.Properties;

public class PropertiesExtractor {
    private static Properties properties;
    private static String properties_file = System.getenv("spring_profiles_active") != null ? System.getenv("spring_profiles_active") : "application";
    static {
        properties = new Properties();
        URL url = new PropertiesExtractor().getClass().getClassLoader().getResource(properties_file+".properties");
        try{
            properties.load(new FileInputStream(url.getPath()));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String getProperty(String key){
        return properties.getProperty(key);
    }
}
