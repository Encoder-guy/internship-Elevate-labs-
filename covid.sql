
/* =========================================================
   COVID-19 DATA ANALYTICS PROJECT
   Database: SQLite
   Tool: DB Browser for SQLite
   Dataset Source: Kaggle (Our World in Data)
   ========================================================= */
create database covid;

-- =========================================================
-- DROP TABLE (SAFE RE-RUN)
-- =========================================================
DROP TABLE IF EXISTS covid_data;

-- =========================================================
-- CREATE TABLE
-- =========================================================
CREATE TABLE covid_data (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    continent TEXT,
    location TEXT NOT NULL,
    report_date DATE NOT NULL,
    total_cases INTEGER,
    new_cases INTEGER,
    total_deaths INTEGER,
    new_deaths INTEGER,
    total_vaccinations INTEGER,
    people_vaccinated INTEGER,
    population INTEGER
);

-- =========================================================
-- INDEXES
-- =========================================================
CREATE INDEX idx_location_date
ON covid_data (location, report_date);

-- =========================================================
-- SAMPLE DATA (CLEANED & STANDARDIZED)
-- NOTE: Replace or append Kaggle data after import
-- =========================================================
INSERT INTO covid_data 
(continent, location, report_date, total_cases, new_cases, total_deaths, new_deaths, total_vaccinations, people_vaccinated, population)
VALUES
('Asia', 'India', '2021-04-01', 12000000, 72000, 160000, 450, 65000000, 55000000, 1380000000),
('Asia', 'India', '2021-04-02', 12070000, 70000, 161000, 480, 66000000, 56000000, 1380000000),
('North America', 'United States', '2021-04-01', 30000000, 65000, 550000, 1200, 150000000, 98000000, 331000000),
('North America', 'United States', '2021-04-02', 30060000, 60000, 551200, 1200, 152000000, 100000000, 331000000),
('Europe', 'Italy', '2021-04-01', 3600000, 22000, 110000, 500, 18000000, 14000000, 60000000),
('Europe', 'Italy', '2021-04-02', 3620000, 20000, 110500, 450, 18500000, 14500000, 60000000);

-- =========================================================
-- DATA CLEANING & TRANSFORMATION
-- =========================================================

-- Replace NULL values
UPDATE covid_data SET new_cases = 0 WHERE new_cases IS NULL;
UPDATE covid_data SET new_deaths = 0 WHERE new_deaths IS NULL;
UPDATE covid_data SET total_cases = 0 WHERE total_cases IS NULL;
UPDATE covid_data SET total_deaths = 0 WHERE total_deaths IS NULL;

-- Remove invalid / aggregate rows
DELETE FROM covid_data
WHERE location IN ('World', 'International');

-- =========================================================
-- ANALYTICAL QUERIES
-- =========================================================

-- 1. TOP 10 COUNTRIES BY TOTAL CASES
SELECT 
    location,
    MAX(total_cases) AS total_cases
FROM covid_data
GROUP BY location
ORDER BY total_cases DESC
LIMIT 10;

-- 2. TOP 10 COUNTRIES BY TOTAL DEATHS
SELECT 
    location,
    MAX(total_deaths) AS total_deaths
FROM covid_data
GROUP BY location
ORDER BY total_deaths DESC
LIMIT 10;

-- 3. DAILY GLOBAL NEW CASES TREND
SELECT 
    report_date,
    SUM(new_cases) AS global_new_cases
FROM covid_data
GROUP BY report_date
ORDER BY report_date;

-- 4. DEATH RATE (%) BY COUNTRY
SELECT 
    location,
    ROUND(
        (MAX(total_deaths) * 100.0) / NULLIF(MAX(total_cases), 0),
        2
    ) AS death_rate_percentage
FROM covid_data
GROUP BY location
ORDER BY death_rate_percentage DESC;

-- =========================================================
-- WINDOW FUNCTION ANALYTICS
-- =========================================================

-- 5. 7-DAY MOVING AVERAGE OF NEW CASES
SELECT 
    location,
    report_date,
    new_cases,
    ROUND(
        AVG(new_cases) OVER (
            PARTITION BY location
            ORDER BY report_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS seven_day_avg_cases
FROM covid_data;

-- 6. COUNTRY RANKING BY TOTAL CASES
SELECT 
    location,
    MAX(total_cases) AS total_cases,
    RANK() OVER (ORDER BY MAX(total_cases) DESC) AS country_rank
FROM covid_data
GROUP BY location;

-- =========================================================
-- VIEWS (EXPORTABLE REPORTS)
-- =========================================================

DROP VIEW IF EXISTS country_covid_summary;
CREATE VIEW country_covid_summary AS
SELECT 
    location,
    MAX(total_cases) AS total_cases,
    MAX(total_deaths) AS total_deaths,
    MAX(total_vaccinations) AS total_vaccinations,
    population
FROM covid_data
GROUP BY location;

DROP VIEW IF EXISTS global_daily_stats;
CREATE VIEW global_daily_stats AS
SELECT 
    report_date,
    SUM(new_cases) AS new_cases,
    SUM(new_deaths) AS new_deaths
FROM covid_data
GROUP BY report_date;

-- =========================================================
-- FINAL CHECK
-- =========================================================
SELECT 'COVID-19 Data Analytics Database Ready' AS STATUS;
