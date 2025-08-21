package com.LSM.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.LSM.dto.BoardDto;
import com.LSM.dto.MemberDto;

public class MemberDao {
	
	private String driverName = "com.mysql.jdbc.Driver"; //MySQL JDBC 드라이버 이름
	private String url = "jdbc:mysql://localhost:3306/jspdb"; //MySQL이 설치된 서버의 주소(ip)와 연결할 DB(스키마) 이름		
	private String username = "root";
	private String password = "12345";	
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int sqlResult =0;
	public int loginCheck(String mid, String mpw)	{ //로그인 성공 여부를 반환하는 메소드
		String sql = "SELECT * FROM members WHERE memberid=? AND memberpw=?"; //테이블,모두 일치해야함-> and
		try {
			Class.forName(driverName); //MySQL 드라이버 클래스 불러오기			
			conn = DriverManager.getConnection(url, username, password);
			//커넥션이 메모리 생성(DB와 연결 커넥션 conn 생성)
			
			pstmt = conn.prepareStatement(sql); //pstmt 객체 생성(sql 삽입)			
			pstmt.setString(1, mid);
			pstmt.setString(2, mpw);
			rs = pstmt.executeQuery(); //해당 번호글의 레코드 1개 또는 0개가 반환
			
			if(rs.next()) {
				sqlResult = 1;
			}	else {
				sqlResult = 0;
			}
			
		} catch (Exception e) {
			System.out.println("DB 에러 발생! ");
			e.printStackTrace(); //에러 내용 출력
		} finally { //에러의 발생여부와 상관 없이 Connection 닫기 실행 
			try {
				if(rs != null) { //rs가 null 이 아니면 닫기(pstmt 닫기 보다 먼저 실행)
					rs.close();
				}				
				if(pstmt != null) { //stmt가 null 이 아니면 닫기(conn 닫기 보다 먼저 실행)
					pstmt.close();
				}				
				if(conn != null) { //Connection이 null 이 아닐 때만 닫기
					conn.close();
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return sqlResult;
	}
				
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
