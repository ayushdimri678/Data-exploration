-- Query 1: View the entire dataset
SELECT * 
FROM layoffs_staging2;

-- Query 2: Find the maximum and minimum number of layoffs
SELECT 
    MAX(total_laid_off) AS max_layoffs, 
    MIN(total_laid_off) AS min_layoffs
FROM layoffs_staging2;

-- Query 3: Find the maximum number of layoffs and the highest percentage laid off
SELECT 
    MAX(total_laid_off) AS max_layoffs, 
    MAX(percentage_laid_off) AS max_percentage_laid_off
FROM layoffs_staging2;

-- Query 4: Companies that laid off 100% of their workforce, sorted by total layoffs
SELECT * 
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- Query 5: Companies with the highest fundraising amounts
SELECT * 
FROM layoffs_staging2
ORDER BY funds_raised_millions DESC;

-- Query 6: Total layoffs by company, sorted by total layoffs
SELECT 
    company, 
    SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY company
ORDER BY total_layoffs DESC;

-- Query 7: Find the earliest and latest dates of layoffs
SELECT 
    MIN(`date`) AS earliest_date, 
    MAX(`date`) AS latest_date
FROM layoffs_staging2;

-- Query 8: Total layoffs by industry, sorted by total layoffs
SELECT 
    industry, 
    SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY industry
ORDER BY total_layoffs DESC;

-- Query 9: Total layoffs by country, sorted by total layoffs
SELECT 
    country, 
    SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY country
ORDER BY total_layoffs DESC;

-- Query 10: Total layoffs by year, sorted by total layoffs
SELECT 
    YEAR(`date`) AS year, 
    SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY year
ORDER BY total_layoffs DESC;

-- Query 11: Total layoffs by month, sorted chronologically
SELECT 
    SUBSTRING(`date`, 1, 7) AS `month`, 
    SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY `month`;

-- Query 12: Rolling total of layoffs by month
WITH rolling_total AS (
    SELECT 
        SUBSTRING(`date`, 1, 7) AS `month`, 
        SUM(total_laid_off) AS total
    FROM layoffs_staging2
    WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
    GROUP BY `month`
    ORDER BY `month`
)
SELECT 
    `month`, 
    total, 
    SUM(total) OVER (ORDER BY `month`) AS rolling_total
FROM rolling_total;
