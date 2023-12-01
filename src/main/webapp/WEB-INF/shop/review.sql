show tables;

create table review (
	idx int not null auto_increment, -- 댓글의 고유번호
	albumIdx int not null,					 -- 앨범(부모)의 고유번호(외래키로 설정)
	mid varchar(30) not null,				 -- 댓글 올린이의 아이디
	nickName varchar(30) not null, 	 -- 댓글 올린이의 닉네임
	wDate datetime default now(),		 -- 댓글 올린 날짜
	content text not null,					 -- 댓글 내용
	star int not null default 0,		 -- 별점
	
	primary key(idx),
	foreign key(albumIdx) references album(idx)
	on update cascade		-- 부모필드를 수정하면 함께 영향을 받는다
	on delete restrict 	-- 부모필드를 함부로 삭제할 수 없다
);

desc review;

insert into review values (default, 1, 'go123', '최고의미인고윤정b', default, '명반', 5);