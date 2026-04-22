-- =====================================================
-- Data Cleaning Project: Global Layoffs Dataset
-- 
-- This script performs data cleaning using SQL:
-- - Removes duplicates
-- - Standardizes text fields
-- - Handles missing values
-- - Converts data types
-- - Prepares dataset for analysis
-- =====================================================


-- 1. Creating staging table

CREATE TABLE layoffs_staging
LIKE layoffs_raw;


INSERT INTO layoffs_staging
SELECT * 
FROM layoffs_raw;


-- 2. Remove duplicates

CREATE TABLE `layoffs_cleaned` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- Assign row numbers to identify duplicate records
-- Duplicates are defined based on all relevant columns
-- Keeping the first occurrence and removing the rest

INSERT INTO layoffs_cleaned
SELECT *, 
	ROW_NUMBER() OVER( PARTITION BY company, location, industry, total_laid_off, 
	percentage_laid_off, `date`, stage, country, funds_raised_millions
    ORDER BY company) AS row_num
FROM layoffs_staging;


DELETE
FROM layoffs_cleaned
WHERE row_num >1;


-- 3. Standardize text fields

UPDATE layoffs_cleaned
SET company = TRIM(company);

-- Standardizing 'Crypto' variations into a single category

UPDATE layoffs_cleaned
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%' ;


UPDATE layoffs_cleaned
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';


-- 4. Convert data types

-- Convert date from text format to DATE type

UPDATE layoffs_cleaned
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');


SELECT *
FROM layoffs_cleaned
WHERE `date` IS NULL;


ALTER TABLE layoffs_cleaned
MODIFY `date` DATE;


-- 5. Handle missing values

-- Populate missing industry values using other records 
-- from the same company and location

UPDATE layoffs_cleaned t1
JOIN layoffs_cleaned t2
	ON t1.company = t2.company
    AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;


-- 6. Remove irrelevant rows and columns

-- Remove rows where both layoff metrics are NULL
-- These records do not provide useful analytical value

DELETE
FROM layoffs_cleaned
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


ALTER TABLE layoffs_cleaned
DROP COLUMN row_num;


-- 7. Final data quality checks

-- Final data quality checks to ensure dataset integrity

SELECT COUNT(*) 
FROM layoffs_cleaned;

SELECT COUNT(*) 
FROM layoffs_cleaned
WHERE company IS NULL;

SELECT * 
FROM layoffs_cleaned LIMIT 10;


-- 8. Sample Analysis

-- Top companies by layoffs

SELECT company, SUM(total_laid_off) AS total
FROM layoffs_cleaned
GROUP BY company
ORDER BY total DESC;
