show tables;

create table kn_store (
	idx int not null auto_increment,      /* 매장 고유번호 */
	memIdx int not null,                  /* 매장회원 고유번호(외래키) */
	storeName varchar(30) not null,            /* 매장명 */
	storeTel varchar(15) not null,             /* 매장 전화번호(010-1234-5678)*/
	storeAddress varchar(50) not null,         /* 주소 */  
	storePhoto varchar(250) default '입력 전',   /* 매장 사진 */  
	location varchar(2000) default '입력 전',      /* 지도 */  
	opHour varchar(15) default '09:00 ~ 21:00',/* 영업시간 */  
	storeMenu varchar(5000) default '입력 전',    /* 가능 메뉴 */  
	storeRate int default 0 not null,        /* 수정 중 유무: on일 때 관리자 따로 처리 불가능 */  
	storeModify char(4) default 'ON',        /* 수정 중 유무: on일 때 관리자 따로 처리 불가능 */  
	storeOpen char(2) default 'NO',            /* 공개 유무 */  
	storeDel char(2) default 'NO',             /* 삭제 여부 */  
	            
	primary key(idx),
	foreign key(memIdx) references kn_member(idx)    /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade															 /* 원본의 변경을 따라간다. */
	on delete cascade		
);

desc kn_store; 
drop table kn_store;

ALTER TABLE kn_store AUTO_INCREMENT = 1;