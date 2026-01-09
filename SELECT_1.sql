-- 이것은 주석입니다
# 이것은 주석입니다

# 데이터 조회
# SELECT 조회할컬럼 FROM 테이블명;

# EMP 테이블에서 사원들의 사원명을 조회
SELECT ENAME FROM emp;

# EMP 테이블에서 사원들의 사번, 사원명을 조회
SELECT EMPNO, ENAME FROM emp;

# EMP 테이블에서 사원들의 모든 정보를 조회
SELECT * FROM emp;

# 데이터 조회 시 무조건 컬럼만 조회할 수 있는건 아니다!
SELECT EMPNO, JOB, 3, '안녕' FROM emp;

# 별칭을 사용하여 데이터 조회
# EMP 테이블에서 사번을 조회하되, 'NUMBER'라는 별칭으로 조회
SELECT EMPNO AS NUMBER FROM emp;

# EMP 테이블에서 사원들의 사원명, 급여, 입사일을 조회
# 단, 순서대로 이름, 월급, 입사일이라는 별칭으로 조회
SELECT ENAME AS 이름, SAL AS 월급, HIREDATE AS 입사일 FROM emp;

# 조회 시 조건 추가하기
# 사원 중에서 급여가 300이상인 사원들의 사번, 사원명, 급여 정보를 조회
SELECT EMPNO, ENAME, SAL
FROM emp
WHERE SAL >= 300;

# 사원 중에서 직급이 대리인 사원의 사번, 직급, 사원명을 조회
# = 같다, !=, <> 다르다
SELECT EMPNO, JOB, ENAME
FROM emp
WHERE JOB = '대리';

# 사원 중에서 급여가 400 이상이면서 800 이하인 사원들의 모든 정보 조회
# 그리고 - AND, 이거나 - OR
SELECT *
FROM emp
WHERE SAL >= 400 AND SAL <= 800;

# 사원 중에서 사번이 1005번 이상이거나, 직급이 사원이 아닌 직원들의 사번, 사원명, 직급, 입사일을 조회
SELECT EMPNO, ENAME, JOB, HIREDATE
FROM emp
WHERE EMPNO >= 1005 OR JOB != '사원';

SELECT * FROM emp;
# 사원 중에서 커미션이 NULL인 직원들의 사원명, 커미션을 조회
# NULL 체크는 등호 기호 사용하지 않음!
# NULL이다 -> IS NULL, NULL이 아니다 -> IS NOT NULL
SELECT ENAME, COMM
FROM emp
WHERE COMM IS NULL;

# 예제
# 1. EMP 테이블에서 모든 사원의 사번, 사원명, 급여, 커미션을 조회하시오.
SELECT EMPNO, ENAME, SAL, COMM FROM emp;

# 2. EMP 테이블에서 사번이 1005번 이상인 사원들의 사번, 사원명, 직급을 조회하되, 
# 사원명은 'NAME'이라는 별칭으로 조회하시오.
SELECT EMPNO, ENAME AS NAME, JOB FROM emp;

# 3. EMP 테이블에서 직급이 대리이거나 과장인 사원들의 사원명, 직급, 급여를 조회하시오.
SELECT ENAME, JOB, SAL
FROM emp
WHERE JOB = '대리' OR JOB = '과장';

# 4. EMP 테이블에서 급여가 300 이상이면서 커미션이 300 이상인 사원들의 모든 컬럼을 조회하시오.
SELECT *
FROM emp
WHERE SAL >= 300 AND COMM >= 300;

# 5. EMP 테이블에서 급여가 900 이하이고 커미션은 NULL이 아니며 
# 직급은 대리이거나 과장인 사원들의 사원명, 직급, 급여, 커미션을 조회하시오.
SELECT ENAME, JOB, SAL, COMM
FROM emp
WHERE SAL <= 900 
  AND COMM IS NOT NULL 
  AND JOB IN('대리', '과장');
  
SELECT *
FROM emp
ORDER BY SAL ASC;

SELECT *
FROM emp
WHERE DEPTNO = 20
ORDER BY SAL DESC;

SELECT *
FROM emp
ORDER BY JOB ASC, ENAME DESC;

# 다음은 EMP테이블에서 직급이 사원인 직원을 제외한 데이터를 제외 후, 사원명, 직급, 급여, 부서번호를 조회하되, 
# 먼저 부서번호 기준 내림차순 정렬 후, 부서번호가 같다면 급여가 높은 직원부터 조회하는 쿼리이다. 
SELECT ENAME, JOB, SAL, DEPTNO
FROM emp
WHERE JOB != '사원'
ORDER BY DEPTNO DESC, SAL DESC;