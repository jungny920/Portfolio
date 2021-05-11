package com.simpf.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

// hikariCP 라이브러리를 이용한 DB연동 테스트

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class DataSourceTests {
	
	@Setter(onMethod_ = {@Autowired}) // jdk 1.8은 onMethod_ 
	private DataSource dataSource;
	
	@Test
	public void testConnection() {
		try(Connection conn = dataSource.getConnection()) {
			log.info(conn);
		} catch(Exception e) {
			fail(e.getMessage());
		}
	}
}
