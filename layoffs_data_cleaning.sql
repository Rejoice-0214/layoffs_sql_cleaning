SELECT *
FROM layoffs;

-- Data Cleaning
-- step1: Removing duplicates
-- step2: Starndardize the data
-- step3: Removing Null values or blank spaces
-- step4: Removing columns that are not needed
-- note that when cleaning a data it is important to create a copy of that data. we can do that by ;

CREATE TABLE layoffs_copy
LIKE layoffs;

SELECT *
FROM layoffs_copy;

INSERT layoffs_copy
SELECT *
FROM layoffs;

SELECT *, ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_copy;

WITH duplicate_cte AS (
SELECT *, ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_copy)
SELECT *
FROM duplicate_cte
WHERE row_num >1;


CREATE TABLE `layoffs_copy2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT *
FROM layoffs_copy2
WHERE row_num >1
;

INSERT INTO layoffs_copy2 
SELECT *, ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_copy;


DELETE
FROM layoffs_copy2
WHERE row_num >1
;

-- starndardizing data

SELECT company, TRIM(company)
FROM layoffs_copy2;

UPDATE layoffs_copy2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_copy2
ORDER BY 1;

SELECT *
FROM layoffs_copy2
WHERE industry LIKE 'Crypto%';

-- it is important to check for distinct values of every column so as to know if there is anything that you need to fix

UPDATE layoffs_copy2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT location
FROM layoffs_copy2
ORDER BY 1;

SELECT DISTINCT country
FROM layoffs_copy2
WHERE country LIKE 'United States%';

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_copy2
ORDER BY 1; 

UPDATE layoffs_copy2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- if we check our date, it is a text not an actual date. so by changing that we will do it this way

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_copy2;

UPDATE layoffs_copy2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- whenever you are ti alter a table it is advisable to do it on the data copy and not the raw data
-- we are going to alter the table to make it a date column
ALTER TABLE layoffs_copy2
MODIFY COLUMN `date` DATE;

-- Null and Blank Spaces
SELECT *
FROM layoffs_copy2
WHERE total_laid_off IS NULL;

SELECT *
FROM layoffs_copy2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;

-- let's take a look at these
SELECT *
FROM layoffs_copy2
WHERE company LIKE 'Bally%';


SELECT *
FROM layoffs_copy2
WHERE company LIKE 'airbnb%';

-- we should set the blanks to nulls since those are typically easier to work with

UPDATE layoffs_copy2
SET industry = NULL
WHERE industry = '';

-- now if we check those are all null

SELECT *
FROM layoffs_copy2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;

-- now we need to populate those nulls if possible

UPDATE layoffs_copy2 t1
JOIN layoffs_copy2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- and if we check it looks like Bally's was the only one without a populated row to populate this null values
SELECT *
FROM layoffs_copy2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;

SELECT *
FROM layoffs_copy2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


DELETE
FROM layoffs_copy2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_copy2
DROP COLUMN row_num;

SELECT * 
FROM layoffs_copy2;
