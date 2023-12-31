show tables;

create table shopOrder (
	idx int not null auto_increment, -- 주문 고유번호
	albumIdx int not null,					 -- 주문한 앨범의 고유번호(외래키로 설정)
	mid varchar(30) not null,				 -- 주문자 아이디
	name varchar(30) not null, 	 		 -- 받는 사람 이름
	tel varchar(15) not null,				 -- 받는 사람 전화번호
	address varchar(100) not null,	 -- 받는 사람 주소
	content varchar(100) not null,	 -- 주문시 요청 내용
	payment varchar(10) not null,	   -- 결제방법
	orderDate datetime default now(),		 /* 주문 날짜 */
	reservDate datetime default now(),		 /* 주문 예약 날짜 */
	albumCnt int default 1,
	finalPrice int not null,
	primary key(idx),
	foreign key(albumIdx) references album(idx)
	on update cascade	-- 부모필드를 수정하면 함께 영향을 받는다
	on delete restrict 	-- 부모필드를 함부로 삭제할 수 없다
);

drop table shopOrder;

select * from shopOrder o left outer join album a on o.albumIdx = a.idx;
select * from shopOrder o  left outer join album a on o.albumIdx = a.idx;



