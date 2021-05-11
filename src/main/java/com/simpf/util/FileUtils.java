package com.simpf.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Log4j
public class FileUtils {
	
	// 날짜 포맷에 해당하는 폴더명을 생성하는 작업 (uploadFolder : )
	private static String getDateFolder(String uploadFolder) {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		
		String str = sdf.format(date);
		
		String osGetSepStr = str.replace("-", File.separator);
		
		makeDir(uploadFolder, osGetSepStr);
		
		// 반환값으로 년,월,일에 해당하는 폴더를 계층적으로 생성하려는 목적(File.separator)
		// 각 운영채제에서 관리하는 경로구분자로 교체한다. ("-" -> 운영채제의 경로구분자)
		return osGetSepStr;
	}
	
	// 업로드 폴더와 날짜 포맷의 폴더명을 이용하여 폴더를 생성하는 작업
	private static void makeDir(String uploadFolder, String osGetSepStr) {

		File uploadPath = new File(uploadFolder, osGetSepStr);
		
		// uploadFolderPath 폴더명이 존재하지 않으면 코드실행
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs(); // 2021/03/30
		}
	}
	
	// 이미지파일 확인 작업
	private static boolean checkImageType(File file) {
		
		String contentType;
		try {
			// 해당 파일의 MIME을 확인하고자 할 때 사용.
			contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image"); // image/jpeg, image/png, image/gif, ... 등등
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	// 썸네일 작업
	// uploadPath: 업로드폴더명 (c:\\upload\\tmp)
	// svaedPath: 날짜 폴더명 (2021\\04\\09)
	// uploadFileName: UUID를 적용한 파일명
	// multipartFile: 첨부된 파일을 참조
	private static String makeThumbNail(String uploadPath, String savedPath, String uploadFileName, MultipartFile multipartFile) throws Exception {
		
		String thumbNailName = uploadPath + savedPath + File.separator + "s_" + uploadFileName;
		
		// 1) uploadPath: C:\\upload\\tmp + 2021\03\31
		// 2) uploadFileName: "s_" + "파일명" 형태로 썸네일이미지 생성
		FileOutputStream thumbnail = new FileOutputStream(new File(thumbNailName));
		
		// 썸네일이미지 생성시키는 작업을 위한 라이브러리(pom.xml에 라이브러리 추가작업 필요)
		Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
		thumbnail.close();
		
		// "c:\\upload\\tmp\\2021\\04\\09\\s_uploadFileName.확장자"
		// "2021/04/09/s_uploadFileName.확장자" - 변환되어 출력
		return thumbNailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	/*
	 * 일반 파일의 아이콘 생성 메소드
	 * 
	 * @Params
	 * String uploadPath : 기본 파일 업로드 경로
	 * String path		 : 날짜 경로
	 * String fileName 	 : UUID_originName 
	 * 
	 * @return
	 * String : 날짜 경로 +s_ +fileName 
	 * 	ex)\\2020\\03\\13\\uuid+s_+fileName
	 * 
	 */
	private static String makeIcon(String uploadPath, String path, String fileName) throws Exception{
		String iconName = uploadPath + path + File.separator + fileName;
		
		return iconName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	// 파일 삭제 작업
	public static void deleteFile(String uploadPath, String fileName) {
		
		//  날짜경로+ UUID_fileName
		// fileName(썸네일) = 021/04/13/s_00274a24-621d-477e-84dd-ce3a3b6c9b72_서명.png
		//String front = fileName.substring(0, 11); 	// 날짜 경로
		//String end = fileName.substring(13); 		// UUID_fileName
		
		// 원본 이미지파일
		String origin = thumbToOriginName(fileName);//front + end; // 2021/04/13/00274a24-621d-477e-84dd-ce3a3b6c9b72_서명.png
		
		new File(uploadPath+origin.replace('/', File.separatorChar)).delete(); 		// 원본 파일 지우기
		new File(uploadPath+fileName.replace('/', File.separatorChar)).delete(); 	// 썸네일 파일 지우기
	}

	/*
	 * 썸네일 파일명 -> 원래 파일명
	 * ex) /2020/03/20/s_UUID파일명 -> /2020/03/20/UUID파일명
	 */
	public static String thumbToOriginName(String thumbnailName) {
		String front = thumbnailName.substring(0, 11); 	// 날짜 경로
		String end = thumbnailName.substring(13); 		// UUID_fileName
		
		return front+end;
		
	}
	
	/*
	 * 파일 업로드
	 * 
	 * @Params
	 * String uploadPath: 기본 파일 업로드 경로
	 * String originName: 원본 파일명
	 * byte[] fileData:   파일 데이터
	 * 
	 * @return
	 * String uploadFileName : 날짜 경로 + 파일 이름 (ex.\\2020\\03\\13\\uuid+fileName)
	 * 
	 */
	public static String uploadFile(String uploadPath, String originName, MultipartFile multipartFile) throws Exception {
	
		log.info(">> uploadFile()... ");
		
		// 파일 경로 설정 ex) 날짜경로
		String savedPath = getDateFolder(uploadPath); // ex.\\2020\\03\\13
		
		// 파일명 설정 ex) uuid_파일명
		UUID uuid = UUID.randomUUID(); // 파일명 중복방지 목적
		String savedName = uuid.toString() + "_" + originName;		
		// 설정한 정보로 빈 파일 생성
		File saveFile = new File(uploadPath + savedPath, savedName);
		
		multipartFile.transferTo(saveFile);
		
		String uploadFileName = "";
		
		if(checkImageType(saveFile)) {
			// 이미지파일 썸네일 작업
			uploadFileName = makeThumbNail(uploadPath, savedPath, savedName, multipartFile);
		} else {
			uploadFileName = makeIcon(uploadPath, savedPath, savedName);
		}
		
		return uploadFileName;
		
	}
	
	// 이미지를 목록에 출력하는 기능 (이미지 업로드폴더가 프로젝트 외부에 존재하기 때문에 현재 작업 필요)
	public static ResponseEntity<byte[]> getFile(String uploadPath, String fileName) {
		log.info("fileName: "+fileName);
		log.info("uploadPath: "+uploadPath);
		
		File file = new File(uploadPath+fileName);
		log.info("file: "+file);
		
		ResponseEntity<byte[]> result = null;
		
		// 패킷의 header와 body로 구성
		// @ResponseBody가 이미지소스를 가리키는 <byte[]>를 body에 저장한다.
		// 브라우저에서 서버로부터 보내온 패킷(header+body) 중 header파트에 내용을 참고하여 body를 해석한다.
		HttpHeaders header = new HttpHeaders();
		
		try {
			// 클라이언트에게 보낼 데이터의 MIME정보를 패킷의 header파트부분에 설정
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
