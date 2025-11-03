## 🧠 Summary

This project consists of a data pipeline for ingesting, transforming, and delivering Bitcoin transaction data, with a focus on detecting “whales” — that is, movements of large amounts.  
The data is loaded into **Snowflake**, transformed using **dbt (core)** following **CI/CD practices (via GitHub Actions)**, and exposed for visual consumption through a dashboard (e.g., **Looker Studio**).

---

## 🎯 Main Goals

1. Extract public Bitcoin transaction data hosted in a public **AWS S3** bucket.  
2. Load this data into **Snowflake** as a raw source.  
3. Identify transactions with large volumes (**whales**).  
4. Apply transformations and modeling using **dbt core** to generate clean, analysis-ready tables.  
5. Automate the entire workflow with **GitHub Actions** to ensure CI/CD (testing, builds, deployment).  
6. Make the transformed data available in **Snowflake** for use in dashboards built with **Looker Studio** (or another BI tool).  

The result is an **end-to-end data infrastructure** for analyzing large Bitcoin transactions.

## 🏗️ Architecture

<img width="800" height="576" alt="image" src="https://github.com/user-attachments/assets/39016e64-99e1-4bf8-85df-6dd82f2fb47f" />


### 💡 **Architecture Explanation**

- **AWS S3** → Public Bitcoin transaction data source (Parquet). 
- **Snowflake (Raw)** → Stores raw transaction data exactly as ingested.  
- **dbt (Core)** → Applies transformations, modular modeling, and data quality tests.  
- **Snowflake (Marts)** → Final clean, analysis-ready tables.  
- **GitHub Actions** → Runs CI pipeline: tests, builds, and deployments.  
- **Looker Studio** → Visualization and analysis layer consuming Snowflake data.

Note: Snowflake contained 3 Schemas (Similar to medallion architecture):
  - BTC (raw data - bronze)
  - DBT_DAVID_DEV (cleaned data - silver)
  - PROD (enriched data - gold)
  
## 🛠 Technologies / Dependencies

| Technology / Tool | Purpose |
|--------------------|----------|
| **dbt (core)** | Data modeling, transformations, and orchestration |
| **Snowflake** | Data warehouse / final destination for transformed data |
| **GitHub** | Version control, collaboration, and repository management |
| **GitHub Actions** | Automation, CI/CD workflows |
| **AWS S3** | Public repository containing Bitcoin transaction data (data source) |
| **Python libraries** (`pandas`, `simplejson`) / helper scripts | Ingestion pipeline support |

## 🧩 Techniques & Best Practices used

| Technique | Description |
|------------|--------------|
| **Data Quality Tests (singular & generic)** | Ensures data reliability by validating integrity, uniqueness, and referential consistency through both custom (singular) and reusable (generic) dbt tests. |
| **Modularization** | Structured models in layered architecture — **staging → marts** — improving readability, maintainability, and performance. |
| **Documentation in dbt** | Auto-generate browsable documentation via `dbt docs generate`. |
| **Incremental Models** | Implemented incremental logic in dbt models to process only new or updated records, improving performance and efficiency. |
| **Data Enrichment via dbt Seeds** | Enriched transactional data using static seed files for reference mappings and additional metadata. |
| **Incremental Strategies (Merge & Append)** | Applied `merge` for upserts and `append` for log-based data, depending on data characteristics and freshness needs. |
| **Python Models** | Leveraged Python-based dbt models for complex data transformations or non-SQL operations within the same dbt workflow. |
| **dbt Exposure** | Created **exposures** to explicitly link dbt models to the final **dashboard**, ensuring traceability and visibility of data lineage. |
| **Model Contracts** | Defined **model contracts** to guarantee schema stability; versioning via **dbt versions** was used to manage controlled model evolution. |
| **Continuous Integration (GitHub Actions)** | Implemented CI/CD pipelines with automated testing, linting, and deployment using GitHub Actions to ensure stable, production-ready releases. |
