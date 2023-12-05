show tables;

create table cart (
	idx int not null auto_increment primary key, -- 장바구니번호
	mid varchar(30) not null,				-- 주문자 아이디
	albumIdx int not null,					-- 앨범 고유번호
	albumCnt int default 1,					-- 앨범 개수
	salePrice int not null,					-- 앨범 가격
	
	foreign key(albumIdx) references album(idx)
	on update cascade	-- 부모필드를 수정하면 함께 영향을 받는다
	on delete restrict 	-- 부모필드를 함부로 삭제할 수 없다
);

drop table cart;

insert into cart values (default, 'admin', 6, 1, 19040);

select * from cart c left outer join album a on c.albumIdx = a.idx where mid = 'admin';

select *,count(*) as totAlbumCnt from cart where albumIdx = 53 group by albumIdx , mid;


select * from cart c left outer join album a on c.albumIdx = a.idx where mid = 'admin';

select *,count(*) as totAlbumCnt from cart where albumIdx = 53 group by albumIdx , mid;

select *,(select count(*) from cart where albumIdx = 53 and mid = 'admin') as totAlbumCnt from album a, cart c where a.idx=53 and c.mid = 'admin' and c.albumIdx=53 group by c.albumIdx;




