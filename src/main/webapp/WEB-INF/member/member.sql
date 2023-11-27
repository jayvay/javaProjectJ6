show tables;

create table member(
	idx int not null auto_increment primary key,
	mid varchar(20) not null,
	pwd varchar(100) not null,
	name varchar(20) not null,
	nickName varchar(20) not null,
	birthday datetime not null,
	tel varchar(15) not null,
	email varchar(60) not null,
	address varchar(100) not null,
	gender varchar(4) not null default '선택안함',
	point int default 1000,
	level int default 1,
	visitCnt int default 0,
	startDate datetime default now(),
	lastDate datetime default now(),
	unique key(mid)
);

alter table member drop column pwdCheck;

desc member;

select * from member;

show tables;