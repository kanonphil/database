CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    category VARCHAR(20),
    price INT,
    stock_quantity INT,
    expiry_date DATE,
    supplier_id INT
);

INSERT INTO products VALUES 
(1, '초코우유', '음료', 1500, 10, '2025-12-31', 101),
(2, '삼각김밥', '간편식', 1200, 5, '2025-01-15', 102),
(3, '생수', '음료', 800, 50, NULL, 101),
(4, '컵라면', '간편식', 1800, 0, '2026-05-20', NULL),
(5, '감자칩', '과자', 2500, 15, '2026-01-10', 103),
(6, '콜라', '음료', 2000, 20, '2025-11-20', 101),
(7, '샌드위치', '간편식', 3200, 2, '2025-01-12', 102),
(8, '껌', '과자', 500, NULL, NULL, 104);

SELECT * FROM products;

# 1. 제품의 이름(NAME)을 '상품명'으로, 가격(PRICE)을 '판매가'라는 별칭으로 조회
SELECT NAME AS '상품명', PRICE AS '판매가'
FROM products;

# 2. 카테고리가 '음료'인 상품의 모든 정보를 조회
SELECT *
FROM products
WHERE CATEGORY = '음료';

# 3. 가격이 1000원 이하인 상품의 이름을 조회
SELECT NAME
FROM products
WHERE PRICE <= 1000;

# 4. 재고 수량(STOCK_QUANTITY)이 NULL인 상품의 이름을 조회하세요.
SELECT NAME
FROM products
WHERE STOCK_QUANTITY IS NULL;

# 5. ID가 1, 3, 5인 상품의 모든 정보를 조회하세요. (IN 사용)
SELECT *
FROM products
WHERE ID IN (1, 3, 5);