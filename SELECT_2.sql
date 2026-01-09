SELECT * FROM emp;

# EMP 테이블의 사원 중에서 급여가 300 이상 700 이하인 사원들의 사번, 사원명, 급여를 조회
SELECT EMPNO, ENAME, SAL
FROM emp
WHERE SAL BETWEEN 300 AND 700;

# EMP 테이블에서 급여가 400 이거나, 600 이거나 800 인 사원들의 모든 정보를 조회
SELECT *
FROM emp
WHERE SAL IN (400, 600, 800);

# 데이터 정렬하기
# ORDER BY 기준컬럼 정렬방법(오름차순, 내림차순)
# 오름차순 : ASC(생략가능), 내림차순 : DESC
# EMP 테이블의 모든 정보를 급여기준 내림차순 정렬
SELECT *
FROM emp
ORDER BY SAL DESC;

# 직급이 사원, 대리, 과장인 사원 중에서 급여가 200에서 700사이인 
# 사원들의 사번, 사원명, 직급, 급여를 조회
# 사원명 기준 오름차순 정렬
SELECT EMPNO, ENAME, JOB, SAL
FROM emp
WHERE JOB IN ('사원', '대리', '과장') 
  AND SAL BETWEEN 200 AND 700
ORDER BY ENAME;

# 사원들의 사번, 사원명, 부서번호, 급여를 조회한다
# 부서번호 기준 오름차순 정렬 후 급여 기준 내림차순 정렬
SELECT EMPNO, ENAME, DEPTNO, SAL
FROM emp
ORDER BY DEPTNO, SAL DESC;

# LIKE 연산자와 와일드카드
# 와일드카드 : '%', '_'

# EMP 테이블에서 사원명에 '이'가 포함된 사원의 모든 칼럼을 조회 
SELECT * 
FROM emp
WHERE ENAME LIKE '%이%';

# 중복 데이터 제거
SELECT DISTINCT DEPTNO
FROM emp;

SELECT DISTINCT JOB
FROM emp;

# DISTINCT 키워드를 한 번만 사용하면 작성한 모든 컬럼에서 중복을 제거하여 조회함
# 쿼리 작성 시 특정 컬럼만 중복을 제거하는 것은 불가능
SELECT DISTINCT DEPTNO, JOB
FROM emp;

# 예제
# 1. EMP 테이블에서 커미션이 NULL이 아닌 사원 중, 급여가 350에서 650 사이인 사원들의 사원명, 급여, 커미션을 조회하되,
# 	  쿼리문 작성 시 BETWEEN 연산자를 사용하여 작성하시오.
SELECT ENAME, SAL, COMM
FROM emp
WHERE COMM IS NOT NULL AND SAL BETWEEN 350 AND 650;

# 2. 직급이 과장, 차장, 부장인 직원의 사번, 사원명, 직급을 조회하되, 직급 기준 오름차순으로 정렬하고,
#	  쿼리 작성 시 IN 연산자를 사용하시오.
SELECT EMPNO, ENAME, JOB
FROM emp
WHERE JOB IN('과장', '차장', '부장')
ORDER BY JOB ASC;

# 3. 부서번호가 10, 20인 부서에 소속된 직원 중, 이름에 '이'가 포함된 직원의 사번, 사원명, 부서번호, 급여를 조회하되,
#    부서번호 기준 내림차순으로 정렬 후, 부서번호가 같다면 급여가 낮은 순부터 조회하는 쿼리문을 작성하시오.
SELECT EMPNO, ENAME, DEPTNO, SAL
FROM emp
WHERE DEPTNO IN (10, 20) AND ENAME LIKE '%이%'
ORDER BY DEPTNO DESC, SAL ASC;

# 4. 이름이 '기'로 끝나는 직원 중, 커미션은 NULL이고 급여는 400에서 800 사이인 직원의 모든 컬럼 정보를 조회하시오.
SELECT *
FROM emp
WHERE ENAME LIKE '%기' AND COMM IS NULL AND SAL BETWEEN 400 AND 800;

# 5. 다음과 같은 데이터가 있는 CLASS_INFO 테이블에서
#    SELECT DISTINCT CLASS_NAME, TEACHAR
#    FROM CLASS_INFO
#    WHERE CLASS_NAME = '자바반';
#    으로 작성한 쿼리 실행 결과 조회되는 튜플(Tuple)의 갯수는?
# 3개