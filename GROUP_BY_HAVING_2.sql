-- 배달 주문 정보 테이블
CREATE TABLE ORDERS (
    ORDER_ID INT PRIMARY KEY,    -- 주문 번호
    MENU_NAME VARCHAR(50),       -- 메뉴명
    CATEGORY VARCHAR(20),        -- 카테고리 (한식, 중식, 일식, 양식)
    PRICE INT,                   -- 가격
    DELIVERY_FEE INT,            -- 배달비 (NULL은 무료 배달을 의미)
    ORDER_DATE DATE,             -- 주문일자
    SHOP_NAME VARCHAR(50)        -- 가게이름
);

INSERT INTO ORDERS VALUES 
(1, '김치찌개', '한식', 9000, 2000, '2024-01-10', '심쿵한식'),
(2, '짜장면', '중식', 7000, 1500, '2024-01-10', '용궁반점'),
(3, '초밥세트', '일식', 18000, NULL, '2024-01-11', '스시천국'),
(4, '돈가스', '일식', 11000, 3000, '2024-01-11', '돈가스명가'),
(5, '된장찌개', '한식', 8500, 2000, '2024-01-12', '심쿵한식'),
(6, '탕수육', '중식', 20000, 1500, '2024-01-12', '용궁반점'),
(7, '피자', '양식', 25000, NULL, '2024-01-13', '피자킹'),
(8, '라멘', '일식', 9500, 2500, '2024-01-13', '스시천국'),
(9, '제육볶음', '한식', 10000, 2000, '2024-01-14', '심쿵한식'),
(10, '짬뽕', '중식', 8000, 1500, '2024-01-14', '용궁반점');


#Q1. 집계 함수와 NULL 처리 (IFNULL, SUM, AVG)
#*가게별로 **'총 매출(PRICE의 합)'**과 **'평균 배달비'**를 조회하세요.
#*배달비(DELIVERY_FEE)가 NULL인 경우는 0원으로 계산하세요.
#*평균 배달비는 소수점 이하를 버리고 정수로 출력하세요 (TRUNCATE 또는 FLOOR 사용).
#*결과 컬럼명은 '가게명', '총매출', '평균배달비'로 표시하세요.
SELECT 
	O.SHOP_NAME AS '가게명', 
	SUM(O.PRICE) AS '총매출', 
	FLOOR(AVG(IFNULL(O.DELIVERY_FEE, 0))) AS '평균배달비'
FROM ORDERS O
GROUP BY O.SHOP_NAME;

#Q2. GROUP BY와 HAVING (조건부 그룹핑)
#*카테고리별로 메뉴의 개수와 가장 비싼 메뉴의 가격을 조회하세요.
#*단, 메뉴의 개수가 3개 이상인 카테고리만 출력하세요.
SELECT 
	O.CATEGORY AS '카테고리',
	COUNT(O.ORDER_ID) AS '메뉴 개수',
	MAX(O.PRICE) AS '가장 비싼 메뉴 가격'
FROM ORDERS O
GROUP BY O.CATEGORY
HAVING COUNT(O.MENU_NAME) >= 3;

#Q3. WHERE절과 집계의 조합 (날짜 함수 활용)
#*주문일자가 **'2024-01-12' 이후(해당 날짜 포함)**인 데이터들에 대해서, **카테고리별로 총 주문 금액(PRICE + 배달비)**의 합계를 구하세요.
#*배달비가 NULL이면 0으로 처리하는 것을 잊지 마세요!
#*합계 금액이 높은 순서대로 정렬하세요.
SELECT 
	O.CATEGORY AS '카테고리', 
	SUM(O.PRICE + IFNULL(O.DELIVERY_FEE, 0)) AS '총주문금액'
FROM ORDERS O
WHERE O.ORDER_DATE >= '2024-01-12'
GROUP BY O.CATEGORY 
ORDER BY 총주문금액 DESC;

#Q4. 단일행 함수와 GROUP BY (문자 함수 활용)
#*메뉴 이름에 **'찌개'**가 포함된 메뉴들의 평균 가격을 조회하세요.
#*카테고리별로 그룹핑하여 조회하세요.
SELECT 
	O.CATEGORY AS 카테고리, 
	AVG(IFNULL(O.PRICE,0)) AS 평균가격
FROM ORDERS O
WHERE O.MENU_NAME LIKE '%찌개%'
GROUP BY O.CATEGORY;

#Q1. 날짜별 통계 및 NULL 처리 (COUNT, SUM)
#주문일자별로 **'주문 건수'**와**'배달비가 있는 주문 건수'**를 조회하세요.
#배달비가 NULL이 아닌 경우에만 배달비가 있는 주문으로 카운트하세요.
#주문일자가 빠른 순서대로 정렬하세요.
#결과 컬럼명은 '주문일자', '총주문건수', '배달비있는주문'으로 표시하세요.
SELECT O.ORDER_DATE AS '주문일자', COUNT(O.ORDER_ID) AS '총주문건수', COUNT(O.DELIVERY_FEE) AS '배달비있는주문'
FROM ORDERS O
GROUP BY O.ORDER_DATE
ORDER BY O.ORDER_DATE DESC;

#Q2. 가격대별 분석 (CASE문과 GROUP BY)
#메뉴 가격을 기준으로 **'저가(10000원 미만)', '중가(10000원 이상 15000원 미만)', '고가(15000원 이상)'**로 분류하세요.
#각 가격대별로 메뉴 개수와 평균 배달비를 조회하세요.
#배달비가 NULL인 경우는 0으로 처리하고, 평균은 소수점 첫째자리까지 표시하세요 (ROUND 사용).
#결과 컬럼명은 '가격대', '메뉴개수', '평균배달비'로 표시하세요.
SELECT
	CASE
		WHEN O.PRICE < 10000 THEN '저가'
		WHEN O.PRICE < 15000 THEN '중가'
		ELSE '고가'
	END AS '가격대',
	COUNT(O.ORDER_ID) AS '메뉴개수',
	ROUND(AVG(IFNULL(O.DELIVERY_FEE, 0)), 1) AS '평균배달비'
FROM ORDERS O
GROUP BY 가격대;

#Q3. 복합 조건의 HAVING절 활용
#가게별로 '주문 건수', '최저 메뉴 가격', **'최고 메뉴 가격'**을 조회하세요.
#단, 주문 건수가 2건 이상이면서, 최고 메뉴 가격이 15000원 이상인 가게만 출력하세요.
#주문 건수가 많은 순서대로 정렬하세요.
#결과 컬럼명은 '가게명', '주문건수', '최저가격', '최고가격'으로 표시하세요.
SELECT
	O.SHOP_NAME AS '가게명',
	COUNT(O.ORDER_ID) AS '주문건수',
	MIN(O.PRICE) AS '최저가격',
	MAX(O.PRICE) AS '최고가격'
FROM ORDERS O
GROUP BY O.SHOP_NAME 
HAVING 주문건수 >= 2 AND 최고가격 >= 15000
ORDER BY 주문건수 DESC;

#Q4. 카테고리별 배달비 분석 (WHERE와 GROUP BY)
#배달비가 NULL이 아닌 주문들만 대상으로, 카테고리별 **'평균 메뉴 가격'**과 **'총 배달비'**를 조회하세요.
#평균 메뉴 가격은 소수점 이하를 버리고 정수로 출력하세요.
#총 배달비가 높은 순서대로 정렬하세요.
#결과 컬럼명은 '카테고리', '평균메뉴가격', '총배달비'로 표시하세요.
SELECT 
	O.CATEGORY AS 카테고리,
	FLOOR(AVG(O.PRICE)) AS 평균메뉴가격,
	SUM(O.DELIVERY_FEE) AS 총배달비
FROM ORDERS O
WHERE O.DELIVERY_FEE IS NOT NULL
GROUP BY O.CATEGORY
ORDER BY 총배달비 DESC;

#Q5. 문자열 함수와 집계 (LENGTH, SUBSTR)
#메뉴명의 글자 수가 4글자 이상인 메뉴들만 대상으로, 카테고리별 **'메뉴 개수'**와 **'평균 가격'**을 조회하세요.
#평균 가격은 천원 단위로 반올림하세요 (ROUND 사용).
#메뉴 개수가 많은 순서대로 정렬하세요.

#Q6. 날짜 범위와 다중 집계 함수
#2024년 1월 11일부터 13일 사이(양쪽 날짜 포함)의 주문 데이터를 대상으로, 가게별 '총 매출(PRICE + 배달비)', '평균 주문금액', **'주문 건수'**를 조회하세요.
#배달비가 NULL인 경우는 0으로 처리하세요.
#총 매출이 30000원 이상인 가게만 출력하세요.
#평균 주문금액은 소수점 둘째자리까지 표시하세요.
#총 매출이 높은 순서대로 정렬하세요.