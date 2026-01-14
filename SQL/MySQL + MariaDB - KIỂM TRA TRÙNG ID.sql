
-- MySQL + MariaDB -> KIỂM TRA TRÙNG ID

	SELECT name, COUNT(id) AS cid FROM user GROUP BY name HAVING cid > 1 ORDER BY cid DESC;
