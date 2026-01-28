-- DISTINCT 중복제거
SELECT DISTINCT JOB FROM EMP;

-- DISTINCT 키워드는 하나만 붙이면 조회하는 모든 컬럼에 적용
-- 모든 컬럼의 값이 일치하는 행을 중복으로 처리
SELECT DISTINCT JOB, DEPTNO
FROM EMP;

-- 수치 관련 내장함수
-- CEIL(숫자): 인자의 값을 올림
SELECT CEIL(70.1);
-- FLOOR(숫자): 인자의 값을 내림
SELECT FLOOR(70.9);
-- ROUND(숫자, 소수점자리): 첫 번째 인자로 받은 수를 두 번째 인자로 받은 소수점 자리까지 반올림 한다.
SELECT ROUND(123.456);
SELECT ROUND(123.456, 1);
-- TRUNCATE(숫자, 소수점자리): 첫 번째 인자로 받은 수를 두 번째 인자로 받은 소수점 자리까지 버림한다.
SELECT TRUNCATE(123.456, 1);
SELECT TRUNCATE(123.456, 2);
-- MOD(숫자1, 숫자2): 숫자1 / 숫자2의 나머지를 구한다.
SELECT MOD(7, 3);

-- 문자 관련 내장함수
-- SUBSTR(문자, 시작위치, 문자 수), SUBSTRING(문자, 시작위치, 문자 수): 일부 문자열 추출
SELECT SUBSTR('ABCDEF', 3);
SELECT SUBSTR('ABCDEF', 3, 2);
-- UPPER(문자), LOWER(문자): 대/소문자 변경
SELECT UPPER('mariaDB');
SELECT LOWER('MARIADB');
-- LTRIM(문자), RTRIM(문자), TRIM(문자): 공백 제거
SELECT LTRIM('   DB   ');
SELECT RTRIM('   DB   ');
SELECT TRIM('   DB   ');
-- CHAR_LENGTH(문자): 공백을 포함한 문자 수, LENGTHB(문자): 문자의 바이트 수 반환, 영문/숫자 1바이트, 한글 3바이트
SELECT CHAR_LENGTH('디비'), LENGTHB('디비');
-- CONCAT(문자, 문자, 문자...): 문자 나열
SELECT CONCAT('A', 'B', 'C');
-- LPAD(문자, 글자 수, 채울 문자), RPAD(문자, 글자 수, 채울 문자)
SELECT LPAD('DB', 5, 'A');
SELECT RPAD('DB', 5, 'A');
-- REPLACE(문자, 대상문자, 교체문자): 문자 교체
SELECT REPLACE('나는 HOME에있다', 'HOME', '집');

-- 논리함수
-- IF(조건, TURE, FALSE)
SELECT IF(10>2, '참', '거짓');

-- EMP 테이블에서 사번이 짝수인 사원의 모든 정보를 조회
SELECT *
FROM EMP
WHERE MOD(EMPNO, 2) = 0;

SELECT CONCAT(ENAME, ' 직원은 급여가 ', SAL, '원 입니다') FROM EMP;


-- 예제
CREATE TABLE BOOK_STORE (
    BOOK_ID INT PRIMARY KEY,        -- 도서 번호
    TITLE VARCHAR(100),             -- 도서 제목
    AUTHOR VARCHAR(50),             -- 저자
    CATEGORY VARCHAR(20),           -- 카테고리
    PRICE DECIMAL(10, 2),           -- 가격
    STOCK INT,                      -- 재고 수량
    DISCOUNT_RATE DOUBLE            -- 할인율 (예: 0.15는 15%)
);

INSERT INTO BOOK_STORE VALUES 
(101, '  Java Programming  ', 'KIM', 'IT', 35000.55, 12, 0.1),
(102, 'Python Master', 'LEE', 'IT', 28000.40, 5, 0.2),
(103, 'SQL Beginner', 'PARK', 'DB', 22000.00, 3, NULL),
(104, 'The Great Gatsby', 'F. Scott', 'NOVEL', 15000.80, 8, 0.05),
(105, 'Data Science 101', 'CHOI', 'IT', 42000.00, 0, 0.3),
(106, 'Learning SQL', 'KIM', 'DB', 31000.25, 11, NULL);

SELECT * FROM BOOK_STORE;

-- [Part 1: 중복 제거 및 수치 함수]
-- BOOK_STORE 테이블에 있는 카테고리의 종류를 중복 없이 조회하세요.
SELECT DISTINCT CATEGORY
FROM BOOK_STORE;

-- 모든 도서의 가격(PRICE)을 소수점 첫째 자리에서 반올림하여 조회하세요.
SELECT ROUND(PRICE, 1)
FROM BOOK_STORE;

-- 도서 번호(BOOK_ID)가 홀수인 도서들의 제목과 저자를 조회하세요.
SELECT TITLE, AUTHOR
FROM BOOK_STORE 
WHERE MOD(BOOK_ID, 2) = 1;

-- 가격(PRICE)을 소수점 이하를 버리고(FLOOR) '정수가격'이라는 별칭으로 조회하세요.
SELECT FLOOR(PRICE) AS '정수가격'
FROM BOOK_STORE;

-- [Part 2: 문자 함수]
-- 도서 제목(TITLE)의 좌우 공백을 제거하고, 모두 대문자로 변환하여 조회하세요.
SELECT UPPER(TRIM(TITLE))
FROM BOOK_STORE;

-- 저자(AUTHOR)의 이름이 3글자 이상이라면, 앞의 2글자만 추출하여 조회하세요.
SELECT SUBSTR(AUTHOR, 1, 2)
FROM BOOK_STORE
WHERE LENGTH(AUTHOR) >= 3;

-- 제목(TITLE)에 있는 'SQL'이라는 단어를 'DATABASE'로 교체하여 조회하세요.
SELECT REPLACE(TITLE, 'SQL', 'DATABASE')
FROM BOOK_STORE;

-- 저자(AUTHOR) 이름의 오른쪽에 '*'를 채워 총 5글자로 만드세요. (예: KIM -> KIM**)
SELECT RPAD(AUTHOR, 5, '*')
FROM BOOK_STORE;

-- [Part 3: 논리 및 NULL 처리]
-- DISCOUNT_RATE(할인율)가 NULL인 경우 0으로 표시하고, '할인율'이라는 별칭으로 조회하세요.
SELECT 
	UPPER(TRIM(TITLE)) AS 제목,
	PRICE AS 가격,
	IFNULL(DISCOUNT_RATE, 0) AS 할인율
FROM BOOK_STORE;

-- IF 함수를 사용하여 재고(STOCK)가 0이면 '품절', 아니면 **'판매중'**이라고 표시되는 컬럼을 추가하세요.
SELECT 
	UPPER(TRIM(TITLE)) AS TITLE,
	IF(STOCK = 0, '품절', '판매중')
FROM BOOK_STORE;

-- CASE 문을 사용하여 카테고리별 위치를 출력하세요.
-- IT -> 1층 로비
-- DB -> 2층 사무실
-- NOVEL -> 3층 서고
-- 그 외 -> 기타
SELECT
	UPPER(TRIM(TITLE)),
	CATEGORY,
	CASE CATEGORY
		WHEN 'IT' THEN '1층 로비'
		WHEN 'DB' THEN '2층 사무실'
		WHEN 'NOVEL' THEN '3층 서고'
		ELSE '기타'
	END AS 위치
FROM BOOK_STORE;

