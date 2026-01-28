-- 집계함수, GROUP BY, HAVING
-- 단일행함수 - 각 행마다 하나의 결과를 가지는 함수
-- 집계함수 - 함수 실행결과 무조건 하나의 행 결과를 가지는 함수
-- 집계함수의 종류 - SUM(), MIN(), MAX(), COUNT(), AVG()
-- 단일행함수 및 일반 컬럼 조회는 집계함수와 함께 사용 시 주의가 필요!!!

-- EX> 테이블에 데이터가 10개 존재 -> 함수 실행 결과 조회 데이터도 10개
SELECT COMM, IFNULL(COMM, 10)
FROM EMP;

SELECT SUM(SAL)
FROM EMP;

-- 집계함수
SELECT SUM(SAL), MIN(SAL), MAX(SAL), COUNT(SAL), AVG(SAL)
FROM EMP;

-- 예제1. 직급이 과장인 사원들의 급여의 평균을 조회
SELECT JOB, AVG(SAL)
FROM EMP 
WHERE JOB = '과장';

-- COUNT(), AVG() 집계함수 사용 시 NULL 데이터 주의!!!
-- -> 데이터의 갯수 및 평균을 구할 때는 NULL데이터는 제외하여 계산
-- COUNT() 함수는 컬럼에 존재하는 데이터의 수를 파악하는 목적이 아님
-- -> 테이블에 저장된 데이터의 갯수를 파악하는 용도
-- 결론: COUNT() 함수 안의 컬럼은 NULL 데이터가 포함된 컬럼은 사용하면 위험함
--		PK 데이터 사용하는게 안전
SELECT COUNT(EMPNO), COUNT(ENAME), COUNT(IFNULL(COMM, 0))
FROM EMP;

DESC EMP;
DESC DEPT;

-- COMM 평균 조회
-- AVG() 함수는 평균 구할 때 NULL 데이터는 갯수에서 생략 후 계산
SELECT AVG(COMM), SUM(COMM), COUNT(COMM)
FROM EMP;

-- COMM 평균을 조회하되, 모든 사원 수를 기준으로 평균을 조회하라. 소수점 둘째자리까지. 반올림
-- 방법: COMM이 NULL이면 -> 0으로 변경 후 계산
SELECT ROUND(AVG(IFNULL(COMM, 0)), 2) AS 'COMM 평균'
FROM EMP;

-- 단일행함수 및 일반 컬럼조회는 집계함수와 함께 사용 시 주의 필요!!!
-- 주의: 조회하는 모든 컬럼은 반드시 조회되는 데이터의 행 갯수가 동일해야 조회 가능.
-- -> 집계함수는 단일행 함수 및 일반 컬럼이랑 함께 조회할 수 없음

-- 예시1. 조회하는 모든 컬럼의 조회 갯수가 14로 동일하기 때문에 조회 가능
SELECT EMPNO, ENAME, SAL, COMM
FROM EMP;

-- 예시2.
SELECT MAX(SAL), MIN(SAL), SUM(SAL)
FROM EMP;

-- 예시3. 모든 사원의 급여 정보와 사원들의 급여 합을 조회하세요.
-- -> 애초에 질의문 자체가 허용되지 않는 질의
SELECT ENAME, SAL, 1 AS sort_order
FROM EMP 

UNION ALL

SELECT '전체 합계' AS ENAME, SUM(SAL) AS SAL, 2 AS sort_order
FROM EMP

ORDER BY sort_order, ENAME;

-- GROUP BY - 특정 기준에 따라 그룹을 묶어 집계 데이터를 조회할 때 사용
-- 모든 사원의 급여 평균 조회
SELECT AVG(SAL)
FROM EMP;

-- 직급별 사원의 급여 평균 조회
SELECT JOB, AVG(SAL)
FROM EMP
GROUP BY JOB;

-- 부서별 최고 급여 및 최저 급여를 조회
SELECT DEPTNO, MAX(SAL), MIN(SAL)
FROM EMP
GROUP BY DEPTNO;

-- HAVING - GROUP BY 결과 그룹핑되는 데이터를 기준으로 조건을 부여할 때 사용
-- 예시1. 부서번호가 30번이 아닌 부서에 소속된 사원들의 직급별 최고 급여와 최저 급여의 차이를 조회
SELECT JOB, (MAX(SAL) - MIN(SAL)) AS 급여차이
FROM EMP
WHERE DEPTNO != 30
GROUP BY JOB;

-- 예시2. 부서별 사원수를 조회하되, 사원수가 4명 미만인 부서는 조회 X
SELECT D.DNAME, COUNT(E.EMPNO) AS 사원수
FROM EMP E
JOIN DEPT D ON E.DEPTNO = D.DEPTNO
GROUP BY E.DEPTNO
HAVING COUNT(E.EMPNO) >= 4;

-- Q1. 사번이 짝수인 사번들에 대해 부서별로 급여의 합 및 평균을 조회
--	   단, 부서별 급여의 합이 300 이상인 데이터만 조회,
--	   부서번호 기준 내림차순으로 정렬.
SELECT E.DEPTNO AS 부서번호, SUM(E.SAL) AS 급여합계, AVG(E.SAL) AS 급여평균
FROM EMP E
WHERE MOD(E.EMPNO, 2) = 0
GROUP BY E.DEPTNO
HAVING SUM(E.SAL) >= 300
ORDER BY E.DEPTNO DESC;

-- SELECT 쿼리문의 해석 순서(컴퓨터 해석 순서)
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY