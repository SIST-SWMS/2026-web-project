package com.sist.commons;

import java.io.InputStream;
import java.util.Properties;

public class UploadConfig {
	private static String uploadPath;

	static {
		try {
			Properties prop = new Properties();
			InputStream is = UploadConfig.class.getClassLoader().getResourceAsStream("upload.properties");
			prop.load(is);
			uploadPath = prop.getProperty("upload.path");
			is.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static String getUploadPath() {
		return uploadPath;
	}
}
