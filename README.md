## Executive Summary

This project involved cleaning and preparing a global layoffs dataset using SQL to improve data quality and enable reliable analysis. The raw dataset contained duplicates, inconsistent text fields, missing values, and incorrect data formats, limiting its usefulness for decision-making.

I built a structured data cleaning pipeline using SQL, applying techniques such as window functions for deduplication, joins for handling missing values, and data type conversions for consistency. The result is a clean, analysis-ready dataset that supports accurate reporting and trend analysis.

This project demonstrates strong SQL and data preparation skills, with a focus on transforming messy real-world data into a reliable asset for business insights.

---

## Business Problem

Organizations rely on accurate data to understand workforce trends and make strategic decisions. However, raw layoff datasets are often inconsistent and incomplete, making it difficult to analyze patterns across companies, industries, and time.

The objective of this project was to clean and standardize the dataset to ensure it could be used for meaningful analysis, such as identifying layoff trends and comparing impacts across industries.

---

## Methodology

* Created a staging table to preserve raw data integrity
* Removed duplicate records using `ROW_NUMBER()` window function
* Standardized text fields (company, industry, country)
* Converted date fields into proper `DATE` format
* Handled missing values using self-joins to populate incomplete fields
* Removed records with insufficient data
* Performed final data validation checks

---

## Skills

* **SQL (MySQL)**
* Window Functions (`ROW_NUMBER`)
* Data Cleaning & Transformation
* Data Standardization
* Handling Missing Values (Self-Joins)
* Data Type Conversion (`STR_TO_DATE`)
* Data Validation Techniques

---

## Results & Business Recommendations

* Removed duplicate records, improving dataset accuracy
* Standardized key fields, enabling consistent analysis across companies and industries
* Converted and validated date fields, allowing accurate time-based analysis
* Improved overall data quality, making the dataset reliable for reporting

**Business Impact:**

* Enables accurate analysis of layoff trends across industries and time
* Supports better decision-making for workforce planning and market analysis
* Reduces time spent on manual data cleaning for analysts

**Recommendations:**

* Perform trend analysis to identify peak layoff periods and affected industries
* Use the cleaned dataset to build dashboards for monitoring workforce changes
* Share insights with stakeholders such as HR, strategy, and market analysts

---

## Next Steps

* Conduct exploratory data analysis to uncover key trends and patterns
* Build a dashboard (e.g., Power BI or Tableau) for visualization
* Integrate additional datasets (e.g., economic indicators) for deeper insights
* Automate the data cleaning process for ongoing updates
