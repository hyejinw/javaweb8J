show tables;

create table kn_menu (
	idx int auto_increment not null,
	category char(8) not null,
	menuName varchar(50) not null,
	price int not null,
	explanation varchar(100) not null,
	allergy varchar(50) not null,
	origin varchar(500) not null,
	menuPhoto varchar(250) not null,
  couponStartDate datetime default now() not null,
  menuOpen char(2) default 'OK',
  menuDel char(2) default 'NO',
  
  primary key(idx)

);

desc kn_menu;