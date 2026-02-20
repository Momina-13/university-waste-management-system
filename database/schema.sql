DROP DATABASE IF EXISTS university_db;
CREATE DATABASE university_db;
USE university_db;
CREATE TABLE university (
    university_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(200) NOT NULL UNIQUE,
    main_campus_location VARCHAR(255),
    contact_email VARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE campus (
    campus_id INT PRIMARY KEY AUTO_INCREMENT,
    university_id INT NOT NULL,
    campus_code VARCHAR(20) NOT NULL,
    campus_name VARCHAR(200) NOT NULL,
    address VARCHAR(255),
    contact_number VARCHAR(50),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_campus_university
        FOREIGN KEY (university_id)
        REFERENCES university(university_id)
        ON DELETE CASCADE ON UPDATE CASCADE,

    UNIQUE (university_id, campus_code),
    UNIQUE (university_id, campus_name)
);
CREATE TABLE building (
    building_id INT PRIMARY KEY AUTO_INCREMENT,
    campus_id INT NOT NULL,
    building_code VARCHAR(20) NOT NULL,
    building_name VARCHAR(200) NOT NULL,
    building_type VARCHAR(50),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (campus_id)
        REFERENCES campus(campus_id)
        ON DELETE CASCADE ON UPDATE CASCADE,

    UNIQUE (campus_id, building_code),
    UNIQUE (campus_id, building_name)
);
CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    campus_id INT NOT NULL,
    item_code VARCHAR(30) NOT NULL,
    item_name VARCHAR(200) NOT NULL,
    item_category VARCHAR(100),
    quantity INT NOT NULL DEFAULT 0,
    reorder_level INT NOT NULL DEFAULT 0,
    unit_price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    supplier_name VARCHAR(200),
    last_updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (campus_id)
        REFERENCES campus(campus_id)
        ON DELETE CASCADE ON UPDATE CASCADE,

    UNIQUE (campus_id, item_code),

    CHECK (quantity >= 0),
    CHECK (reorder_level >= 0),
    CHECK (unit_price >= 0)
);
CREATE TABLE worker (
    worker_id INT PRIMARY KEY AUTO_INCREMENT,
    campus_id INT NOT NULL,
    worker_code VARCHAR(20) NOT NULL,
    full_name VARCHAR(200) NOT NULL,
    cnic VARCHAR(30) UNIQUE,
    phone VARCHAR(50),
    address VARCHAR(255),
    hire_date DATE,
    role VARCHAR(50) NOT NULL,
    salary_type VARCHAR(20) NOT NULL,
    base_salary DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    employment_status VARCHAR(20) DEFAULT 'Active',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (campus_id)
        REFERENCES campus(campus_id)
        ON DELETE CASCADE ON UPDATE CASCADE,

    UNIQUE (campus_id, worker_code),

    CHECK (role IN ('Admin','Manager','Cleaner')),
    CHECK (salary_type IN ('Monthly','Daily')),
    CHECK (employment_status IN ('Active','Resigned','Terminated')),
    CHECK (base_salary >= 0)
);
CREATE TABLE dustbin (
    dustbin_id INT PRIMARY KEY AUTO_INCREMENT,
    building_id INT NOT NULL,
    dustbin_code VARCHAR(20) NOT NULL,
    floor_no INT,
    location_desc VARCHAR(255),
    bin_type VARCHAR(50),
    capacity_liters INT,
    current_fill_level DECIMAL(5,2) DEFAULT 0,
    last_emptied_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (building_id)
        REFERENCES building(building_id)
        ON DELETE CASCADE ON UPDATE CASCADE,

    UNIQUE (building_id, dustbin_code),

    CHECK (current_fill_level BETWEEN 0 AND 100),
    CHECK (capacity_liters >= 0)
);
CREATE TABLE waste_collection (
    collection_id INT PRIMARY KEY AUTO_INCREMENT,
    dustbin_id INT NOT NULL,
    worker_id INT NOT NULL,
    collection_date DATE NOT NULL,
    collection_time TIME NOT NULL,
    mass_weight_kg DECIMAL(8,2),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (dustbin_id)
        REFERENCES dustbin(dustbin_id)
        ON DELETE CASCADE ON UPDATE CASCADE,

    FOREIGN KEY (worker_id)
        REFERENCES worker(worker_id)
        ON DELETE RESTRICT,

    CHECK (mass_weight_kg >= 0)
);
CREATE TABLE maintenance_request (
    maintenance_id INT PRIMARY KEY AUTO_INCREMENT,
    dustbin_id INT NOT NULL,
    requested_by INT NOT NULL,
    assigned_to INT,
    request_date DATE NOT NULL,
    request_description VARCHAR(500),
    status VARCHAR(20) DEFAULT 'Pending',
    resolved_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (dustbin_id)
        REFERENCES dustbin(dustbin_id)
        ON DELETE CASCADE,

    FOREIGN KEY (requested_by)
        REFERENCES worker(worker_id),

    FOREIGN KEY (assigned_to)
        REFERENCES worker(worker_id),

    CHECK (status IN ('Pending','InProgress','Resolved'))
);
CREATE TABLE leave_request (
    leave_id INT PRIMARY KEY AUTO_INCREMENT,
    worker_id INT NOT NULL,
    approved_by INT,
    leave_start_date DATE NOT NULL,
    leave_end_date DATE NOT NULL,
    leave_type VARCHAR(20),
    status VARCHAR(20) DEFAULT 'Pending',
    reason VARCHAR(500),
    actioned_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (worker_id)
        REFERENCES worker(worker_id)
        ON DELETE CASCADE,

    FOREIGN KEY (approved_by)
        REFERENCES worker(worker_id),

    CHECK (status IN ('Pending','Approved','Rejected'))
);
CREATE TABLE salary_payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    worker_id INT NOT NULL,
    year INT NOT NULL,
    month INT NOT NULL,
    basic_salary DECIMAL(10,2) NOT NULL,
    bonus DECIMAL(10,2) DEFAULT 0,
    deductions DECIMAL(10,2) DEFAULT 0,
    net_salary DECIMAL(10,2),
    payment_date DATE,
    payment_status VARCHAR(20) DEFAULT 'Pending',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (worker_id)
        REFERENCES worker(worker_id)
        ON DELETE CASCADE,

    UNIQUE (worker_id, year, month),

    CHECK (month BETWEEN 1 AND 12),
    CHECK (payment_status IN ('Pending','Paid','Failed'))
);
CREATE TABLE work_schedule (
    schedule_id INT PRIMARY KEY AUTO_INCREMENT,
    worker_id INT NOT NULL,
    building_id INT NOT NULL,
    service_date DATE NOT NULL,
    shift_start_time TIME NOT NULL,
    shift_end_time TIME NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (worker_id)
        REFERENCES worker(worker_id)
        ON DELETE CASCADE,

    FOREIGN KEY (building_id)
        REFERENCES building(building_id)
        ON DELETE CASCADE
);
DELIMITER $$

CREATE TRIGGER trg_wc_after_insert
AFTER INSERT ON waste_collection
FOR EACH ROW
BEGIN
    UPDATE dustbin
    SET current_fill_level = 0,
        last_emptied_at = CURRENT_TIMESTAMP
    WHERE dustbin_id = NEW.dustbin_id;
END$$

CREATE TRIGGER trg_salary_before_insert
BEFORE INSERT ON salary_payment
FOR EACH ROW
BEGIN
    SET NEW.net_salary =
        NEW.basic_salary + IFNULL(NEW.bonus,0) - IFNULL(NEW.deductions,0);
END$$

CREATE TRIGGER trg_leave_validate
BEFORE UPDATE ON leave_request
FOR EACH ROW
BEGIN
    IF NEW.leave_end_date < NEW.leave_start_date THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid leave date range';
    END IF;

    IF NEW.status <> OLD.status THEN
        SET NEW.actioned_at = CURRENT_TIMESTAMP;
    END IF;
END$$

DELIMITER ;
-- views
CREATE VIEW vw_active_workers_schedule AS
SELECT w.worker_id, w.full_name, w.role,
       c.campus_name, b.building_name,
       ws.service_date, ws.shift_start_time, ws.shift_end_time
FROM worker w
JOIN campus c ON w.campus_id = c.campus_id
LEFT JOIN work_schedule ws ON w.worker_id = ws.worker_id
LEFT JOIN building b ON ws.building_id = b.building_id
WHERE w.employment_status = 'Active';
CREATE VIEW vw_pending_maintenance AS
SELECT mr.maintenance_id, mr.request_date,
       d.dustbin_code, b.building_name,
       mr.status
FROM maintenance_request mr
JOIN dustbin d ON mr.dustbin_id = d.dustbin_id
JOIN building b ON d.building_id = b.building_id
WHERE mr.status IN ('Pending','InProgress');
CREATE VIEW vw_worker_monthly_salary AS
SELECT w.full_name, sp.year, sp.month, sp.net_salary
FROM salary_payment sp
JOIN worker w ON sp.worker_id = w.worker_id;
-- indexes
CREATE INDEX idx_campus_university ON campus(university_id);
CREATE INDEX idx_building_campus ON building(campus_id);
CREATE INDEX idx_worker_campus ON worker(campus_id);
CREATE INDEX idx_dustbin_building ON dustbin(building_id);
CREATE INDEX idx_wc_dustbin_date ON waste_collection(dustbin_id, collection_date);
CREATE INDEX idx_mr_status ON maintenance_request(status);
CREATE INDEX idx_sp_worker_date ON salary_payment(worker_id, year, month);
CREATE INDEX idx_ws_worker_date ON work_schedule(worker_id, service_date);
CREATE INDEX idx_lr_worker_status ON leave_request(worker_id, status);