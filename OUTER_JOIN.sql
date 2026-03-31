-- 기존 테이블 제거 (실습 재시작 시)
DROP TABLE IF EXISTS enrollment;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS course;

-- 1. 학생 테이블
CREATE TABLE student (
    student_id   INT          PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(20)  NOT NULL,
    grade        INT          NOT NULL COMMENT '학년 (1~3)',
    phone        VARCHAR(15)
);

-- 2. 과목 테이블
CREATE TABLE course (
    course_id    INT         PRIMARY KEY AUTO_INCREMENT,
    course_name  VARCHAR(30) NOT NULL,
    teacher      VARCHAR(20) NOT NULL,
    max_students INT         DEFAULT 10
);

-- 3. 수강신청 테이블 (중간 테이블)
CREATE TABLE enrollment (
    enroll_id   INT  PRIMARY KEY AUTO_INCREMENT,
    student_id  INT  NOT NULL,
    course_id   INT  NOT NULL,
    enroll_date DATE NOT NULL,
    score       INT  COMMENT '시험 점수 (0~100)',
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id)  REFERENCES course(course_id)
);

-- ============================================
-- 테스트 데이터 INSERT
-- ============================================

-- 학생 데이터 (일부러 수강 안 한 학생 포함)
INSERT INTO student (student_name, grade, phone) VALUES
('김민준', 1, '010-1111-0001'),
('이서연', 1, '010-1111-0002'),
('박지훈', 2, '010-1111-0003'),
('최수아', 2, '010-1111-0004'),
('정태양', 3, '010-1111-0005'),
('한지민', 3, NULL);          -- 수강신청을 아직 안 한 학생

-- 과목 데이터 (일부러 수강생 없는 과목 포함)
INSERT INTO course (course_name, teacher, max_students) VALUES
('Java 기초',     '김강사', 10),
('Spring Boot',  '이강사', 8),
('React',        '박강사', 12),
('Python 데이터', '최강사', 10),  -- 아직 수강생 없는 과목
('데이터베이스',  '정강사', 15);  -- 아직 수강생 없는 과목

-- 수강신청 데이터
INSERT INTO enrollment (student_id, course_id, enroll_date, score) VALUES
(1, 1, '2025-03-02', 88),   -- 김민준 → Java 기초
(1, 2, '2025-03-02', 75),   -- 김민준 → Spring Boot
(2, 1, '2025-03-02', 92),   -- 이서연 → Java 기초
(3, 2, '2025-03-05', 81),   -- 박지훈 → Spring Boot
(3, 3, '2025-03-05', 67),   -- 박지훈 → React
(4, 1, '2025-03-07', 95),   -- 최수아 → Java 기초
(4, 3, '2025-03-07', NULL), -- 최수아 → React (아직 점수 없음)
(5, 2, '2025-03-10', 70);   -- 정태양 → Spring Boot
-- 한지민(6번)은 수강신청 없음
-- Python 데이터(4번), 데이터베이스(5번)는 수강생 없음

COMMIT;


SELECT * FROM ENROLLMENT;
SELECT * FROM STUDENT;
SELECT * FROM COURSE;


-- 1. 수강신청을 완료한 학생의 학생명, 과목명, 점수를 조회
SELECT S.STUDENT_NAME, C.COURSE_NAME, E.SCORE 
FROM ENROLLMENT E
INNER JOIN COURSE C
ON E.COURSE_ID = C.COURSE_ID 
INNER JOIN STUDENT S
ON E.STUDENT_ID = S.STUDENT_ID;

-- 2. 수강신청 여부와 상관없이 모든 학생들의 학생명, 과목명, 점수 조회
SELECT S.STUDENT_NAME, C.COURSE_NAME, E.SCORE 
FROM STUDENT S
LEFT JOIN ENROLLMENT E
ON S.STUDENT_ID = E.STUDENT_ID
LEFT JOIN COURSE C
ON E.COURSE_ID = C.COURSE_ID;

-- 3. 수강신청 하지 않은 학생의 학생명, 학년, 연락처 조회
SELECT S.STUDENT_NAME, S.GRADE, S.PHONE
FROM STUDENT S
LEFT JOIN ENROLLMENT E
ON S.STUDENT_ID = E.STUDENT_ID
WHERE E.STUDENT_ID IS NULL;