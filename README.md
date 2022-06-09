# MUSINSA
- JSP 쇼핑몰 사이트 만들어보기
- 개인프로젝트
# 개발일정
- 2022.0518 ~ 2022.0603
# 개발환경
- 개발언어 : JAVA ver1.8
- 프로그램 : Eclipse 2021.12
- 서버 : Apache Tomcat 9.0
- 데이터베이스 : MySQL 5.7 , HeidiSQL9.5
- 기타 : JSP , HTML5 , JavaScript , BootStrap4,
       Ajax, Jquery , COS , JSTL 
# DB 설계
![image](https://user-images.githubusercontent.com/102267923/172859685-65b907c0-c551-4950-8b58-978494417daf.png)
# 화면구현

<h3>메인화면</h3>

![image](https://user-images.githubusercontent.com/102267923/172863315-6ddc55ea-1aa2-4e47-9551-67e4e3b29e52.png)
- 홈버튼
- 로그인 / 회원가입
- 상품판매
- 통합검색

<hr/>

<h3>로그인 화면</h3>

![image](https://user-images.githubusercontent.com/102267923/172863970-72df1bf4-9d34-43cb-91b5-ac51b7ae8586.png)
- AJAX 로 회원데이터 유무확인
- 체크유무 쿠키값저장
- 로그인버튼
- 아이디/비밀번호찾기/회원가입 버튼

<hr/>


<h3>아이디/비밀번호찾기</h3>

![image](https://user-images.githubusercontent.com/102267923/172863724-52188f6b-8de9-4855-8ed1-f9248421c072.png)
- 하나의 JSP파일로 get값 의 변경에따라 두가지 방식으로 아이디찾기

![image](https://user-images.githubusercontent.com/102267923/172876459-225527a6-80f3-4b6e-91dc-34bfe274ac41.png)
- 아이디찾기후 비밀번호찾기시 입력란에 자동추가

<hr/>

<h3>회원가입</h3>

![image](https://user-images.githubusercontent.com/102267923/172865135-dfe27251-7695-406e-a240-9d2c8e32f19a.png)
- 모든값 유효성 검사
- 중복확인은 AJAX 처리로 값 확인
- API를 활용하여 주소검색

<hr/>

<h3>마이페이지</h3>

![image](https://user-images.githubusercontent.com/102267923/172864966-f205b327-aeef-4ac1-ab99-bb133e98306c.png)
- 등급 / 포인트 / 누적금액확인 가능
- 주문내역 확인가능
- 관리자접속시에만 관리자메뉴 노출

<hr/>

<h3>개인정보변경</h3>

![image](https://user-images.githubusercontent.com/102267923/172865550-dbd2a17f-2241-4f82-8232-64f1bfb889d0.png)

- 개인정보변경 / 비밀번호 변경 / 관리자로그인 / 회원탈퇴(회원일때 노출) 모두 하나의 JSP로 이동 get값으로 구분후 이동
===개인정보변경===
- 개인정보변경시 아이디값 고정
- 기존정보를 불러와 기본값으로 입력
- 값이 한번이라도 변경시 인증필수
===비밀번호변경===
- 비밀번호 유효성검사적용(한글,영대소문,숫자포함 8~16글자 ,특수문자한개이상필수)
- 두값이 다를시 안내후 재입력 유도

<hr/>

<h3>관리자페이지</h3>

![image](https://user-images.githubusercontent.com/102267923/172866404-fe0c716f-8b6d-40ef-8cee-a006e05c4160.png)
- 메인화면에 회원수 / 상품개수 / (없음) / 주문수량 확인가능
- 상품관리
- 주문관리

<hr/>

<h3>상품관리</h3>

![image](https://user-images.githubusercontent.com/102267923/172866607-d2bd6340-7c6f-4b4f-996e-5d75146b8597.png)
- SELECT BOX 에서 분류 선택후 검색가능
- 상품리스트에 상품이름 클릭시 상품상세옵션 보기
- 수정/삭제로 재고변경가능
- 상품등록 가능

<hr/>

<h3>상품등록</h3>

![image](https://user-images.githubusercontent.com/102267923/172867035-19c1563e-e2f6-4c93-9f34-a4581551149d.png)
- 브랜드 / 상품 / 상세옵션 등록가능
- 모든값 NULL 허용안함
- 값이 입력안되었을시 안내후 재입력 유도

<hr/>

<h3>상품등록 2</h3>

![image](https://user-images.githubusercontent.com/102267923/172867376-24cd18d5-421d-4e13-9358-e988e7273fef.png)
- 브랜드를 등록해야 상품등록가능
- 상품을등록해야 옵션등록가능
- 브랜드 / 상품 등록과정에서 유효값만 선택가능

<hr/>

<h3>주문관리</h3>

![image](https://user-images.githubusercontent.com/102267923/172867474-efcf1d5d-3645-442d-acba-bf8666ec20a2.png)
- 고객들이 주문한 제품 / 상세옵션 / 수량 / 수령자정보 등 확인가능
- 주문상태 변경가능 및 현재상태 확인가능

<hr/>

<h3>상품페이지</h3>

![image](https://user-images.githubusercontent.com/102267923/172867587-fcbf25bb-180e-4760-adcc-84d312728a7d.png)
- 등록된 상품을 확인가능 
- 페이징처리 
- 좌측 카테고리 클릭시 분류하여 노출

<hr/>

<h3>구메페이지</h3>

![image](https://user-images.githubusercontent.com/102267923/172867760-d883513f-ef07-4912-ba0b-eac8950e1986.png)
- 상품구매전 상품정보와 옵션선택가능
- 상품등록시 태그등록시 우측정보에 버튼형식으로 노출 
- 태그버튼 클릭시 태그이름으로 검색기능
- 색상과 사이즈 선택가능 
- 중복선택시 안내후 박스실행취소

<hr/>

<h3>결제페이지/구매완료페이지</h3>

![image](https://user-images.githubusercontent.com/102267923/172867878-d81a057e-17d0-4b27-8544-577ca6206d46.png)
- 주문자 정보를 불러와 값 입력
- 수령자 이름 /주소 변경가능
- 결제 완료시 안내후 쇼핑하기 혹은 마이페이지이동하여 주문정보 확인가능
<hr/>

# 느낀점 
- 처음 웹 프로젝트를 경험한거라 시행착오를 겪어 경험이 많이 되었습니다
- 2주라는 기간동안 작업을하였는데 부족한점이 많았습니다
- 관리자와 구매자 입장을 서로 고려하며 작업하였지만 관리자쪽을 신경을더쓴것같습니다
- 시간관계상 장바구니를 구현하지못하여 여러상품을 구매하지 못하는것이 아쉽습니다
- 추후 SpringFrameWork 에서는 더많은것을 구현하고싶습니다

# 추가한다면 ? 

관리자페이지 매출현황

- 배송완료후 원가와 판매가를 계산하여 일/월/년 별 매출을 하고싶었습니다

관리자페이지 회원관리

- 최근등록한 회원 및 탈퇴신청한 회원 처리 등 회원관리페이지를 만들고싶었습니다

장바구니 페이지

- 장바구니를 등록하여 여러상품을 한꺼번에 살수있는 기능을 추가하고싶었습니다

상품후기 및 문의 기능

- 상품을 구매한 고객에 한에서 후기를 작성할수있고 모든고객을 대상으로 문의기능을 추가하하여 관리하고싶었습니다
