show tables;


create table kn_reservation(
	idx int auto_increment not null,
	memMid varchar(20) not null,
	storeIdx int not null,
	menuIdx int not null,
	couponIdx int,
	menuCnt int default 1 not null,
	menuPrice int not null,
	pickupDate datetime not null,
	pickupOk char(10) default 'NO',
	
	primary key(idx),
	foreign key(memMid) references kn_member(mid)    /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade															 /* 원본의 변경을 따라간다. */
	on delete cascade,
	
	foreign key(storeIdx) references kn_store(idx)    /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade															 /* 원본의 변경을 따라간다. */
	on delete cascade,
	
	foreign key(menuIdx) references kn_menu(idx)    /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade															 /* 원본의 변경을 따라간다. */
	on delete cascade,
	
	foreign key(couponIdx) references kn_coupon(idx)    /* 외래키 설정: 반드시 고유한 키여야만 한다. */
	on update cascade															 /* 원본의 변경을 따라간다. */
	on delete cascade

);
