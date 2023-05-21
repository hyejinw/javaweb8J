show tables;

create table kn_menuReply (
	idx int auto_increment not null,
	menuIdx int not null,
	memMid varchar(20) not null,
	m_ReplyContent varchar(500) not null,
	m_ReplyRate int default 3,
	m_ReplyGood int default 0,
	m_ReplyPhoto varchar(250),
	m_ReplyDate datetime default now() not null,
	m_ReplyHostIp varchar(200) not null,
	m_ReplyDel char(2) default 'NO',
	
  
  primary key(idx),
  
	foreign key(menuIdx) references kn_menu(idx)    /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade															 /* 원본의 변경을 따라간다. */
	on delete cascade,
	
	foreign key(memMid) references kn_member(mid)    /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade															 /* 원본의 변경을 따라간다. */
	on delete cascade

);

desc kn_menuReply;

ALTER TABLE kn_menu AUTO_INCREMENT = 1;