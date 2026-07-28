# 🎓 Student Dropout & Engagement Analysis

> An end-to-end data analytics project identifying key predictors of student dropout to enable early institutional intervention.

---

## 📌 Problem Statement

Educational institutions often identify at-risk students too late — typically after multiple semesters of poor performance or non-payment. This project analyzes **4,424 student records** across demographic, financial, and academic dimensions to uncover early-warning signals, enabling institutions to intervene **before** a student drops out rather than after.

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| **Python (Pandas)** | Data cleaning, validation, and exploratory analysis |
| **SQL (SQLite)** | CTEs, Window Functions, JOINs, and aggregations for deep-dive analysis |
| **Power BI** | Interactive dashboard for stakeholder-facing insights |

---

## 🔍 Project Workflow

1. **Data Cleaning (Python)** — Verified data integrity (0 missing values, 0 duplicates) across 37 features
2. **Exploratory Analysis (Python)** — Identified initial patterns in financial, demographic, and academic factors
3. **SQL Analysis** — Built a SQLite pipeline using:
   - `GROUP BY` aggregations for category-wise dropout rates
   - `CTE`s for layered, readable risk-summary queries
   - `RANK() OVER()` window function to rank courses by dropout risk
   - `JOIN` with a custom risk-category lookup table
   - `CASE WHEN` logic for age-group segmentation
4. **Dashboard (Power BI)** — Built an interactive dashboard consolidating all findings into a single stakeholder-ready view

---

## 📊 Key Findings

| Insight | Detail |
|---------|--------|
| 💰 **Fee status is the strongest predictor** | Students with pending tuition fees show an **89% dropout rate** vs. just **10%** for fee-compliant students |
| 👤 **Age matters** | Mature students (26+) face **2.6x higher dropout risk** (56%) than teen students (21%) |
| 📉 **1st semester performance is critical** | Average 1st-semester grade of dropouts (7.26) is nearly **half** that of graduates (12.64) — early intervention post-semester 1 could significantly reduce dropout |
| 🎯 **Risk segmentation works** | Combining scholarship + fee status into 4 risk tiers (Critical/High/Moderate/Low) cleanly separates dropout rates from 89% down to 10% |

---

## 📈 Dashboard Preview

![Dashboard Screenshot](dashboard_screenshot.jpg)

The dashboard includes:
- KPI cards (Total Students, Dropout Rate, Total Dropouts, Courses Analyzed)
- Outcome distribution (Dropout / Enrolled / Graduate)
- Dropout rate by course, risk category, and age group
- Key business insights panel

---

## 📁 Repository Structure
