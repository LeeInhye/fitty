package com.project.fitty.chat.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.project.fitty.chat.model.vo.Chat;
import com.project.fitty.employee.model.vo.Employee;

@Repository
public class ChatDao {
	
	public ArrayList<Employee> selectChatEmpList(SqlSessionTemplate sqlSession, String searchText){
		return (ArrayList) sqlSession.selectList("chatMapper.selectChatEmpList", searchText);
	}
	
	public Chat countRoomFlag(SqlSessionTemplate sqlSession, Chat empC) {
		return sqlSession.selectOne("chatMapper.countRoomFlag", empC);
	}
	
	public Chat selectInvEmp(SqlSessionTemplate sqlSession, String invEmpNo) {
		return sqlSession.selectOne("chatMapper.selectInvEmp", invEmpNo);
	}
	
	public ArrayList<Chat> selectBubbleList(SqlSessionTemplate sqlSession, Chat c){
		return (ArrayList) sqlSession.selectList("chatMapper.selectBubbleList", c);
	}
	
	public int insertChatInviteFirst(SqlSessionTemplate sqlSession, Chat c) {
		return sqlSession.insert("chatMapper.insertChatInviteFirst", c);
	}
	
	public ArrayList<Chat> selectRoomList(SqlSessionTemplate sqlSession, String empNo){
		return (ArrayList) sqlSession.selectList("chatMapper.selectRoomList", empNo);
	}
	
	public int insertBubble(SqlSessionTemplate sqlSession, Chat c) {
		return sqlSession.insert("chatMapper.insertBubble", c);
	}

}
