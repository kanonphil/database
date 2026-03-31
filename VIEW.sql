-- VIEW - 가상테이블. 많이 씀. 신입들이 VIEW를 많이 활용
-- INSERT, DELETE, UPDATE 조건에 따라 가능은 하나, 거의 안씀
-- VIEW 사용 이유
--  1. 민감한 데이터를 감추기 위해
--  2. 복잡한 조회쿼리(조인)를 편하게 사용하기 위해

SELECT * FROM EMP;


-- 주의 - V_EMP라는 테이블이 만들어지고, 여기에 조회한 데이터가 삽입되는구나... <- X
CREATE OR REPLACE VIEW V_EMP
AS
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE JOB != '사장';

SELECT * FROM V_EMP;


-- 사원번호, 사원명, 부서번호, 부서명 조회
SELECT EMPNO, ENAME, E.DEPTNO, DNAME
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

-- 이미 조인된 데이터를 VIEW로 생성
CREATE OR REPLACE VIEW V_EMP_INFO
AS
SELECT EMPNO, ENAME, JOB, HIREDATE, SAL, COMM, E.DEPTNO, DNAME, LOC
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT * FROM V_EMP_INFO;

-- 기능1. 급여가 300 이상인 사원들의 사원번호, 사원명, 부서번호, 부서명 조회
SELECT EMPNO, ENAME, DEPTNO, DNAME
FROM V_EMP_INFO 
WHERE SAL >= 300;