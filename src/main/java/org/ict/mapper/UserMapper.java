package org.ict.mapper;

import org.ict.domain.LoginDTO;
import org.ict.domain.UserVO;

public interface UserMapper {
	public UserVO login(LoginDTO dto) throws Exception;
	public void join(UserVO vo);
	
	public int midcheck(String uid);
}
