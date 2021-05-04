package com.project.service;

import java.util.List;
import java.util.Map;

import com.project.domain.Board;
import com.project.domain.MainBody;
import com.project.domain.Reply;

public interface BoardService {
	
	/* BoardDao를 이용해 게시판 테이블에서 한 페이지에 해당하는 게시 글
	 * 리스트와 페이징 처리에 필요한 데이터를 Map 객체로 반환 하는 메소드
	 **/
	public abstract Map<String, Object> boardList(
			int pageNum, String type, String keyword);

	/* BoardDao를 이용해 게시판 테이블에서
	 * 현재 페이지에 해당하는 게시 글 리스트를 읽어와 반환 하는 메소드
	 **/
	public abstract List<Board> boardList();
	
	// 메인페이지 사람 클릭
	public abstract List<MainBody> mainBody(String code);
	
	
	/* BoardDao를 이용해 게시판 테이블에서
	 * no에 해당하는 게시 글 을 읽어와 반환하는 메서드 
 	 * isCount == true 면 게시 상세보기, false 면 게시 글 수정 폼 요청임 
	 **/
	public abstract Board getBoard(int no, boolean isCount);
	
	// 게시 글 번호에 해당하는 댓글 리스트를 반환하는 메서드
	public abstract List<Reply> replyList(int no);
	
	// BoardDao를 이용해 새로운 게시 글을 추가하는 메서드
	public abstract void insertBoard(Board board);

	/* 게시 글 수정, 삭제 시 BoardDao를 이용해 비밀번호 입력을 체크하는 메서드
	 * 
	 * - 게시 글의 비밀번호가 맞으면 : true를 반환
	 * - 게시 글의 비밀번호가 맞지 않으면 : false를 반환
	 **/
	public boolean isPassCheck(int no, String pass);
	
	// BoardDao를 이용해 게시 글을 수정하는 메서드
	public abstract void updateBoard(Board board);
	
	// BoardDao를 이용해 no에 해당하는 게시 글을 삭제하는 메서드
	public abstract void deleteBoard(int no);
	
	// 추천/땡큐 정보를 업데이트하고 갱신된 추천/땡큐를 가져오는 메서드
	public Map<String, Integer> recommend(int no, String recommend);
	
	// BoardDao를 이용해 게시 글 번호에 해당하는 댓글을 등록하는 메서드
	public void addReply(Reply reply);
	
	// BoardDao를 이용해 댓글을 수정하는 메서드
	public void updateReply(Reply reply);
	
	// BoardDao를 이용해 댓글 번호에 해당하는 댓글을 삭제하는 메서드
	public void deleteReply(int no);
}
