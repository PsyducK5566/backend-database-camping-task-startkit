-- ████████  █████   █     █ 
--   █ █   ██    █  █     ██ 
--   █ █████ ███ ███       █ 
--   █ █   █    ██  █      █ 
--   █ █   █████ █   █     █ 
-- ===================== ====================
-- 1. 用戶資料，資料表為 USER
-- 1. 新增：新增六筆用戶資料，資料如下：
--     1. 用戶名稱為`李燕容`，Email 為`lee2000@hexschooltest.io`，Role為`USER`
--     2. 用戶名稱為`王小明`，Email 為`wXlTq@hexschooltest.io`，Role為`USER`
--     3. 用戶名稱為`肌肉棒子`，Email 為`muscle@hexschooltest.io`，Role為`USER`
--     4. 用戶名稱為`好野人`，Email 為`richman@hexschooltest.io`，Role為`USER`
--     5. 用戶名稱為`Q太郎`，Email 為`starplatinum@hexschooltest.io`，Role為`USER`
--     6. 用戶名稱為 透明人，Email 為 opacity0@hexschooltest.io，Role 為 USER
--使用 INSERT INTO 語法將資料插入到 "USER" 表中。
INSERT INTO
    "USER" (name, email, role)
VALUES
    ('李燕容', 'lee2000@hexschooltest.io', 'USER'),
    ('王小明', 'wXlTq@hexschooltest.io', 'USER'),
    ('肌肉棒子', 'muscle@hexschooltest.io', 'USER'),
    ('好野人', 'richman@hexschooltest.io', 'USER'),
    ('Q太郎', 'starplatinum@hexschooltest.io', 'USER'),
    ('透明人', 'opcatiy0@hexschooltest.io', 'USER');

-- -- 驗證插入結果 --
-- SELECT * FROM "USER";

-- 
-- 1-2 修改：用 Email 找到 李燕容、肌肉棒子、Q太郎，如果他的 Role 為 USER 將他的 Role 改為 COACH
--UPDATE "USER"：更新 "USER" 表中的資料。
--WHERE email IN (...)：篩選
--AND role = 'USER'：限制條件
--使用 LOWER() 函數將 email 欄位轉為小寫後再比較，避免大小寫問題。
UPDATE "USER"
SET role = 'COACH'
WHERE (email) IN
    ('lee2000@hexschooltest.io', 'muscle@hexschooltest.io', 'starplatinum@hexschooltest.io');

-- 檢查
-- SELECT name, email, role FROM "USER" 
-- WHERE email IN 
-- ('lee2000@hexschooltest.io', 'muscle@hexschooltest.io', 'starplatinum@hexschooltest.io');


-- 1-3 刪除：刪除USER 資料表中，用 Email 找到透明人，並刪除該筆資料
--DELETE FROM "USER"：從 "USER" 資料表中刪除資料。
DELETE FROM "USER"
WHERE
    email = 'opcatiy0@hexschooltest.io';

-- 1-4 查詢：取得USER 資料表目前所有用戶數量（提示：使用count函式）
--SELECT COUNT(*)：使用 COUNT 函數來計算 "USER" 表中的總記錄數，也就是用戶的數量。

SELECT 
    role, 
    COUNT(*) AS "用戶數量"
FROM "USER"
GROUP BY role;

-- 1-5 查詢：取得 USER 資料表所有用戶資料，並列出前 3 筆（提示：使用limit語法）
--LIMIT 3：限制查詢結果只返回前 3 筆資料。

SELECT
  id AS "用戶編號"
  ,name AS "用戶名稱"
  ,email AS "用戶信箱"
  ,role AS "用戶角色"
  ,created_at AS "建立資料時間"
  ,updated_at AS "更新資料時間"
FROM "USER"
ORDER BY created_at DESC
LIMIT 3;

--  ████████  █████   █    ████  
--    █ █   ██    █  █         █ 
--    █ █████ ███ ███       ███  
--    █ █   █    ██  █     █     
--    █ █   █████ █   █    █████ 
-- ===================== ====================
-- 2. 組合包方案 CREDIT_PACKAGE、客戶購買課程堂數 CREDIT_PURCHASE
-- 2-1. 新增：在`CREDIT_PACKAGE` 資料表新增三筆資料，資料需求如下：
-- 1. 名稱為 `7 堂組合包方案`，價格為`1,400` 元，堂數為`7`
-- 2. 名稱為`14 堂組合包方案`，價格為`2,520` 元，堂數為`14`
-- 3. 名稱為 `21 堂組合包方案`，價格為`4,800` 元，堂數為`21`
--(name, price, lessons)：指定要插入的欄位分別是 name（名稱）、price（價格）和 lessons（堂數）。
--VALUES：插入的具體資料
INSERT INTO
    "CREDIT_PACKAGE" (name, credit_amount, price)
VALUES
    ('7 堂組合包方案', 7, 1400.00),
    ('14 堂組合包方案', 14, 2520.00),
    ('21 堂組合包方案', 21, 4800.00);

-- -- 驗證插入結果--
-- SELECT * 
-- FROM "CREDIT_PACKAGE"
-- WHERE name IN ('7 堂組合包方案', '14 堂組合包方案', '21 堂組合包方案');


-- 2-2. 新增：在 `CREDIT_PURCHASE` 資料表，新增三筆資料：（請使用 name 欄位做子查詢）
-- 1. `王小明` 購買 `14 堂組合包方案`
-- 2. `王小明` 購買 `21 堂組合包方案`
-- 3. `好野人` 購買 `14 堂組合包方案`
-- 將 USER 表和 CREDIT_PACKAGE 表進行交叉連接，生成兩表的所有可能組合。

-- 王小明 購買 14 堂組合包方案
--- 新增 王小明 購買 14、21 堂數組合包
INSERT INTO "CREDIT_PURCHASE" (user_id,credit_package_id,purchased_credits,price_paid)
SELECT u.id
      ,cp.id
      ,cp.credit_amount
      ,cp.price
FROM "USER" AS "u"
CROSS JOIN "CREDIT_PACKAGE" AS "cp"
WHERE u.email = 'wXlTq@hexschooltest.io'
AND cp.name IN ('14 堂組合包方案','21 堂組合包方案');

--- 新增 好野人 購買 14 堂數組合包
INSERT INTO "CREDIT_PURCHASE" (user_id,credit_package_id,purchased_credits,price_paid)
SELECT u.id
      ,cp.id
      ,cp.credit_amount
      ,cp.price
FROM "USER" AS "u"
CROSS JOIN "CREDIT_PACKAGE" AS "cp"
WHERE u.email = 'richman@hexschooltest.io'
AND cp.name IN ('14 堂組合包方案');

---以 select 方式查詢資料
-- select 
--        u.name as "name"
--       ,cp.name as "課程組合包名稱"
--       ,cpur.purchased_credits as "購買堂數"
--       ,cpur.price_paid as "已付課程價錢"
-- FROM "CREDIT_PURCHASE" as "cpur"
--  	INNER JOIN "USER" as "u" 
-- 	 	on cpur.user_id = u.id
-- 	INNER JOIN "CREDIT_PACKAGE" as "cp" 
-- 		on cpur.credit_package_id = cp.id
-- order by name;


-- ████████  █████   █    ████   
--   █ █   ██    █  █         ██ 
--   █ █████ ███ ███       ███   
--   █ █   █    ██  █         ██ 
--   █ █   █████ █   █    ████   
-- ===================== ====================
-- 3. 教練資料 ，資料表為 COACH ,SKILL,COACH_LINK_SKILL
-- 3-1 新增：在`COACH`資料表新增三筆教練資料，資料需求如下：
-- 1. 將用戶`李燕容`新增為教練，並且年資設定為2年（提示：使用`李燕容`的email ，取得 `李燕容` 的 `id` ）
-- 2. 將用戶`肌肉棒子`新增為教練，並且年資設定為2年
-- 3. 將用戶`Q太郎`新增為教練，並且年資設定為2年
-- 不希望重複插入相同的教練記錄，在執行前檢查 COACH 表中是否已存在相同的記錄
-- SELECT * 
-- FROM "COACH"
-- WHERE user_id IN (
--     SELECT id 
--     FROM "USER"
--     WHERE email IN ('lee2000@hexschooltest.io', 'muscle@hexschooltest.io', 'starplatINum@hexschooltest.io')
-- );

--INSERT INTO "COACH"：指定要插入資料的資料表是 COACH，並且插入的欄位是 user_id (教練對應的使用者 ID) experience_years (教練的年資)。
--SELECT 子查詢：從 USER 資料表中選擇符合條件的資料，並提取 id (對應到 user_id 欄位) ，2 AS "experience_years (將年資設為 2 年，並對應到 experience_years 欄位)。
--使用 WHERE "email" IN (...) 條件，篩選出 email 使用人
INSERT INTO "COACH" (user_id,experience_years)
SELECT id,2
FROM "USER"
WHERE email IN ('lee2000@hexschooltest.io','muscle@hexschooltest.io','starplatinum@hexschooltest.io');

--查詢資料
-- select 
-- 	u.name as "教練名稱"
-- 	,c.experience_years as "年資"
-- FROM "COACH" AS "c"
-- 	INNER JOIN "USER" as "u" on c.user_id = u.id;

-- 3-2. 新增：承1，為三名教練新增專長資料至 `COACH_LINK_SKILL` ，資料需求如下：
-- 1. 所有教練都有 `重訓` 專長
-- CROSS JOIN：將 COACH 表和 SKILL 表進行交叉連接，生成所有可能的教練與技能組合。
-- INNER JOIN：將 COACH 表與 USER 表連接，通過 c.user_id = u.id 獲取教練對應的用戶信息。
-- 限制篩選條件，僅選取技能名稱為 「重訓」 的技能記錄。
INSERT INTO "COACH_LINK_SKILL" (coach_id,skill_id)
SELECT 
    c.id AS "coach_id"
    ,s.id AS "skill_id"
FROM "COACH" AS "c"
CROSS JOIN "SKILL" AS "s"
INNER JOIN "USER" AS "u" on c.user_id = u.id
WHERE s.name = '重訓';

-- 2. 教練`肌肉棒子` 需要有 `瑜伽` 專長
INSERT INTO "COACH_LINK_SKILL" (coach_id,skill_id)
SELECT 
    c.id AS "coach_id"
    ,s.id AS "skill_id"
FROM "COACH" AS "c"
CROSS JOIN "SKILL" AS "s"
INNER JOIN "USER" AS "u" on c.user_id = u.id
WHERE s.name = '瑜伽'
		AND u.email = 'muscle@hexschooltest.io';

-- 3. 教練`Q太郎` 需要有 `有氧運動` 與 `復健訓練` 專長
INSERT INTO "COACH_LINK_SKILL" (coach_id,skill_id)
SELECT 
    c.id AS "coach_id"
   ,s.id AS "skill_id"
FROM "COACH" AS "c"
CROSS JOIN "SKILL" AS "s"
INNER JOIN "USER" AS "u" on c.user_id = u.id
WHERE s.name IN ('有氧運動','復健訓練')
AND u.email = 'starplatinum@hexschooltest.io';


-- 3-3 修改：更新教練的經驗年數，資料需求如下：
-- 1. 教練`肌肉棒子` 的經驗年數為3年
--UPDATE "COACH"：指定要更新的表是 COACH 表。
-- 通過 FROM "USER" AS "u"，可以使用 USER 表來篩選出符合條件的教練。
-- COACH 表中的 user_id 與 USER 表中的 id 進行匹配，從而確保更新的是正確的教練記錄。
-- user_id = u.id：確保 COACH 表中的 user_id 與 USER 表中的 id 關聯起來。
-- SET 的作用：將符合條件的教練的 experience_years 欄位更新為 3。
UPDATE "COACH" 
SET experience_years = 3
FROM "USER" AS "u" 
WHERE user_id = u.id
AND u.email = 'muscle@hexschooltest.io';

-- 驗證更新是否成功：
-- SELECT c.id, c.user_id, c.experience_years, u.email
-- FROM "COACH" AS c
-- INNER JOIN "USER" AS u ON c.user_id = u.id
-- WHERE u.email = 'muscle@hexschooltest.io';

-- 2. 教練`Q太郎` 的經驗年數為5年
UPDATE "COACH" 
SET experience_years = 5
FROM "USER" AS "u" 
WHERE user_id = u.id
AND u.email = 'starplatinum@hexschooltest.io';

-- 3-4 刪除：新增一個專長 空中瑜伽 至 SKILL 資料表，之後刪除此專長。
--新增
INSERT INTO
    "SKILL" (name)
VALUES
    ('空中瑜伽');
--刪除
DELETE FROM
    "SKILL"
WHERE
    "name" = '空中瑜伽';

--  ████████  █████   █    █   █ 
--    █ █   ██    █  █     █   █ 
--    █ █████ ███ ███      █████ 
--    █ █   █    ██  █         █ 
--    █ █   █████ █   █        █ 
-- ===================== ==================== 
-- 4. 課程管理 COURSE 、組合包方案 CREDIT_PACKAGE
-- 4-1. 新增：在`COURSE` 新增一門課程，資料需求如下：
-- 1. 教練設定為用戶`李燕容` 
-- 2. 在課程專長 `skill_id` 上設定為「 `重訓` 」
-- 3. 在課程名稱上，設定為「`重訓基礎課`」
-- 4. 授課開始時間`start_at`設定為2024-11-25 14:00:00
-- 5. 授課結束時間`end_at`設定為2024-11-25 16:00:00
-- 6. 最大授課人數`max_participants` 設定為10
-- 7. 授課連結設定`meeting_url`為 https://test-meeting.test.io
-- INNER JOIN 的作用：
-- 連接多個表，確保插入的課程數據是基於正確的教練和技能。
-- USER 表中的 id 必須與 COACH 表中的 user_id 對應。
-- COACH 表中的 id 必須與 COACH_LINK_SKILL 表中的 coach_id 對應。
-- COACH_LINK_SKILL 表中的 skill_id 必須與 SKILL 表中的 id 對應，且技能名稱為「重訓」。
-- WHERE 條件的作用：
-- 限制條件為 USER 表中 email 為 'lee2000@hexschooltest.io' 的教練，確保新增的課程屬於該教練。
INSERT INTO "COURSE" (user_id,skill_id,name,start_at,end_at,max_participants,meeting_url)
SELECT 
	u.id
	,s.id
	,'重訓基礎課' AS "name"
	,'2024-11-25 14:00:00' AS "start_at"
	,'2024-11-25 16:00:00' AS "end_at"
	,'10' AS "max_participants"
	,'https://test-meeting.test.io' AS "meeting_url"
FROM "USER" AS "u"
INNER JOIN "COACH" AS "c"
ON u.id = c.user_id
INNER JOIN "COACH_LINK_SKILL" AS "clk"
ON c.id = clk.coach_id
INNER JOIN "SKILL" AS "s"
ON s.id = clk.skill_id AND s.name = '重訓'
WHERE u.email = 'lee2000@hexschooltest.io';

-- 查詢語句來驗證插入是否成功：
-- SELECT * 
-- FROM "COURSE"
-- WHERE user_id = (
--     SELECT id FROM "USER" WHERE email = 'lee2000@hexschooltest.io'
-- );



-- ████████  █████   █    █████ 
--   █ █   ██    █  █     █     
--   █ █████ ███ ███      ████  
--   █ █   █    ██  █         █ 
--   █ █   █████ █   █    ████  
-- ===================== ====================
-- 5. 客戶預約與授課 COURSE_BOOKING
-- 5-1. 新增：請在 `COURSE_BOOKING` 新增兩筆資料：
-- 1. 第一筆：`王小明`預約 `李燕容` 的課程
-- 1. 預約人設為`王小明`
-- 2. 預約時間`booking_at` 設為2024-11-24 16:00:00
-- 3. 狀態`status` 設定為即將授課
-- 子查詢用於從 COURSE 表中提取課程的 ID，條件是該課程是由 email 為 'lee2000@hexschooltest.io' 的教練開設的。
-- ```sql
-- SELECT c.id
-- FROM "COURSE" AS "c" 
-- INNER JOIN "USER" AS "u" 
-- ON c.user_id = u.id AND u.email = 'lee2000@hexschooltest.io'
-- ```
-- 通過 INNER JOIN 將 COURSE 表與 USER 表連接，找到由 'lee2000@hexschooltest.io' 開設的課程。
-- 外部查詢用於從 USER 表中提取 email 為 'wXlTq@hexschooltest.io' 的用戶 ID，並將其與內部子查詢的結果一起插入到 COURSE_BOOKING 表中。
-- 第一筆記錄
INSERT INTO "COURSE_BOOKING" (user_id,course_id,booking_at,status)
SELECT 
	u.id
	,(
		SELECT c.id
		FROM "COURSE" AS "c" 
    INNER JOIN "USER" AS "u" 
	 	ON c.user_id = u.id AND u.email = 'lee2000@hexschooltest.io'
	 )
	,'2024-11-24 16:00:00'
	,'即將授課'
FROM "USER" AS "u"
WHERE u.email = 'wXlTq@hexschooltest.io';

-- 2. 新增： `好野人` 預約 `李燕容` 的課程
-- 1. 預約人設為 `好野人`
-- 2. 預約時間`booking_at` 設為2024-11-24 16:00:00
-- 3. 狀態`status` 設定為即將授課
-- 第二筆記錄
INSERT INTO "COURSE_BOOKING" (user_id, course_id, booking_at, status)
SELECT 
	u.id
	,(
		SELECT c.id
		FROM "COURSE" AS "c" 
		INNER JOIN "USER" AS "u" 
		ON c.user_id = u.id AND u.email = 'lee2000@hexschooltest.io'
	 )
	,'2024-11-24 16:00:00'
	,'即將授課'
FROM "USER" AS "u"
WHERE u.email = 'richman@hexschooltest.io';

-- 5-2. 修改：`王小明`取消預約 `李燕容` 的課程，請在`COURSE_BOOKING`更新該筆預約資料：
-- 1. 取消預約時間`cancelled_at` 設為2024-11-24 17:00:00
-- 2. 狀態`status` 設定為課程已取消
-- 關鍵條件：u.id = "COURSE_BOOKING".user_id
-- 確保 USER 表中的 id 與 COURSE_BOOKING 表中的 user_id 對應。
UPDATE "COURSE_BOOKING" 
SET cancelled_at = '2024-11-24 17:00:00'
	,status = '課程已取消'
FROM "USER" AS "u"
WHERE u.id = "COURSE_BOOKING".user_id AND u.email = 'wXlTq@hexschooltest.io';

-- 5-3. 新增：`王小明`再次預約 `李燕容`   的課程，請在`COURSE_BOOKING`新增一筆資料：
-- 1. 預約人設為`王小明`
-- 2. 預約時間`booking_at` 設為2024-11-24 17:10:25
-- 3. 狀態`status` 設定為即將授課

INSERT INTO "COURSE_BOOKING" (user_id,course_id,booking_at,status)
SELECT 
	u.id
	,(
		SELECT c.id
		FROM "COURSE" AS "c" 
		INNER JOIN "USER" AS "u" 
		ON c.user_id = u.id AND u.email = 'lee2000@hexschooltest.io'
	 )
	,'2024-11-24 17:10:25'
	,'即將授課'
FROM "USER" AS "u"
WHERE u.email = 'wXlTq@hexschooltest.io';

-- 5-4. 查詢：取得王小明所有的預約紀錄，包含取消預約的紀錄
-- 使用 TO_CHAR 函數將日期（如 booking_at、join_at 等）格式化為更直觀的 YYYY-MM-DD HH24:MI:SS 格式，使查詢結果更易於閱讀。
-- 使用 COALESCE 函數處理可能為 NULL 的欄位（如 join_at、leave_at、cancelled_at 和 cancellation_reason），顯示更友好的替代內容。
SELECT 
    cb.id AS "預約課程編號",
    u.name AS "預約會員",
    c.name AS "預約課名",
    TO_CHAR(cb.booking_at, 'YYYY-MM-DD HH24:MI:SS') AS "預約時間", -- 格式化日期
    cb.status AS "授課狀態",
    COALESCE(TO_CHAR(cb.join_at, 'YYYY-MM-DD HH24:MI:SS'), '尚未授課') AS "授課時間", -- 處理 NULL 值
    COALESCE(TO_CHAR(cb.leave_at, 'YYYY-MM-DD HH24:MI:SS'), '尚未離開') AS "離開時間", -- 處理 NULL 值
    COALESCE(TO_CHAR(cb.cancelled_at, 'YYYY-MM-DD HH24:MI:SS'), '未取消') AS "取消時間", -- 處理 NULL 值
    COALESCE(cb.cancellation_reason, '無') AS "取消原因", -- 處理 NULL 值
    TO_CHAR(cb.created_at, 'YYYY-MM-DD HH24:MI:SS') AS "建立時間" -- 格式化日期
FROM 
    "COURSE_BOOKING" AS cb
INNER JOIN 
    "USER" AS u ON cb.user_id = u.id
INNER JOIN 
    "COURSE" AS c ON c.id = cb.course_id
WHERE 
    u.email = 'wXlTq@hexschooltest.io'
ORDER BY 
    cb.booking_at DESC;

-- 5-5. 修改：`王小明` 現在已經加入直播室了，請在`COURSE_BOOKING`更新該筆預約資料（請注意，不要更新到已經取消的紀錄）：
-- 1. 請在該筆預約記錄他的加入直播室時間 `join_at` 設為2024-11-25 14:01:59
-- 2. 狀態`status` 設定為上課中

UPDATE "COURSE_BOOKING" 
SET join_at = '2024-11-25 14:01:59'
	,status = '上課中'
FROM "USER" AS "u"
WHERE u.id = "COURSE_BOOKING".user_id 
	AND u.email = 'wXlTq@hexschooltest.io'
	AND booking_at = (
				SELECT MAX(booking_at) 
				FROM "COURSE_BOOKING" 
				WHERE "COURSE_BOOKING".user_id = u.id
			  );

-- 5-6. 查詢：計算用戶王小明的購買堂數，顯示須包含以下欄位： user_id , total。 (需使用到 SUM 函式與 Group By)

SELECT
    u.id AS "user_id",
    u.name AS "用戶姓名",
    u.email,
    COALESCE(SUM(cpur.purchased_credits), 0) AS "total" -- 處理無記錄情況
FROM "CREDIT_PURCHASE" AS "cpur"
 	INNER JOIN "USER" AS "u" 
	ON cpur.user_id = u.id AND u.email = 'wXlTq@hexschooltest.io'
GROUP BY u.id,u.name;

-- 5-7. 查詢：計算用戶王小明的已使用堂數，顯示須包含以下欄位： user_id , total。 (需使用到 Count 函式與 Group By)
SELECT 
    u.id AS "user_id",
     u.name AS "用戶姓名",
    COALESCE(COUNT(cb.join_at), 0) AS "total"
FROM 
    "USER" AS u
LEFT JOIN 
    "COURSE_BOOKING" AS cb
    ON cb.user_id = u.id AND cb.join_at IS NOT NULL
WHERE 
    u.email = 'wXlTq@hexschooltest.io'
GROUP BY 
    u.id
LIMIT 1;

-- 5-8. [挑戰題] 查詢：請在一次查詢中，計算用戶王小明的剩餘可用堂數，顯示須包含以下欄位： user_id , remaining_credit
-- 提示：
-- select ("CREDIT_PURCHASE".total_credit - "COURSE_BOOKING".used_credit) as remaining_credit, ...
-- from ( 用戶王小明的購買堂數 ) as "CREDIT_PURCHASE"
-- inner join ( 用戶王小明的已使用堂數) as "COURSE_BOOKING"
-- on "COURSE_BOOKING".user_id = "CREDIT_PURCHASE".user_id;
-- 從兩個子查詢（a 和 b）中提取數據，並計算剩餘可用堂數。
-- 子查詢 a（計算購買總堂數）：
-- 子查詢 b（計算已使用堂數）：

SELECT 
	a.user_id
	,a.用戶姓名
    ,a.購買總堂數
	,b.已使用堂數
	,(a.購買總堂數 - b.已使用堂數) AS "remaining_credit"  --由提示而來
FROM
(
SELECT 
   u.id AS "user_id"
   ,u.email AS "用戶信箱"
   ,u.name AS "用戶姓名"
   ,sum(cpur.purchased_credits) AS "購買總堂數"
FROM "CREDIT_PURCHASE" AS "cpur"
 	INNER JOIN "USER" AS "u" 
 	ON cpur.user_id = u.id
	GROUP BY u.id
) AS "a"
INNER JOIN 
(
	SELECT 
		u.id AS "user_id"
		,u.email AS "用戶信箱"
		,u.name AS "預約人名稱"
		,COUNT(join_at) AS "已使用堂數"
	FROM "COURSE_BOOKING" AS "cb"
		INNER JOIN "USER" AS "u"
		ON cb.user_id = u.id
	WHERE join_at is NOT NULL
	GROUP BY u.id
) AS "b"
ON a.user_id = b.user_id and a.用戶信箱 = 'wXlTq@hexschooltest.io';


-- ████████  █████   █     ███  
--   █ █   ██    █  █     █     
--   █ █████ ███ ███      ████  
--   █ █   █    ██  █     █   █ 
--   █ █   █████ █   █     ███  
-- ===================== ====================
-- 6. 後台報表
-- 6-1 查詢：查詢專長為重訓的教練，並按經驗年數排序，由資深到資淺（需使用 inner join 與 order by 語法)
-- 顯示須包含以下欄位： 教練名稱 , 經驗年數, 專長名稱
-- 使用了多個 INNER JOIN，將多個表聯結起來以獲取所需的欄位。這種方式適合數據之間關聯性強的情況，例如教練與技能的對應關係。
SELECT 
    DISTINCT u.name AS "教練名稱",
    u.role AS "用戶角色",
    s.name AS "專長名稱",
    c.experience_years AS "經驗年數"
FROM "COACH_LINK_SKILL" AS "clk"
    INNER JOIN "COACH" AS "c" 
    ON clk.coach_id = c.id
    INNER JOIN "USER" AS "u" 
    ON c.user_id = u.id
    INNER JOIN "SKILL" AS "s" 
    ON clk.skill_id = s.id
WHERE s.name = '重訓'
ORDER BY 經驗年數 DESC;

-- 6-2 查詢：查詢每種專長的教練數量，並只列出教練數量最多的專長（需使用 group by, inner join 與 order by 與 limit 語法）
-- 顯示須包含以下欄位： 專長名稱, coach_total
-- INNER JOIN 子句：將 COACH_LINK_SKILL 表與 COACH 表通過 coach_id 進行關聯，獲取教練的詳細信息。
-- INNER JOIN 子句：將 COACH_LINK_SKILL 表與 SKILL 表通過 skill_id 進行關聯，獲取技能的名稱。
-- GROUP BY 子句：根據教練總數（coach_total）降序排列，確保教練數量最多的技能排在最前面。
-- LIMIT 子句：限制返回的記錄數量為 1，僅返回教練數量最多的技能。
SELECT 
    s.name AS "專長名稱",
    COUNT(DISTINCT c.user_id) AS "coach_total"
FROM "COACH_LINK_SKILL" AS "clk"
INNER JOIN "COACH" AS "c" 
ON clk.coach_id = c.id
INNER JOIN "SKILL" AS "s" 
ON clk.skill_id = s.id
GROUP BY s.name
ORDER BY coach_total DESC
LIMIT 1;

-- 6-3. 查詢：計算 11 月份組合包方案的銷售數量
-- 顯示須包含以下欄位： 組合包方案名稱, 銷售數量
-- purchased_credits 是購買記錄表中的欄位，這裡的計算是基於記錄數量，而非直接計算購買的點數總和。如果需要計算總點數，可以改為 SUM(cpur.purchased_credits)。
-- 將 CREDIT_PURCHASE 表與 CREDIT_PACKAGE 表通過 credit_package_id 進行關聯，獲取組合包的詳細信息（如名稱）。
SELECT 
      cp.name AS "組合包方案名稱"
      ,COUNT(cpur.purchased_credits) AS "銷售數量"
FROM "CREDIT_PURCHASE" AS "cpur"
	INNER JOIN "CREDIT_PACKAGE" AS "cp" 
	ON cpur.credit_package_id = cp.id
WHERE DATE_PART('month', cpur.purchase_at) = 12  -- 現在是12月
GROUP BY cp.name;

-- 6-4. 查詢：計算 11 月份總營收（使用 purchase_at 欄位統計）
-- 顯示須包含以下欄位： 總營收
-- DATE_PART('month', purchase_at) AS "購買月份"：從購買日期（purchase_at）中提取月份，並將其命名為「購買月份」。
-- SUM(price_paid) AS "總營收"：計算該月份內所有購買記錄的支付金額總和，並命名為「總營收」。
SELECT 
DATE_PART('month', purchase_at) AS "購買月份"
      ,SUM(price_paid) AS "總營收"
FROM "CREDIT_PURCHASE"
WHERE DATE_PART('month', purchase_at) = 12 
GROUP BY DATE_PART('month', purchase_at);

-- 6-5. 查詢：計算 11 月份有預約課程的會員人數（需使用 Distinct，並用 created_at 和 status 欄位統計）
-- 顯示須包含以下欄位： 預約會員人數
-- COUNT(DISTINCT u.id) 的使用：使用 DISTINCT 確保每位會員只計算一次，即使該會員在 11 月多次預約課程，也只會計算為 1 人。
-- cb.cancelled_at IS NULL：確保只統計未取消的預約記錄。

SELECT 
    DATE_PART('month', cb.booking_at) AS "預約課程月份",
    COUNT(DISTINCT u.id) AS "預約會員人數"
FROM "COURSE_BOOKING" AS "cb"
INNER JOIN "COURSE" AS "c"
ON c.id = cb.course_id
INNER JOIN "USER" AS "u"
ON cb.user_id = u.id
WHERE cb.cancelled_at IS NULL 
  AND DATE_PART('year', cb.booking_at) = 2024
GROUP BY DATE_PART('month', cb.booking_at)
ORDER BY "預約課程月份";
