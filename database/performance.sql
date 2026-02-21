CREATE DATABASE university_db;
USE university_db;

-- PERFORMANCE TEST 1

DROP INDEX idx_wc_dustbin_date ON waste_collection;

EXPLAIN ANALYZE
SELECT b.building_name,
       COUNT(wc.collection_id) AS total_collections,
       SUM(wc.mass_weight_kg) AS total_waste
FROM waste_collection wc
JOIN dustbin d ON wc.dustbin_id = d.dustbin_id
JOIN building b ON d.building_id = b.building_id
WHERE wc.collection_date BETWEEN '2024-02-01' AND '2024-02-05'
GROUP BY b.building_name;

CREATE INDEX idx_wc_dustbin_date
ON waste_collection(dustbin_id, collection_date);

EXPLAIN ANALYZE
SELECT b.building_name,
       COUNT(wc.collection_id) AS total_collections,
       SUM(wc.mass_weight_kg) AS total_waste
FROM waste_collection wc
JOIN dustbin d ON wc.dustbin_id = d.dustbin_id
JOIN building b ON d.building_id = b.building_id
WHERE wc.collection_date BETWEEN '2024-02-01' AND '2024-02-05'
GROUP BY b.building_name;

-- PERFORMANCE TEST 2

DROP INDEX idx_sp_worker_date ON salary_payment;

EXPLAIN ANALYZE
SELECT w.full_name,
       sp.year,
       sp.month,
       sp.net_salary
FROM salary_payment sp
JOIN worker w ON sp.worker_id = w.worker_id
WHERE sp.worker_id = 3
AND sp.year = 2024;

CREATE INDEX idx_sp_worker_date
ON salary_payment(worker_id, year, month);

EXPLAIN ANALYZE
SELECT w.full_name,
       sp.year,
       sp.month,
       sp.net_salary
FROM salary_payment sp
JOIN worker w ON sp.worker_id = w.worker_id
WHERE sp.worker_id = 3
AND sp.year = 2024;

-- PERFORMANCE TEST 3

DROP INDEX idx_ws_worker_date ON work_schedule;

EXPLAIN ANALYZE
SELECT w.full_name,
       c.campus_name,
       ws.service_date,
       ws.shift_start_time,
       ws.shift_end_time
FROM work_schedule ws
JOIN worker w ON ws.worker_id = w.worker_id
JOIN campus c ON w.campus_id = c.campus_id
WHERE ws.service_date = '2024-02-01';

CREATE INDEX idx_ws_worker_date
ON work_schedule(worker_id, service_date);

EXPLAIN ANALYZE
SELECT w.full_name,
       c.campus_name,
       ws.service_date,
       ws.shift_start_time,
       ws.shift_end_time
FROM work_schedule ws
JOIN worker w ON ws.worker_id = w.worker_id
JOIN campus c ON w.campus_id = c.campus_id
WHERE ws.service_date = '2024-02-01';
