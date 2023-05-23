show tables;

create table kn_storeReply (
	idx int auto_increment not null,
	storeIdx int not null,
	memMid varchar(20) not null,
	s_ReplyContent varchar(500) not null,
	s_ReplyRate int default 3,
	s_ReplyGood int default 0,
	s_ReplyPhoto varchar(250),
	s_ReplyDate datetime default now() not null,
	s_ReplyHostIp varchar(200) not null,
	
  primary key(idx),
  
	foreign key(storeIdx) references kn_store(idx)    /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade															 /* 원본의 변경을 따라간다. */
	on delete cascade,
	
	foreign key(memMid) references kn_member(mid)    /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade															 /* 원본의 변경을 따라간다. */
	on delete cascade

);

desc kn_storeReply;

ALTER TABLE kn_storeReply AUTO_INCREMENT = 1;