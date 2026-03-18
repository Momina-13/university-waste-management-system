# ♻️ University Waste Management System

A full-stack web application to digitize and streamline waste management operations across university campuses. Replaces manual paper-based tracking of dustbin status, waste collections, worker assignments, maintenance requests, salary processing, and leave management.

---

## 👥 Team Members

| Name | Role |
|------|------|
| Momina Qayyum | Backend API + Database Design + Documentation |
| Hoorain Tahir | Frontend + UI/UX + Transactions |

---

## 🧰 Tech Stack

### Frontend
| Technology | Purpose |
|------------|---------|
| React.js 18 + Vite 5 | UI framework + build tool |
| React Router DOM 6 | Client-side routing |
| Axios | HTTP client with JWT interceptor |
| Recharts | Charts and data visualizations |
| React Toastify | Toast notifications |
| Lucide React | Icon library |

### Backend
| Technology | Purpose |
|------------|---------|
| Node.js 18 + Express.js | REST API server |
| mysql2/promise | MySQL driver with async/await |
| bcryptjs | Password hashing (salt rounds = 10) |
| jsonwebtoken | JWT authentication |
| helmet + cors | Security headers + CORS |
| express-rate-limit | 100 req / 15 min rate limiting |
| swagger-ui-express | Live API documentation |

### Database
| Technology | Purpose |
|------------|---------|
| MySQL 8.0 | Relational database |
| InnoDB | Storage engine (ACID compliant) |

---

## 🗂️ Project Structure
```
Project01/
│
├── backend/
│   ├── config/
│   │   └── db.js                  # MySQL connection pool
│   ├── controllers/
│   │   ├── authController.js      # Login + register
│   │   ├── workerController.js    # Worker CRUD + transaction
│   │   └── wasteController.js     # All other domain logic
│   ├── middleware/
│   │   ├── authMiddleware.js      # JWT verification
│   │   └── rbacMiddleware.js      # Role-based access control
│   ├── routes/
│   │   ├── authRoutes.js
│   │   ├── workerRoutes.js
│   │   └── wasteRoutes.js
│   ├── transactions/
│   │   └── wasteTransaction.js    # BEGIN/COMMIT/ROLLBACK logic
│   ├── swagger/
│   │   └── swagger.yaml           # OpenAPI 3.0 spec
│   ├── server.js
│   ├── .env.example
│   └── package.json
│
├── frontend/
│   ├── api/
│   │   └── axios.js               # Axios instance + interceptors
│   ├── components/
│   │   ├── Sidebar.jsx            # Role-aware navigation
│   │   └── Layout.jsx             # Page wrapper
│   ├── context/
│   │   └── AuthContext.jsx        # JWT + user state
│   ├── pages/
│   │   ├── auth/                  # Login, Register
│   │   ├── dashboard/             # Analytics + charts
│   │   ├── workers/               # Worker CRUD
│   │   ├── dustbins/              # Dustbin management
│   │   ├── waste/                 # Waste collections
│   │   ├── maintenance/           # Maintenance requests
│   │   ├── salary/                # Salary processing
│   │   └── leave/                 # Leave management
│   ├── utils/
│   │   └── ProtectedRoute.jsx     # Auth + role guard
│   ├── App.jsx
│   ├── main.jsx
│   ├── index.css
│   ├── index.html
│   ├── vite.config.js
│   ├── .env.example
│   └── package.json
│
├── schema.sql                     # Database schema + users table
├── seed.sql                       # Sample data + default users
├── performance.sql                # Index benchmarks
└── README.md
```
---

## 🏗️ System Architecture

---

## ⚙️ Setup & Installation

### Prerequisites

- Node.js v18+
- MySQL 8.0+
- npm 9+

### Step 1 — Database Setup

Open MySQL Workbench and run in this exact order:
```sql
-- 1. Run schema.sql (creates all tables)
-- 2. Disable safe updates
SET SQL_SAFE_UPDATES = 0;
-- 3. Run seed.sql (inserts sample data + users)
-- 4. Re-enable
SET SQL_SAFE_UPDATES = 1;
```

Verify:
```sql
USE university_db;
SELECT 'workers' as t, COUNT(*) FROM worker
UNION ALL SELECT 'dustbins', COUNT(*) FROM dustbin
UNION ALL SELECT 'users', COUNT(*) FROM users;
-- Expected: workers=20, dustbins=28, users=3
```

### Step 2 — Backend Setup
```bash
cd backend
cp .env.example .env
# Edit .env with your MySQL password
npm install
npm run dev
# → Server running on http://localhost:5000
# → Swagger docs at http://localhost:5000/api/docs
```

### Step 3 — Frontend Setup
```bash
cd frontend
cp .env.example .env
npm install
npm run dev
# → http://localhost:5173
```

---

## 🔐 Environment Variables

### `backend/.env`
```env
PORT=5000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_mysql_password
DB_NAME=university_db
JWT_SECRET=any_long_random_secret_string
JWT_EXPIRES_IN=24h
```

| Variable | Description |
|----------|-------------|
| `PORT` | Backend server port |
| `DB_HOST` | MySQL host |
| `DB_USER` | MySQL username |
| `DB_PASSWORD` | Your MySQL root password |
| `DB_NAME` | Database name (must be `university_db`) |
| `JWT_SECRET` | Secret for signing JWT tokens — keep private |
| `JWT_EXPIRES_IN` | Token expiry duration |

### `frontend/.env`
```env
VITE_API_URL=http://localhost:5000/api/v1
```

| Variable | Description |
|----------|-------------|
| `VITE_API_URL` | Base URL of the backend API |

---

## 👤 User Roles & Credentials

### Default Login Credentials

| Role | Username | Password | Access Level |
|------|----------|----------|--------------|
| **Manager** | `ali.manager` | `manager123` | Full access |
| **Admin** | `ahmed.admin` | `admin123` | Mid-level |
| **Cleaner** | `usman.cleaner` | `cleaner123` | Limited |

### Permissions Matrix

| Feature | Manager | Admin | Cleaner |
|---------|:-------:|:-----:|:-------:|
| Login/Logout | ✅ | ✅ | ✅ |
| View Dashboard + Charts | ✅ | ✅ | ✅ |
| Register new users | ✅ | ❌ | ❌ |
| View/Search workers | ✅ | ✅ | ❌ |
| Create worker (transaction) | ✅ | ❌ | ❌ |
| Edit worker | ✅ | ✅ | ❌ |
| Delete worker | ✅ | ❌ | ❌ |
| View dustbins | ✅ | ✅ | ✅ |
| Add/Edit dustbin | ✅ | ✅ | ❌ |
| Record waste collection (transaction) | ✅ | ✅ | ✅ |
| Submit maintenance request | ✅ | ✅ | ✅ |
| Update maintenance status | ✅ | ✅ | ❌ |
| View/Process salary (transaction) | ✅ | ❌ | ❌ |
| Submit leave request | ✅ | ✅ | ✅ |
| Approve/Reject leave | ✅ | ❌ | ❌ |

---

## 🚀 Features

### ✅ Authentication & Authorization
- JWT issued on login, stored in `localStorage`
- Axios interceptor auto-attaches `Authorization: Bearer <token>` to every request
- `ProtectedRoute.jsx` redirects unauthenticated users to `/login`
- Role-based sidebar — Cleaner cannot see Salary or Workers pages
- Auto-logout on token expiry (401 response)

### ✅ Analytics Dashboard (Complex Feature 1)
- 4 live stat cards: Workers, Dustbins, Collections, Maintenance
- Bar chart: waste collected (kg) over recent collections
- Pie chart: dustbin status distribution
- Bar chart: average fill level by bin

### ✅ Advanced Search & Filtering (Complex Feature 2)
- Workers: search by name/CNIC, filter by type
- Dustbins: search by building/campus, filter by status
- Maintenance: search by issue, filter by status
- Leave: filter by status
- Clear button to reset all filters

### ✅ Transaction Demonstration (Visible in UI)
All 3 transactions show green/red banners in the UI:

| Transaction | Endpoint | Trigger |
|-------------|----------|---------|
| Create Worker + User Account | `POST /workers` | Manager creates a worker |
| Record Collection + Reset Dustbin | `POST /waste-collections` | Any user records waste |
| Salary Payment + Components | `POST /salary` | Manager processes salary |

### ✅ Error Handling
- Loading spinners on all data fetches
- Toast notifications for success/error
- Red alert banner when dustbins ≥ 80% full
- Empty state messages on all tables
- Form validation with red error text per field

---

## ⚡ Transaction Scenarios

### Transaction 1 — Create Worker + User Account
- **File:** `backend/controllers/workerController.js` → `createWorker()`
- **Operations:** INSERT worker → bcrypt.hash(password) → INSERT user
- **Rollback when:** Duplicate CNIC or duplicate username

### Transaction 2 — Record Waste Collection + Reset Dustbin
- **File:** `backend/transactions/wasteTransaction.js` → `recordWasteCollection()`
- **Operations:** Verify dustbin → INSERT waste_collection → UPDATE dustbin fill=0
- **Rollback when:** Dustbin not found or FK violation

### Transaction 3 — Process Salary + Components
- **File:** `backend/transactions/wasteTransaction.js` → `processSalaryPayment()`
- **Operations:** Check duplicate → INSERT salary_payment → INSERT each salary_component
- **Rollback when:** Duplicate month/year or invalid component data

---

## 🔒 ACID Compliance

| Property | Implementation |
|----------|----------------|
| **Atomicity** | `BEGIN/COMMIT/ROLLBACK` in all 3 transaction functions |
| **Consistency** | DB constraints: `CHECK`, `UNIQUE`, `FOREIGN KEY`, trigger `trg_leave_validate` |
| **Isolation** | MySQL InnoDB REPEATABLE READ; dedicated connection per transaction |
| **Durability** | InnoDB writes to disk on COMMIT; connection pool with `waitForConnections: true` |

---

## 📊 Indexes & Performance

| Index | Table | Columns | Purpose |
|-------|-------|---------|---------|
| `idx_wc_dustbin_date` | waste_collection | dustbin_id, collection_date | Date-range reports per dustbin |
| `idx_salary_worker_date` | salary_payment | worker_id, year, month | Monthly salary lookup |
| `idx_ws_worker_date` | work_schedule | worker_id, shift_date | Schedule queries |
| `idx_mr_status` | maintenance_request | maintenance_status_id | Dashboard pending queries |
| `idx_leave_worker` | leave_request | worker_id | Leave history per worker |

---

## 📡 API Reference

Full Swagger spec: `http://localhost:5000/api/docs`

| Method | Route | Role | Purpose |
|--------|-------|------|---------|
| POST | `/auth/login` | Public | Login |
| POST | `/auth/register` | Manager | Register user |
| GET | `/workers` | Manager, Admin | List workers |
| POST | `/workers` | Manager | Create worker (transaction) |
| PUT | `/workers/:id` | Manager, Admin | Update worker |
| DELETE | `/workers/:id` | Manager | Delete worker |
| GET | `/dustbins` | All | List dustbins |
| GET | `/dustbins/full` | All | Dustbins ≥80% |
| POST | `/dustbins` | Manager, Admin | Add dustbin |
| GET | `/waste-collections` | All | List collections |
| POST | `/waste-collections` | All | Record collection (transaction) |
| GET | `/waste-collections/report` | Manager, Admin | Date-range report |
| GET | `/maintenance` | Manager, Admin | All requests |
| POST | `/maintenance` | All | Submit request |
| PUT | `/maintenance/:id` | Manager, Admin | Update status |
| GET | `/salary` | Manager | All payments |
| POST | `/salary` | Manager | Process salary (transaction) |
| GET | `/leave` | Manager, Admin | All leave |
| POST | `/leave` | All | Submit leave |
| PUT | `/leave/:id/approve` | Manager | Approve/reject |
| GET | `/health` | Public | Health check |

---

## ⚠️ Known Issues & Limitations

| Issue | Details |
|-------|---------|
| Hardcoded campus names in Add Worker form | Campus dropdown is static. Update options in `Workers.jsx` to match your campus names. |
| No pagination | All records fetched at once. Fine for demo data; add pagination for production. |
| Salary breakdown not shown in UI | Components exist in DB but not displayed per payment row. |
| No password change feature | Manager must delete and recreate the user account. |
