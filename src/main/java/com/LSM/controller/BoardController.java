package com.LSM.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.LSM.dao.BoardDao;
import com.LSM.dao.MemberDao;
import com.LSM.dto.BoardDto;
import com.LSM.dto.BoardMemberDto;


@WebServlet("*.do")
public class BoardController extends HttpServlet {
	
    public BoardController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		actionDo(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		actionDo(request, response);
	}
	
	private void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String uri = request.getRequestURI();
		//System.out.println("uri : " + uri);
		String conPath = request.getContextPath();
		//System.out.println("conPath : " + conPath);
		String comm = uri.substring(conPath.length()); //최종 요청 값
		System.out.println("comm : " + comm);
		
		String viewPage = null;
		BoardDao boardDao = new BoardDao();
		MemberDao memberDao = new MemberDao();
		List<BoardDto> bDtos = new ArrayList<BoardDto>();
		List<BoardMemberDto> bmDtos = new ArrayList<BoardMemberDto>();
		HttpSession session = null;
		
		if(comm.equals("/list.do")) { //게시판 모든 글 목록 보기 요청
			String searchType = request.getParameter("searchType");
			String searchKeyword = request.getParameter("searchKeyword");
			
			if(searchType != null && searchKeyword != null && !searchKeyword.strip().isEmpty()) { //유저가 검색 결과 리스트를 원하는 경우
				bDtos = boardDao.searchBoardList(searchKeyword, searchType);
			} else { //list.do->모든 게시판 글 리스트를 원하는 경우
				bDtos = boardDao.boardList(); //게시판 모든 글이 포함된 ArrayList 반환
			}
			
			System.out.println("searchType : " + searchType);
			System.out.println("searchkeyword : " + searchKeyword);
			
			
			request.setAttribute("bDtos", bDtos);
			viewPage = "boardList.jsp";
			
		}else if(comm.equals("/write.do")) { //글쓰기
			session = request.getSession();
			String sid = (String)session.getAttribute("sessionId");
			if(sid != null ) {
				viewPage = "write.jsp";
			} else {
				response.sendRedirect("login.do?msg=2");
						return;
			}

			viewPage = "write.jsp";
	
		} else if(comm.equals("/edit.do")) { //글수정
			session = request.getSession();
			String sid = (String) session.getAttribute("sessionId");
			
			
			String bnum = request.getParameter("bnum");
			BoardDto boardDto = boardDao.contentView(bnum);
			
			if(boardDto.getMemberid().equals(sid)) {
				request.setAttribute("boardDto", boardDto);
				viewPage = "edit.jsp";
			}else {
				response.sendRedirect("edit.jsp?error=1");
				return;
			}
			
			
			
		}else if(comm.equals("/editOk.do")) { //글수정후 글리스트로 이동
			request.setCharacterEncoding("utf-8");
			String bnum = request.getParameter("bnum");//유저가 입력한 글 제목
			String btitle =	request.getParameter("title");//유저가 입력한 글 제목
			String memberid = request.getParameter("author");//유저가 입력한 글 쓴이
			String bcontent = request.getParameter("content");//유저가 입력한 글 내용
			boardDao.boardUpdate(bnum, btitle, bcontent); //글 수정 메소드 호출
				viewPage = "list.do";
				
		} else if(comm.equals("/delete.do")) { //글 삭제후 목록
			String bnum =request.getParameter("bnum");
			BoardDto boardDto = boardDao.contentView(bnum);
			session = request.getSession();
			String sid = (String) session.getAttribute("sessionId");
			
			if(boardDto.getMemberid().equals(sid)) {
				boardDao.boardDelete(bnum);
				request.setAttribute("boardDelete", boardDao);
				viewPage = "list.do";
			} else {
				response.sendRedirect("edit.jsp?error=1");
				return;
			}		
		} else if(comm.equals("/content.do")) { //글 목록에서 선택된 글 내용이 보여지는 페이지로 이동
			String bnum = request.getParameter("bnum"); //유저가 선택한 글의 번호
			boardDao.updateBhit(bnum); //조회수 증가
			BoardDto boardDto = boardDao.contentView(bnum); //boardDto 반환(유저가 선택한 글번호에 해당하는 dto반환)
		
			if(boardDto == null) { //해당 글이 존재하지 않음
				response.sendRedirect("post.jsp?msg=1");
				return;
			} 
			request.setAttribute("boardDto", boardDto);

			viewPage = "post.jsp";
			
		
		} else if(comm.equals("/writeOk.do")) { //글목록에서 선택된 글 내용 보여지는 
			request.setCharacterEncoding("utf-8");
		String btitle =	request.getParameter("title");//유저가 입력한 글 제목
		String memberid = request.getParameter("author");//유저가 입력한 글 쓴이
		String bcontent = request.getParameter("content");//유저가 입력한 글 내용
		
		boardDao.boardWrite(btitle, bcontent, memberid); //새 글이 DB입력
		response.sendRedirect("list.do"); //포워딩을 하지 않고 강제로 list.do로 이동
		return; //프로그램의 진행 멈춤
	} else if(comm.equals("/login.do")) { //글목록에서 선택된 글 내용 보여지는 
		viewPage = "login.jsp";

	} else if(comm.equals("/loginOk.do")) { //글목록에서 선택된 글 내용 보여지는 
		viewPage = "list.do";
		request.setCharacterEncoding("utf-8");
		String loginId = request.getParameter("userid");
		String loginPw = request.getParameter("password");
		int loginFlag = memberDao.loginCheck(loginId, loginPw); //성공이면 1, 실패면0반환
		if(loginFlag ==1) {
			session = request.getSession();
			session.setAttribute("sessionId", loginId);
		} else {
			response.sendRedirect("login.do?msg=1");
			return;
		}

		viewPage = "list.do";
		
	}	else {
		viewPage = "index.jsp";
	}
	
		//RequestDispatcher dispacher = request.getRequestDispatcher(conPath); 
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);	
	
		//conPath자리에는 실제 실행시킬 jsp파일 이름, boardList.jsp에게 request객체를 전달해라 그후 boardList.jsp로 이동해라
		dispatcher.forward(request, response);
		
	
	}
}