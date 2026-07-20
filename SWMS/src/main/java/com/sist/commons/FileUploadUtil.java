package com.sist.commons;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import jakarta.servlet.http.Part;

/**
 * @param uploadPath 실제 저장 경로
 * @param part       업로드된 파일
 * @return 저장된 파일명 (파일 없으면 빈 문자열)
 */
public class FileUploadUtil {

	private static final String UPLOAD_DIR = "uploads";

	public static String upload(String uploadPath, Part part) throws Exception {
		File dir = new File(uploadPath);
		if (!dir.exists()) {
			dir.mkdirs();
		}

		if (part == null || part.getSize() == 0) {
			return "";
		}

		String originName = part.getSubmittedFileName();

		String saveName = System.currentTimeMillis() + "_" + originName;

		part.write(uploadPath + File.separator + saveName);

		return saveName;
	}

	public static List<String> uploadMultiple(String uploadPath, Collection<Part> parts) throws Exception {
		List<String> savedNames = new ArrayList<>();
		File dir = new File(uploadPath);
		if (!dir.exists()) {
			dir.mkdirs();
		}

		for (Part part : parts) {
			if (part.getSize() == 0)
				continue;
			if (part.getSubmittedFileName() == null || part.getSubmittedFileName().isEmpty())
				continue;

			String saveName = System.currentTimeMillis() + "_" + part.getSubmittedFileName();
			part.write(uploadPath + File.separator + saveName);
			savedNames.add(saveName);
		}
		return savedNames;
	}
}