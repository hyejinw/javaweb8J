show tables;

create table kn_member (
	idx int not null auto_increment,      /* 회원 고유번호 */
	mid varchar(20) not null,             /* 회원 아이디(중복 불허) */
	pwd varchar(100) not null,            /* 회원 비밀번호(SHA 256 암호화 처리) */
	salt char(8) not null,                /* 회원 비밀번호 보안용 */
	name varchar(20) not null,            /* 회원 성명 */
	email varchar(50) not null,           /* 이메일 (아이디나 비밀번호 분실 시 사용) */
	tel varchar(15) not null,             /*전화번호(010-1234-5678)*/
	birthday datetime not null,           /* 회원 생일 */
	address varchar(100),                 /* 주소(다음 API 우편번호 활용) */
	gender varchar(5) default '미선택',     /* 회원 성별 */

	memType varchar(5) default '개인',        /* 매장 or 개인 회원 */
	
	level int default 2 not null,                        /* 0:관리자, 1:매장, 2:옐로우, 3:민트, 4:퍼플 */
	levelStartDate datetime default now() not null,      /* 멤버십 시작날짜 */
	levelExpireDate datetime,                            /* 멤버십 시작날짜 */
	
	totCnt int default 0 not null,                       /* 총 방문 수 */
	todayCnt int default 0 not null,                     /* 오늘 방문 수 */  
	firstVisit datetime default now() not null,          /* 가입일 */
	lastVisit datetime default now(),                    /* 마지막 방문일 */
	memberDel char(2) default 'NO',               /* 회원 탈퇴신청여부(NO:현재 활동 중, OK: 탈퇴 신청 중) */
	            
	primary key(idx)
);

desc kn_member;
drop table kn_member;

create table kn_coupon (
	idx int not null auto_increment,         /* 쿠폰 고유번호 */
	memIdx int not null,
	coupon int not null,                     /* 쿠폰 종류 (1:도넛, 2:커피, 3:음료, 4:생일축하케이크, 5:베이커리) */ 
	couponStartDate datetime default now() not null, /* 시작 날짜 */ 
	couponExpireDate datetime not null,              /* 만료 날짜 */ 
	
	couponDel char(2) default 'NO',                  /* 사용 유무 */
	couponUsed varchar(5) default '미사용',           /* 사용 내역(만료, 사용) */
	couponUsedDate datetime default now(),           /* 사용 날짜 */
	
	primary key(idx),
	foreign key(memIdx) references kn_member(idx)    /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade															 /* 원본의 변경을 따라간다. */
	on delete cascade	
);

insert into kn_coupon values (default,1,1,default,now(),default);

ALTER TABLE kn_coupon
ADD CONSTRAINT fk_midx foreign KEY(memMid) references kn_member (mid);

desc kn_coupon;
drop table kn_coupon;