show tables;

create table album (
	idx int not null auto_increment primary key,
	alName varchar(50) not null,
	singer varchar(50) not null,
	price int not null,
	part varchar(20) not null,
	relDate datetime default now(),
	disc varchar(100),
	content text,
	saleCnt int default 0,
	photo varchar(100) default 'noImage.jpg',
	unique key(alName)
);

alter table album add column photo varchar(100) default 'noImage.jpg';

desc album;

insert into album values (default, '아이유 - 리메이크 앨범 꽃갈피', '아이유', 13000, '가요/발라드', '2014-05-19', '01 나의 옛날이야기/02 꽃/03 
삐에로는 우릴 보고 웃지/04 사랑이 지나가면/05 너의 의미 (Feat. 김창완)/06 여름밤의 꿈/07 꿍따리 샤바라 (Feat. 클론)', 
'시간이 흘러도 바래지 않는, 소박하고 아름다운 추억의 흔적
아이유(IU) 스페셜 리메이크 미니앨범 꽃갈피
오래된 서재에서 먼지를 털어내고 꺼내든 책 한 권. 한 장씩 책장을 넘기다 책갈피처럼 끼워진 빛 바랜 네 잎 클로버나 꽃잎들을 발견할 때가 있다. 오래 전 누군가가 마음을 담아 선물했을 소박하고 아름다운 흔적. 또 그 페이지마다 밑줄이 그어져있는 기억할 만한 글귀들. 이러한 ‘꽃갈피’는 요즘은 점점 잊혀져 가고 있는 예전 아날로그 세대의 감성과 낭만을 보여주는 청년 문화의 상징 중 하나일지도 모른다.
시간이 흘러도 바래지 않는, 한 번쯤 다시 꺼내어보고 싶은 세대를 관통하는 추억의 흔적. 아이유(IU)의 이번 스페셜 미니앨범은 이처럼 이전 세대의 음악 속에서 ‘꽃갈피’들을 발견해내고, 그것을 다시 자신만의 감성과 목소리로 되새겨 현 세대의 청자들에게 선물한다는 의미를 담고 있다. 이번 앨범의 수록곡들은 평소 옛 노래들을 즐겨 듣는 아이유가 이 곡들을 처음 발견했을 때 생각지도 못했던 설레는 선물을 받았던 것 같은 느낌을 되새겨 직접 선곡하였고, 최대한 원곡의 감성을 살리면서도 본인만의 색깔을 절충하여 녹여내는 방향으로 리메이크 작업을 진행했다.
꽃갈피는 그 동안 방송에서 선보인 통기타 커버 등을 통해 수 차례 화제가 됐던 아이유의 아날로그 감성을 좋아해온 많은 팬들에 대한 선물이자, 자극적인 음악들 가운데 오랜 시간을 두고 감상하며 명곡의 의미를 다시 한 번 되새겨볼 수 있는 기회를 제공하는 음반이 될 것이다.'
, default);

update album set photo = 'https://image.yes24.com/momo/TopCate362/MidCate001/36105438.jpg' where idx = 1;