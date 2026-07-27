# 📊 데이터베이스(DB) 테이블 명세서

### 1. MEMBER (회원)
| 컬럼명(영문) | 컬럼명(한글) | 데이터형 | 데이터 크기 | N-N | DEFAULT | FK | PK |
|---|---|---|---|---|---|---|---|
| id | 아이디 | VARCHAR2 | 20 | NN | - | - | O |
| pwd | 비밀번호 | VARCHAR2 | 20 | NN | - | - | - |
| name | 이름 | VARCHAR2 | 20 | NN | - | - | - |
| nickname | 닉네임 | VARCHAR2 | 20 | NN | - | - | - |
| phone | 전화번호 | VARCHAR2 | 20 | NN | - | - | - |
| zipcode | 우편번호 | VARCHAR2 | 10 | NN | - | - | - |
| address | 주소 | VARCHAR2 | 200 | NN | - | - | - |
| address_detail | 상세주소 | VARCHAR2 | 200 | - | - | - | - |
| auth | 권한(1:사용자, 2:관리자) | NUMBER | | NN | 1 | | |
| created_at | 생성일 | DATE | | NN | SYSDATE | | |

<br>

### 2. goods (상품)
| 컬럼명(영문) | 컬럼명(한글) | 데이터형 | 데이터 크기 | N-N | DEFAULT | FK | PK |
|---|---|---|---|---|---|---|---|
| goods_no | 상품 식별번호 | NUMBER | | NN | - | - | O |
| goods_code | 모델코드(그냥 표시용, 식별용X) | VARCHAR2 | 50 | NN | - | - | - |
| goods_name | 상품명 | VARCHAR2 | 100 | NN | - | - | - |
| goods_price | 상품 가격 | VARCHAR2 | 50 | NN | - | - | - |
| goods_discount | 상품 할인률 | NUMBER | | - | 0(숫자) | - | - |
| poster_url | 상품 대표이미지 | VARCHAR2 | 260 | NN | - | - | - |
| subposter_url | 상품 상세이미지 | VARCHAR2 | 260 | - | - | - | - |
| brand_no | 브랜드 식별 번호 | NUMBER | | NN | - | O | - |
| category_no | 카테고리 식별 번호 | NUMBER | | NN | - | O | - |
| hit | 조회수 | NUMBER | | NN | 0(숫자) | - | - |
| created_at | 등록일 | DATE | | NN | SYSDATE | - | - |

<br>

### 3. category (카테고리)
| 컬럼명(영문) | 컬럼명(한글) | 데이터형 | 데이터 크기 | N-N | DEFAULT | FK | PK |
|---|---|---|---|---|---|---|---|
| category_no | 카테고리 식별 번호 | NUMBER | | NN | | | O |
| category_name | 카테고리 이름 | VARCHAR2 | 50 | NN | - | - | - |

<br>

### 4. brand (브랜드)
| 컬럼명(영문) | 컬럼명(한글) | 데이터형 | 데이터 크기 | N-N | DEFAULT | FK | PK |
|---|---|---|---|---|---|---|---|
| brand_no | 브랜드 식별 번호 | NUMBER | | NN | | | O |
| brand_name | 브랜드 이름 | VARCHAR2 | 50 | NN | - | - | - |

<br>

### 5. cart (장바구니)
| 컬럼명(영문) | 컬럼명(한글) | 데이터형 | 데이터 크기 | N-N | DEFAULT | FK | PK | UQ |
|---|---|---|---|---|---|---|---|---|
| cart_no | 장바구니번호 | NUMBER | | NN | | | O | |
| id | 구매자 ID | VARCHAR2 | 20 | NN | | O - 회원 | | O |
| stock_no | 재고식별번호 | NUMBER | | NN | | O - 재고 | | O |
| sizes | 사이즈 | NUMBER | | NN | | | | |
| quantity | 수량 | NUMBER | | NN | | | | |
| created_at | 등록일 | DATE | | NN | SYSDATE | | | |

<br>

### 6. orders (주문)
| 컬럼명(영문) | 컬럼명(한글) | 데이터형 | 데이터 크기 | N-N | DEFAULT | FK | PK |
|---|---|---|---|---|---|---|---|
| order_no | 주문번호 | NUMBER | | NN | | | O |
| id | 구매자ID | VARCHAR2 | 20 | NN | | O - 회원 | |
| order_date | 주문일시 | DATE | | NN | SYSDATE | | |
| delivery_name | 배송정보_이름 | VARCHAR2 | 50 | NN | | | |
| delivery_phone | 배송정보_연락처 | VARCHAR2 | 20 | NN | | | |
| delivery_zipcode | 배송정보_우편번호 | VARCHAR2 | 10 | NN | | | |
| delivery_addr | 배송정보_주소 | VARCHAR2 | 200 | NN | | | |
| delivery_addr_detail | 배송정보_상세주소 | VARCHAR2 | 200 | | | | |
| delivery_msg | 배송정보_배송요청사항 | VARCHAR2 | 600 | | | | |
| total_price | 총결제금액 | NUMBER | | NN | | | |
| delivery_status | 배송상태 | VARCHAR2 | 50 | NN | '결제완료' | | |

<br>

### 7. order_detail (주문상세)
| 컬럼명(영문) | 컬럼명(한글) | 데이터형 | 데이터 크기 | N-N | DEFAULT | FK | PK |
|---|---|---|---|---|---|---|---|
| order_detail_no | 주문상세번호 | NUMBER | | NN | | | O |
| order_no | 주문번호 | NUMBER | | NN | | O - 주문 | |
| goods_no | 상품번호 | NUMBER | | NN | | O - 상품 | |
| sizes | 사이즈 | NUMBER | | NN | | | |
| quantity | 수량 | NUMBER | | NN | | | |
| price | 결제금액 | NUMBER | | NN | | | |
| status | 주문상태 | VARCHAR2 | 50 | | | | |

<br>

### 8. goods_like (좋아요)
| 컬럼명(영문) | 컬럼명(한글) | 데이터형 | 데이터 크기 | N-N | DEFAULT | FK | PK |
|---|---|---|---|---|---|---|---|
| like_no | 좋아요번호 | NUMBER | | NN | - | - | O |
| id | 회원 아이디 | VARCHAR2 | 20 | NN | - | O - 회원 | - |
| goods_no | 상품식별번호 | NUMBER | | NN | - | O - 상품 | - |
| created_at | 좋아요생성일 | DATE | | NN | SYSDATE | - | - |

<br>

### 9. review (리뷰)
| 컬럼명(영문) | 컬럼명(한글) | 데이터형 | 데이터 크기 | N-N | DEFAULT | FK | PK |
|---|---|---|---|---|---|---|---|
| review_no | 리뷰번호 | NUMBER | | NN | | | O |
| goods_no | 상품식별번호 | NUMBER | | NN | | O | |
| subject | 리뷰제목 | VARCHAR2 | 50 | NN | | | |
| content | 리뷰내용 | CLOB | | NN | | | |
| id | 회원 아이디 | VARCHAR2 | 20 | NN | | O | |
| hit | 별점 | CHAR | 1 | NN | | | |
| like_count | 좋아요수 | NUMBER | | | 0 | | |
| created_at | 리뷰작성일 | DATE | | NN | SYSDATE | | |

<br>

### 10. review_like (리뷰 좋아요)
| 컬럼명(영문) | 컬럼명(한글) | 데이터형 | 데이터 크기 | N-N | DEFAULT | FK | PK |
|---|---|---|---|---|---|---|---|
| no | 고유번호 | NUMBER | | NN | | | O |
| review_no | 리뷰 식별번호 | NUMBER | | NN | | O | |
| id | 회원 아이디 | VARCHAR2 | 20 | NN | | O | |
| created_at | 좋아요생성일 | DATE | | NN | SYSDATE | | |

<br>

### 11. qna (문의)
| 컬럼명(영문) | 컬럼명(한글) | 데이터형 | 데이터 크기 | N-N | DEFAULT | FK | PK |
|---|---|---|---|---|---|---|---|
| qna_no | 식별번호 | NUMBER | | NN | | | O |
| parent_no | 답변번호 | NUMBER | | | | | |
| type | 문의유형(상품, 배송, 환불) | VARCHAR2 | 10 | | | | |
| subject | 문의제목 | VARCHAR2 | 50 | NN | | | |
| content | 문의내용 | CLOB | | NN | | | |
| status | 답변상태('답변대기', '답변완료') | VARCHAR2 | 10 | NN | '답변대기' | | |
| id | 회원 아이디 | VARCHAR2 | 20 | NN | | O | |
| is_secret | 공개/비공개 여부 | VARCHAR2 | 10 | NN | '공개' | | |
| created_at | 문의작성날짜 | DATE | | NN | SYSDATE | | |

<br>

### 12. stock_history (입/출고 내역)
| 컬럼명(영문) | 컬럼명(한글) | 데이터형 | 데이터 크기 | N-N | DEFAULT | FK | PK |
|---|---|---|---|---|---|---|---|
| no | 식별번호 | NUMBER | | NN | - | - | O |
| stock_no | 재고식별번호 | NUMBER | | NN | | O | |
| order_no | 주문식별번호 | NUMBER | | | | | |
| size | 사이즈 | NUMBER | | NN | | | |
| quantity | 수량 | NUMBER | | NN | | | |
| chk | 입고(IN)/출고(OUT) | VARCHAR2 | 10 | NN | | | |
| inout_at | 입/출고일 | DATE | | NN | | | |
| created_at | 등록일 | DATE | | NN | SYSDATE | | |
| created_by | 등록자 | NUMBER | | NN | | O | |

<br>

### 13. stock (상품 재고)
| 컬럼명(영문) | 컬럼명(한글) | 데이터형 | 데이터 크기 | N-N | DEFAULT | FK | PK |
|---|---|---|---|---|---|---|---|
| no | 식별번호 | NUMBER | | NN | - | - | O |
| goods_no | 상품 식별번호 | NUMBER | | NN | | O | |
| goods_size | 사이즈 | NUMBER | | NN | | | |
| quantity | 수량 | NUMBER | | NN | | | |
| created_at | 등록일 | DATE | | NN | SYSDATE | | |
| updated_at | 수정일 | DATE | | NN | SYSDATE | | |
