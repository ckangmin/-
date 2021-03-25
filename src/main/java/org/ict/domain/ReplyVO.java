package org.ict.domain;

import java.util.Date;

import lombok.Data;

@Data

public class ReplyVO {
	private int rno;
	private Long bno;
	private String replytext;
	private String replyer;
	
	private Date regdate;
	private Date updatadate;

}
