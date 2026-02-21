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
### 1️⃣ Run Schema File
SOURCE schema.sql;

This will:
- Create university_db
- Create all tables with constraints

### 2️⃣ Insert Sample Data
SOURCE seed.sql;

This will populate the database with test records.

### 3️⃣ Run Performance Analysis
SOURCE performance.sql;

This will:
- Run EXPLAIN ANALYZE before indexing
- Create indexes
- Run EXPLAIN ANALYZE after indexing

## 📊 Performance Optimization
The project demonstrates query optimization using:

🔹 Single-Column Indexes

🔹 Composite Indexes

## 📈 Performance Analysis Results
Using EXPLAIN ANALYZE, the following improvements were observed:
1) Before indexing:
- Full table scans (type: ALL)
- Higher query cost
- More rows examined
- Slower execution

2) After indexing:
- Index-based lookups (type: ref, range)
- Reduced rows scanned
- Lower cost
- Improved execution time

This confirms that proper indexing significantly enhances database performance and scalability.

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




















