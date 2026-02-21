USE university_db;

-- UNIVERSITY

INSERT INTO university (name, main_campus_location, contact_email)
VALUES ('National University of Environmental Sciences', 'Lahore', 'info@nues.edu.pk');


-- CAMPUSES

INSERT INTO campus (university_id, campus_code, campus_name, address, contact_number)
VALUES 
(1, 'CAMP-LHR', 'Lahore Campus', 'Johar Town Lahore', '042-1111111'),
(1, 'CAMP-ISB', 'Islamabad Campus', 'H-12 Islamabad', '051-2222222'),
(1, 'CAMP-KHI', 'Karachi Campus', 'Clifton Karachi', '021-3333333');


-- BUILDINGS (9 total)

INSERT INTO building (campus_id, building_code, building_name, building_type) VALUES
(1,'B-A1','Academic Block A','Academic'),
(1,'B-A2','Administration Block','Administrative'),
(1,'B-H1','Hostel Block','Residential'),
(2,'B-A1','Academic Block North','Academic'),
(2,'B-L1','Library Complex','Academic'),
(2,'B-H1','Hostel Block ISB','Residential'),
(3,'B-A1','Academic Block Karachi','Academic'),
(3,'B-A2','Science Wing','Academic'),
(3,'B-H1','Karachi Hostel','Residential');


-- INVENTORY (15 items)

INSERT INTO inventory 
(campus_id,item_code,item_name,item_category,quantity,reorder_level,unit_price,supplier_name)
VALUES
(1,'INV-GLV','Cleaning Gloves','Safety',200,50,25.00,'Pak Safety Supplies'),
(1,'INV-BAG','Garbage Bags Large','Consumable',500,100,15.00,'Green Plastics'),
(1,'INV-MOP','Floor Mop','Equipment',50,10,450.00,'CleanTech'),
(2,'INV-GLV','Cleaning Gloves','Safety',180,40,25.00,'Pak Safety Supplies'),
(2,'INV-BAG','Garbage Bags Large','Consumable',400,100,15.00,'Green Plastics'),
(2,'INV-TROL','Waste Trolley','Equipment',20,5,5500.00,'Urban Equipments'),
(3,'INV-GLV','Cleaning Gloves','Safety',150,30,25.00,'Pak Safety Supplies'),
(3,'INV-BAG','Garbage Bags Large','Consumable',350,80,15.00,'Green Plastics'),
(3,'INV-MASK','Face Masks','Safety',600,150,5.00,'HealthLine'),
(1,'INV-DIS','Disinfectant Liquid','Chemical',100,20,800.00,'Hygiene Co'),
(2,'INV-DIS','Disinfectant Liquid','Chemical',90,20,800.00,'Hygiene Co'),
(3,'INV-DIS','Disinfectant Liquid','Chemical',95,20,800.00,'Hygiene Co'),
(1,'INV-BROOM','Broom','Equipment',70,15,250.00,'CleanTech'),
(2,'INV-BROOM','Broom','Equipment',60,15,250.00,'CleanTech'),
(3,'INV-BROOM','Broom','Equipment',65,15,250.00,'CleanTech');

-- WORKERS (20 workers)

INSERT INTO worker 
(campus_id,worker_code,full_name,cnic,phone,address,hire_date,role,salary_type,base_salary)
VALUES
(1,'W-LHR-01','Ali Raza','35201-1234567-1','03001234567','Lahore','2022-01-01','Manager','Monthly',80000),
(1,'W-LHR-02','Ahmed Khan','35201-1234567-2','03001234568','Lahore','2022-02-01','Admin','Monthly',60000),
(1,'W-LHR-03','Usman Tariq','35201-1234567-3','03001234569','Lahore','2023-01-01','Cleaner','Monthly',30000),
(1,'W-LHR-04','Bilal Ahmed','35201-1234567-4','03001234560','Lahore','2023-03-01','Cleaner','Daily',1200),
(1,'W-LHR-05','Hassan Ali','35201-1234567-5','03001234561','Lahore','2023-05-01','Cleaner','Monthly',28000),

(2,'W-ISB-01','Saad Malik','61101-1234567-1','03101234567','Islamabad','2022-01-10','Manager','Monthly',85000),
(2,'W-ISB-02','Zain Iqbal','61101-1234567-2','03101234568','Islamabad','2022-02-10','Admin','Monthly',62000),
(2,'W-ISB-03','Hamza Shah','61101-1234567-3','03101234569','Islamabad','2023-01-10','Cleaner','Monthly',31000),
(2,'W-ISB-04','Tariq Mehmood','61101-1234567-4','03101234560','Islamabad','2023-04-01','Cleaner','Daily',1300),
(2,'W-ISB-05','Kashif Ali','61101-1234567-5','03101234561','Islamabad','2023-05-01','Cleaner','Monthly',29000),

(3,'W-KHI-01','Farhan Siddiqui','42101-1234567-1','03201234567','Karachi','2022-01-15','Manager','Monthly',82000),
(3,'W-KHI-02','Imran Baig','42101-1234567-2','03201234568','Karachi','2022-03-01','Admin','Monthly',61000),
(3,'W-KHI-03','Naveed Khan','42101-1234567-3','03201234569','Karachi','2023-01-15','Cleaner','Monthly',30000),
(3,'W-KHI-04','Adeel Sheikh','42101-1234567-4','03201234560','Karachi','2023-04-01','Cleaner','Daily',1250),
(3,'W-KHI-05','Owais Ahmed','42101-1234567-5','03201234561','Karachi','2023-05-01','Cleaner','Monthly',28000),

(1,'W-LHR-06','Rizwan Ali','35201-1234567-6','03001234562','Lahore','2023-06-01','Cleaner','Monthly',28000),
(2,'W-ISB-06','Umar Farooq','61101-1234567-6','03101234562','Islamabad','2023-06-01','Cleaner','Monthly',28000),
(3,'W-KHI-06','Danish Khan','42101-1234567-6','03201234562','Karachi','2023-06-01','Cleaner','Monthly',28000),
(1,'W-LHR-07','Faizan Malik','35201-1234567-7','03001234563','Lahore','2023-07-01','Cleaner','Monthly',28000),
(2,'W-ISB-07','Shahbaz Ahmed','61101-1234567-7','03101234563','Islamabad','2023-07-01','Cleaner','Monthly',28000);


-- DUSTBINS (25 bins)

INSERT INTO dustbin 
(building_id,dustbin_code,floor_no,location_desc,bin_type,capacity_liters,current_fill_level)
VALUES
(1,'DB-A1-01',1,'Near Entrance','General',120,60),
(1,'DB-A1-02',2,'Corridor','Recyclable',100,45),
(2,'DB-ADM-01',1,'Admin Hall','General',150,70),
(3,'DB-H1-01',1,'Hostel Lobby','General',200,80),
(4,'DB-A1-01',1,'Main Gate','General',120,55),
(5,'DB-L1-01',2,'Library Floor 2','Paper',100,40),
(6,'DB-H1-01',1,'ISB Hostel','General',180,75),
(7,'DB-A1-01',1,'Karachi Gate','General',120,65),
(8,'DB-A2-01',2,'Science Lab','Chemical',100,50),
(9,'DB-H1-01',1,'KHI Hostel','General',200,85),

(1,'DB-A1-03',3,'Top Floor','General',100,30),
(2,'DB-ADM-02',2,'Admin Office','General',120,60),
(3,'DB-H1-02',2,'Hostel Floor 2','General',150,70),
(4,'DB-A1-02',2,'North Wing','Recyclable',100,35),
(5,'DB-L1-02',3,'Reading Hall','Paper',100,25),
(6,'DB-H1-02',2,'ISB Hostel 2','General',150,50),
(7,'DB-A1-02',2,'Karachi Wing','General',100,45),
(8,'DB-A2-02',3,'Chem Lab 2','Chemical',100,55),
(9,'DB-H1-02',2,'KHI Hostel 2','General',150,60),
(1,'DB-A1-04',4,'Seminar Hall','General',100,20),
(2,'DB-ADM-03',3,'Admin Floor 3','General',100,50),
(3,'DB-H1-03',3,'Hostel Floor 3','General',120,65),
(4,'DB-A1-03',3,'North Block 3','General',100,40),
(5,'DB-L1-03',1,'Entrance','Paper',100,35),
(6,'DB-H1-03',3,'ISB Hostel 3','General',150,55);


-- WORK SCHEDULE (20 records)

INSERT INTO work_schedule
(worker_id, building_id, service_date, shift_start_time, shift_end_time)
VALUES
(3,1,'2024-02-01','08:00:00','16:00:00'),
(4,2,'2024-02-01','09:00:00','17:00:00'),
(5,3,'2024-02-01','08:00:00','16:00:00'),
(8,4,'2024-02-01','08:00:00','16:00:00'),
(9,5,'2024-02-01','09:00:00','17:00:00'),
(10,6,'2024-02-01','08:00:00','16:00:00'),
(13,7,'2024-02-01','08:00:00','16:00:00'),
(14,8,'2024-02-01','09:00:00','17:00:00'),
(15,9,'2024-02-01','08:00:00','16:00:00'),
(16,1,'2024-02-02','08:00:00','16:00:00'),
(17,4,'2024-02-02','08:00:00','16:00:00'),
(18,7,'2024-02-02','08:00:00','16:00:00'),
(19,1,'2024-02-03','08:00:00','16:00:00'),
(20,4,'2024-02-03','08:00:00','16:00:00'),
(3,2,'2024-02-04','08:00:00','16:00:00'),
(8,5,'2024-02-04','08:00:00','16:00:00'),
(13,8,'2024-02-04','08:00:00','16:00:00'),
(5,3,'2024-02-05','08:00:00','16:00:00'),
(10,6,'2024-02-05','08:00:00','16:00:00'),
(15,9,'2024-02-05','08:00:00','16:00:00');


-- WASTE COLLECTION (20 records)
-- Trigger will reset bin fill level

INSERT INTO waste_collection
(dustbin_id, worker_id, collection_date, collection_time, mass_weight_kg)
VALUES
(1,3,'2024-02-01','10:00:00',35.50),
(2,4,'2024-02-01','11:00:00',28.20),
(3,5,'2024-02-01','12:00:00',40.00),
(4,8,'2024-02-01','13:00:00',50.00),
(5,9,'2024-02-01','14:00:00',30.00),
(6,10,'2024-02-01','15:00:00',32.50),
(7,13,'2024-02-01','16:00:00',45.00),
(8,14,'2024-02-01','17:00:00',20.00),
(9,15,'2024-02-01','18:00:00',60.00),
(10,16,'2024-02-02','09:00:00',42.00),
(11,17,'2024-02-02','10:00:00',25.00),
(12,18,'2024-02-02','11:00:00',30.00),
(13,19,'2024-02-03','12:00:00',36.00),
(14,20,'2024-02-03','13:00:00',29.00),
(15,3,'2024-02-04','14:00:00',33.00),
(16,8,'2024-02-04','15:00:00',27.00),
(17,13,'2024-02-04','16:00:00',38.00),
(18,5,'2024-02-05','17:00:00',31.00),
(19,10,'2024-02-05','18:00:00',26.00),
(20,15,'2024-02-05','19:00:00',44.00);


-- MAINTENANCE REQUEST (10 records)

INSERT INTO maintenance_request
(dustbin_id, requested_by, assigned_to, request_date, request_description, status)
VALUES
(2,2,3,'2024-02-01','Broken lid','Resolved'),
(5,7,8,'2024-02-02','Overflow issue','InProgress'),
(8,12,13,'2024-02-02','Leakage problem','Pending'),
(11,1,4,'2024-02-03','Damaged wheels','Resolved'),
(14,6,9,'2024-02-03','Handle broken','InProgress'),
(17,11,14,'2024-02-04','Rusting problem','Pending'),
(20,2,5,'2024-02-04','Cracked bin','Resolved'),
(22,7,10,'2024-02-05','Bad smell issue','Pending'),
(24,12,15,'2024-02-05','Needs replacement','InProgress'),
(25,1,3,'2024-02-06','Cover missing','Pending');

-- =========================
-- LEAVE REQUEST (10 records)
-- =========================
INSERT INTO leave_request
(worker_id, approved_by, leave_start_date, leave_end_date, leave_type, status, reason)
VALUES
(3,1,'2024-03-01','2024-03-03','Casual','Approved','Family event'),
(4,1,'2024-03-05','2024-03-06','Sick','Approved','Fever'),
(5,2,'2024-03-10','2024-03-12','Casual','Pending','Personal work'),
(8,6,'2024-03-02','2024-03-04','Sick','Approved','Medical issue'),
(9,6,'2024-03-07','2024-03-08','Casual','Rejected','Urgent work'),
(10,7,'2024-03-15','2024-03-17','Annual','Pending','Vacation'),
(13,11,'2024-03-03','2024-03-04','Sick','Approved','Flu'),
(14,11,'2024-03-09','2024-03-10','Casual','Pending','Personal reason'),
(15,12,'2024-03-11','2024-03-13','Annual','Approved','Family trip'),
(16,1,'2024-03-20','2024-03-21','Sick','Pending','Checkup');


-- SALARY PAYMENT (15 records)
-- Trigger auto-calculates net_salary

INSERT INTO salary_payment
(worker_id, year, month, basic_salary, bonus, deductions, payment_date, payment_status)
VALUES
(1,2024,1,80000,5000,2000,'2024-01-31','Paid'),
(2,2024,1,60000,3000,1000,'2024-01-31','Paid'),
(3,2024,1,30000,1000,500,'2024-01-31','Paid'),
(4,2024,1,1200,200,0,'2024-01-31','Paid'),
(5,2024,1,28000,500,300,'2024-01-31','Paid'),
(6,2024,1,85000,6000,2000,'2024-01-31','Paid'),
(7,2024,1,62000,2500,1000,'2024-01-31','Paid'),
(8,2024,1,31000,1200,400,'2024-01-31','Paid'),
(9,2024,1,1300,200,0,'2024-01-31','Paid'),
(10,2024,1,29000,700,500,'2024-01-31','Paid'),
(11,2024,1,82000,4000,1500,'2024-01-31','Paid'),
(12,2024,1,61000,2000,1000,'2024-01-31','Paid'),
(13,2024,1,30000,800,300,'2024-01-31','Paid'),
(14,2024,1,1250,150,0,'2024-01-31','Paid'),
(15,2024,1,28000,600,400,'2024-01-31','Paid');
