package com.project.fitty.alert.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.project.fitty.employee.model.vo.Employee;

public class EcoHandler extends TextWebSocketHandler {
	
	List<WebSocketSession> sessions = new ArrayList<>();
	Map<String, WebSocketSession> userSessions = new HashMap<>();
	

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception{
		
		//System.out.println("웹소켓 연결된 클라이언트 session : " + session);
		//System.out.println("ㄴ 이 사람의 정보 : " + session.getAttributes());
		sessions.add(session);
		String senderId = getId(session);
		userSessions.put(senderId, session);
		
		System.out.println("웹소켓 연결된 사람들 :" + userSessions);
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception{
		
		System.out.println("발신 클라이언트 session : " + session);
		System.out.println("ㄴ 이 사람이 보낸 내용 : " + message);
		//System.out.println("실제 메세지 : " + message.getPayload());
		
		// 보낸사람 session id 알아와서 접속한 모든 사람에게 다시 클라이언트쪽으로 메세지 보냄 
		//String senderId = getId(session);
//		for(WebSocketSession sess : sessions) {
//			sess.sendMessage(new TextMessage(senderId + ":" + message.getPayload()));
//		}
		
		//protocol: cmd, 댓글작성자, 게시글작성자, bno (machine, user2(관리자), user1(트레이너), 점검번호)
		String[] strs = message.getPayload().split(",");
		
		if(strs != null && strs.length == 4) {
			String cmd = strs[0];
			String admin = strs[1];
			String trainer = strs[2];
			String ckNo = strs[3];
			
			WebSocketSession trainerSession = userSessions.get(trainer); // 점검을 작성한 트레이너가 세션에 있는지 뽑는거 있으면 값이 담기고 없으면 null
			
			
			// 현재 admin은 사번이기 때문에 이름을 보내주려면 서비스에 요청해서 DB에서 조회해와야함
			//String adminName = aService.selectAdminMc(admin);
			
			if(cmd.equals("machine") && trainerSession != null) {
				TextMessage tmpMsg = new TextMessage("<a href='ckList.mc'>"+ admin + "님이 " + ckNo + "번 기구점검을 처리완료 하였습니다.</a>");
				trainerSession.sendMessage(tmpMsg);
				
				System.out.println(">>>>>>클라이언트로 메세지 보내기 성공 ");
			}
			
			// if (cmd.equals("")
			
			// if (cmd.equals("")
			
			
		}
	}

	private String getId(WebSocketSession session) {
		
		Map<String, Object> httpSession = session.getAttributes(); // 웹소켓 session에 있던것들을 Map 객체 httpSession에 담음
		Employee loginUser = (Employee)httpSession.get("loginUser");
		
		if(loginUser == null) {
			return session.getId();
		}else {
			return loginUser.getEmpNo();
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception{
		
		//System.out.println("웹소켓 나간 클라이언트 session : " + session);
	}
	
	
}