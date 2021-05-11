package com.simpf.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

/**
 * 스프링기반 본작업 들어가기 전 jdbc OracleDriver를 이용한 연동테스트
 */

@Log4j
public class JDBCTests {
	
	static {
		try {
			// DriverManager 객체 생성, 메모리상에 로딩
			Class.forName("oracle.jdbc.OracleDriver");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		String uid = "pf_sim";
		String pwd = "pf_sim";
		
		try(Connection conn = DriverManager.getConnection(url, uid, pwd)) {
			log.info(conn);
		} catch(Exception e) {
			fail(e.getMessage());
		}
	}
}
