# University Waste Management System 

## 📌 Project Overview
The University Waste Management System (UWMS) is a comprehensive software solution designed to manage waste operations across the university’s main campus. The system focuses on:
1) internal waste management
2) ensuring efficient handling of waste inventory
3) dustbin monitoring
4) worker management
5) workflow automation.

This system improves cleanliness, operational efficiency, workforce management and real time monitoring of waste related activities.

## 🛠️ Technologies Used
- MySQL 8.0+
- MySQL Workbench
- Postman (for testing)

## 🧱 Database Schema
The system consists of the following main tables:
| Table Name        | Description                                      |
|-------------------|--------------------------------------------------|
| building          | Stores university building information           |
| dustbin           | Stores dustbin details linked to buildings       |
| waste_collection  | Records waste collection events                  |
| department        | Stores university departments                    |
| worker            | Stores worker details                            |
| salary            | Stores salary information                        |
| schedule          | Stores worker schedules                          |

## 🚀 Setup Instructions
### 1️⃣Step 1 — Import the database
Open MySQL Workbench and run these files in order:
1. schema.sql
2. seed.sql

### 2️⃣Step 2 — Configure environment
Open the backend folder, copy .env.example and rename it to .env
Edit .env and fill in your MySQL password:
```
DB_PASSWORD=yourpassword
```

### 3️⃣ Step 3 — Install dependencies
```bash
cd backend
npm install
```

### 4️⃣ Step 4 — Start the server
```bash
npm run dev
```
Server runs at: http://localhost:5000

### 5️⃣ Step 5 — View API documentation
Open browser and go to: http://localhost:5000/api/docs

---

## 📊 Performance Optimization
The project demonstrates query optimization using:

🔹 Single-Column Indexes

🔹 Composite Indexes

## Default Login Credentials
| Role    | Username       | Password    |
|---------|----------------|-------------|
| Manager | ali.manager    | manager123  |
| Admin   | ahmed.admin    | admin123    |
| Cleaner | usman.cleaner  | cleaner123  |

---

## Role Permissions
| Endpoint                          | Manager | Admin | Cleaner |
|-----------------------------------|---------|-------|---------|
| POST /auth/login                  | ✅      | ✅    | ✅      |
| POST /auth/register               | ✅      | ❌    | ❌      |
| GET /workers                      | ✅      | ✅    | ❌      |
| POST /workers                     | ✅      | ❌    | ❌      |
| DELETE /workers/:id               | ✅      | ❌    | ❌      |
| GET /dustbins                     | ✅      | ✅    | ✅      |
| POST /dustbins                    | ✅      | ✅    | ❌      |
| POST /waste-collections           | ✅      | ✅    | ✅      |
| POST /maintenance                 | ✅      | ✅    | ✅      |
| PUT /maintenance/:id              | ✅      | ✅    | ❌      |
| GET /salary                       | ✅      | ❌    | ❌      |
| POST /salary                      | ✅      | ❌    | ❌      |
| POST /leave                       | ✅      | ✅    | ✅      |
| PUT /leave/:id/approve            | ✅      | ❌    | ❌      |

---

## Transaction Scenarios
1. POST /workers — Inserts worker + user account atomically. Rolls back both if either fails.
2. POST /waste-collections — Inserts collection record + resets dustbin fill level atomically.
3. POST /salary — Inserts salary payment + all components atomically. Rolls back if duplicate.

---

## API Endpoints Summary
- Auth: POST /api/v1/auth/login, POST /api/v1/auth/register
- Workers: GET/POST /api/v1/workers, GET/PUT/DELETE /api/v1/workers/:id
- Dustbins: GET/POST /api/v1/dustbins, GET /api/v1/dustbins/full, PUT /api/v1/dustbins/:id
- Waste: GET/POST /api/v1/waste-collections, GET /api/v1/waste-collections/report
- Maintenance: GET/POST /api/v1/maintenance, GET /api/v1/maintenance/pending, PUT /api/v1/maintenance/:id
- Salary: GET/POST /api/v1/salary, GET /api/v1/salary/worker/:id
- Leave: GET/POST /api/v1/leave, PUT /api/v1/leave/:id/approve
  
## 🔐 ACID Compliance
The database ensures:
- **Atomicity** – Transactions complete fully or not at all
- **Consistency** – Constraints maintain valid data states
- **Isolation** – Concurrent transactions do not interfere
- **Durability** – Committed data persists even after system failure

## 🎯 Key Learning Outcomes
- Relational schema design
- Foreign key implementation
- Query optimization
- Index creation strategies
- Execution plan analysis using EXPLAIN ANALYZE
- Understanding ACID properties in MySQL

## 👨‍💻 Author
- University Database Systems Project
- MySQL 8.0 Implementation




















