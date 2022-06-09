create table product(
	idx int not null auto_increment,  /* 고유번호 */
	brandName varchar(30) not null,				/* 브랜드번호 */
	name varchar(30) not null,				/* 상품이름 */
	category varchar(30) not null,		/* 카테고리 */
	rPrice int not null,								/* 원가 */
	sPrice int not null,								/* 상품가격 */
	sell int default 0,								/* 판매수량 */
	sellStop int default 0,						/* 판매유무  0: 판매 , 1: 중단 */
	wishList int default 0,						/* 위시리스트 */
	fName varchar(200) not null,			/* 상품사진(원본) */
	fSName varchar(200) not null,			/* 상품사진(서버) */
	fContent varchar(200) not null,		/* 상품설명(원본) */
	fSContent varchar(200) not null,	/* 상품설명(서버) */
	primary key (idx),									/* primary key */
	foreign key (brandName) references prdBrand(brandName)
);
create table orderList(
	idx int not null auto_increment,
	mid varchar(30) not null,
	sellName varchar(30) not null,
	prdBrand varchar(30) not null,
	prdName varchar(30) not null,
	prdOption varchar(100) not null,
	pickName varchar(30) not null,
	pickTel varchar(50) not null,
	pickAddress varchar(150) not null,
	pickPost varchar(100) not null,
	pickMemo varchar(50) ,
	totPrice int not null,
	sellDate datetime default now(),
	orderSw int default 0,
	primary key (idx)
);
create table orderInfo(
	idx int not null auto_increment,
	ordIdx int not null,
	
);


use javagreen_pjh;

show tables;

create table prdBrand(
	idx int not null auto_increment,  /* 고유번호 */
	brandName varchar(30) not null UNIQUE,				/* 브랜드이름 */
	brandFName varchar(200) not null,
	brandFSName varchar(200) not null,
	primary key (idx)
);


create table prdOption(
	idx int not null auto_increment,
	prdIdx int not null,
	color varchar(50) not null,
	size varchar(50) not null,
	count int not null,
	primary key (idx),									/* primary key */
	foreign key (prdIdx) references product(idx)
);

select * from product;
select * from prdOption where prdIdx = 1 order by color, size desc;
select * from prdOption where prdIdx = 1 group by color;

select * from prdOption where prdIdx = 1;
update
select * from product p , prdOption o where p.idx = o.prdIdx and p.idx = 1 group by color;
select o.size as size from product p , prdOption o where p.idx = o.prdIdx and p.idx = 1 group by size;
select prdOption.size from prdOption where prdIdx = 1 group by prdOption.size;
select * from prdOption where prdIdx = 1 group by size;
INSERT INTO prdoption VALUES(DEFAULT,(SELECT idx from product where name = '아디다스 반팔티'),'black','XL',1000);
drop table orderList;
drop table product;
drop table prdBrand;

/* 주문내역과 상품사진 출력 */
select *,(select fSName from product where name = orderlist.prdName) as fSName from orderlist where mid = ?;