show tables;

create table cart (
	idx int not null auto_increment primary key, -- 장바구니번호
	mid varchar(30) not null,				 -- 주문자 아이디
	albumIdx int not null,	
	albumCnt int default 1,
	salePrice int not null,
	
	foreign key(mid) references member(mid),
	foreign key(albumIdx) references album(idx)
	on update cascade	-- 부모필드를 수정하면 함께 영향을 받는다
	on delete restrict 	-- 부모필드를 함부로 삭제할 수 없다
);

drop table cart;

insert into cart values (default, 'admin', 6, 1, 19040);

select * from cart c left outer join album a on c.albumIdx = a.idx;

