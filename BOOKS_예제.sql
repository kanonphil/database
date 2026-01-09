CREATE TABLE books (
    BOOK_ID INT PRIMARY KEY,      -- 도서 번호
    TITLE VARCHAR(100),           -- 도서 제목
    AUTHOR VARCHAR(50),           -- 저자
    PRICE INT,                    -- 가격
    STOCK INT,                    -- 재고 수량
    PUB_DATE DATE,                -- 출판일
    CATEGORY VARCHAR(20)          -- 카테고리
);

INSERT INTO books VALUES (101, '자바의 정석', '남궁성', 30000, 15, '2022-01-10', 'IT');
INSERT INTO books VALUES (102, '혼자 공부하는 파이썬', '윤인성', 22000, 5, '2021-06-15', 'IT');
INSERT INTO books VALUES (103, '어린 왕자', '생텍쥐페리', 12000, 20, '2015-03-20', '소설');
INSERT INTO books VALUES (104, 'SQL 입문', '이데이터', 25000, 0, '2023-11-01', 'IT');
INSERT INTO books VALUES (105, '맛있는 요리법', '백종원', 18000, 8, '2020-05-12', '요리');
INSERT INTO books VALUES (106, '삼국지 1', '나관중', 15000, 30, '2010-01-01', '소설');
INSERT INTO books VALUES (107, '데이터 분석 실무', '김철수', 35000, 3, '2024-01-20', 'IT');
INSERT INTO books VALUES (108, '간단한 아침 식사', '박주부', 14000, NULL, '2022-08-30', '요리');
INSERT INTO books VALUES (109, '미래의 역사', '이역사', 28000, 12, '2023-05-05', '인문');
INSERT INTO books VALUES (110, '데이터베이스 설계', '이데이터', 40000, 2, '2021-12-25', 'IT');

SELECT *
FROM books;

-- 난이도 중
-- 카테고리가 **'IT'**이거나 **'소설'**인 도서 중에서, 가격이 20,000원 이상인 도서의 제목, 저자, 가격을 조회하시오.
SELECT TITLE, AUTHOR, PRICE
FROM books
WHERE CATEGORY IN ('IT', '소설') AND PRICE >= 20000;

-- 도서 제목에 **'데이터'**라는 단어가 포함된 모든 도서의 정보를 조회하되, **가격이 높은 순(내림차순)**으로 정렬하시오.
SELECT *
FROM books
WHERE TITLE LIKE '%데이터%'
ORDER BY PRICE DESC;

-- **재고 수량(STOCK)**이 NULL이거나 0인 도서의 제목과 카테고리를 조회하시오.
SELECT TITLE, CATEGORY
FROM books
WHERE STOCK IS NULL OR STOCK = 0;

-- 2022년 1월 1일부터 2023년 12월 31일 사이에 출판된 도서의 제목과 출판일을 조회하시오. (BETWEEN 활용)
SELECT TITLE, PUB_DATE
FROM books
WHERE PUB_DATE BETWEEN '2022-01-01' AND '2023-12-31';

-- 저자의 성이 **'이'**씨인 도서들을 조회하여 제목 기준 오름차순으로 정렬하시오. 
-- (별칭을 활용하여 제목은 '도서명', 저자는 '글쓴이'로 표시)
SELECT TITLE AS '도서명', AUTHOR AS '글쓴이'
FROM books
WHERE AUTHOR LIKE '이%'
ORDER BY TITLE;


-- 난이도 상
-- 'IT' 카테고리 도서 중 가격이 30,000원 이상이거나, '소설' 카테고리 중 가격이 15,000원 이하인 도서의 모든 컬럼을 조회하시오.
SELECT *
FROM books
WHERE (CATEGORY = 'IT' AND PRICE >= 30000)
   OR (CATEGORY = '소설' AND PRICE <= 15000);

-- 재고(STOCK)가 10권 이상인 도서들 중에서, 제목이 **'혼자'**로 시작하지 않는 도서들의 정보를 조회하시오.
SELECT *
FROM books
WHERE STOCK >= 10 AND TITLE NOT LIKE '혼자%';

-- 저자가 **'이데이터'**이거나 **'김철수'**인 도서 중, 2021년 이후에 출판된 도서의 제목, 저자, 출판일을 조회하시오. 
-- (단, 출판일 기준 내림차순 정렬)
SELECT TITLE, AUTHOR, PUB_DATE
FROM books
WHERE AUTHOR IN('이데이터', '김철수')
  AND YEAR(PUB_DATE) >= 2021
ORDER BY PUB_DATE DESC;

-- 가격이 15,000원 이상 30,000원 이하인 도서 중, 재고가 NULL이 아닌 도서의 제목, 가격, 재고를 조회하시오. 
-- 이때 가격 기준 오름차순, 가격이 같다면 재고 기준 내림차순으로 정렬하시오.
SELECT TITLE, PRICE, STOCK
FROM books
WHERE PRICE BETWEEN 15000 AND 30000
  AND STOCK IS NOT NULL
ORDER BY PRICE, STOCK DESC;

-- 제목에 '공부' 또는 **'설계'**가 포함된 도서 중 카테고리가 **'IT'**인 도서의 제목, 카테고리, 가격을 조회하시오. 
-- 단, 가격에 10% 부가세를 더한 값을 **'총합계'**라는 별칭으로 계산하여 함께 보여주시오. (힌트: PRICE * 1.1)
SELECT TITLE, CATEGORY, PRICE, PRICE * 1.1 AS 총합계
FROM books
WHERE (TITLE LIKE '%공부%' OR TITLE LIKE '%설계%') AND CATEGORY = 'IT';