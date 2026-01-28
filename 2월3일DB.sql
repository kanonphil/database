-- 1. 회원정보를 관리하는 테이블을 생성하려고 한다. 이 테이블에서 관리하는 정보로는 회원번호, 아이디, 비밀번호, 회원이름, 나이, 이메일주소가 있다.
-- 해당 테이블명을 MY_MEMBER라고 했을 때, 테이블 생성 쿼리문을 작성하세요.
-- 회원번호는 기본키이며, 아이디, 비밀번호, 회원이름은 NULL이 들어올 수 없다. 또한 이메일은 중복되는 데이터가 들어올 수 없다.

CREATE TABLE MY_MEMBER (
	MEMBER_NUM INT PRIMARY KEY,
	MEMBER_ID VARCHAR(20) NOT NULL,
	MEMBER_PW VARCHAR(20) NOT NULL,
	MEMBER_NAME VARCHAR(20) NOT NULL,
	MEMBER_AGE INT,
	MEMBER_EMAIL VARCHAR(50) UNIQUE
);

-- 2. 위에서 생성한 MY_MEMBER에 아래 표에서 제시하는 데이터를 삽입하는 쿼리문을 작성하세요.

-- INSERT INTO MY_MEMBER (MEMBER_NUM, MEMBER_ID, MEMBER_PW, MEMBER_NAME, MEMBER_EMAIL) VALUES ();
INSERT INTO MY_MEMBER VALUES (101, 'kim', '1234', '김자바', 30, 'kim@gmail.com');
INSERT INTO MY_MEMBER VALUES (102, 'hong', '5678', '홍자바', 25, 'hong@gmail.com');

SELECT * FROM MY_MEMBER;

-- 3. 위에서 생성한 MY_MEMBER에서 회원번호가 101번인 회원의 이름을 '유관순'으로, 나이는 현재 나이에서 5를 증가시킨 값으로 수정하는 쿼리문을 작성하세요.
UPDATE MY_MEMBER
SET
	MEMBER_NAME = '유관순',
	MEMBER_AGE = MEMBER_AGE + 5
WHERE MEMBER_NUM = 101;

-- 아래 문제는 EMP, DEPT 테이블을 참고하여 푸시오.
-- 4. 급여가 500에서 3000 사이이고 커미션이 NULL이 아닌 사원의 사원번호, 사원명, 급여, 커미션을 조회하는 쿼리문을 작성하세요.
SELECT * FROM EMP;
SELECT * FROM DEPT;

SELECT EMPNO, ENAME, SAL, COMM
FROM EMP
WHERE (SAL BETWEEN 500 AND 3000) AND COMM IS NOT NULL;

-- 5. 사원들 중 이름이 '기'로 끝나거나, '김'이 들어가는 사원들의 사번, 이름, 입사일을 조회하되, 사번기준 내림차순 정렬하려 조회하는 쿼리문을 작성하세요.
SELECT EMPNO, ENAME, HIREDATE
FROM EMP 
WHERE ENAME LIKE '%기' OR ENAME LIKE '%김%'
ORDER BY EMPNO DESC;

-- 6. 사원의 사번, 이름, 부서번호, 부서명을 조회해보자. 부서명은 부서번호가 10일 때는 '인사부', 20일 때는 '영업부', 30일 때는 '개발부',
-- 	  그 외의 값은 '생산부'로 조회되어야 한다. 조인 사용하는 문제 X, CASE 사용
SELECT 
	EMPNO, 
	ENAME, 
	DEPTNO,
	CASE DEPTNO
		WHEN 10 THEN '인사부'
		WHEN 20 THEN '영업부'
		WHEN 30 THEN '개발부'
		ELSE '생산부'
	END AS DEPTNAME
FROM EMP;

-- 7. 1월에 입사한 모든 사원의 사번, 이름, 입사일, 커미션을 입사일 기준 오름차순으로 조회하는 쿼리문을 작성하세요.
-- 	  단, 커미션이 NULL일 경우 커미션은 0으로 조회되어야 한다.
SELECT 
	EMPNO, 
	ENAME, 
	HIREDATE, 
	CASE
		WHEN COMM IS NULL THEN 0 
		ELSE COMM
	END AS COMM
FROM EMP 
WHERE MONTH(HIREDATE) = 1
ORDER BY HIREDATE ASC;

-- 8. 서브쿼리를 사용하여 사장을 제외한 직원 전체의 평균 급여가 높은 직원들의 사번, 사원명, 급여, 직급을 조회하는 쿼리문을 작성해보세요.
SELECT EMPNO, ENAME, SAL, JOB
FROM EMP
WHERE JOB != '사장' AND SAL > (
	SELECT AVG(SAL)
	FROM EMP
	WHERE JOB != '사장'
);

-- 9. 서브쿼리를 사용하여 부서명이 '인사부'인 사원의 사번, 이름, 입사일, 급여, 부서번호, 부서명을 조회하는 쿼리문을 작성해보자.
SELECT 
	E.EMPNO, 
	E.ENAME, 
	E.HIREDATE, 
	E.SAL, 
	E.DEPTNO, 
	(SELECT DNAME FROM DEPT WHERE DNAME = '인사부') AS DNAME
FROM EMP E
WHERE E.DEPTNO = (
	SELECT DEPTNO
	FROM DEPT
	WHERE DNAME = '인사부'
);

-- 10. 조인을 사용하여 부서명이 '인사부'가 아니고 급여가 500이상인 사원의 사번, 이름, 입사일, 급여, 부서번호, 부서명을 조회하는 쿼리문을 작성해보자.
--	   단, 정렬은 사번 기준 내림차순으로 정렬 후 사원 이름 기준 오름차순으로 정렬한다.
SELECT
	E.EMPNO,
	E.ENAME,
	E.HIREDATE,
	E.SAL,
	E.DEPTNO,
	D.DNAME 
FROM EMP E
INNER JOIN DEPT D ON E.DEPTNO = D.DEPTNO
WHERE D.DNAME != '인사부' 
  AND E.SAL >= 500
ORDER BY E.EMPNO DESC, E.ENAME ASC;