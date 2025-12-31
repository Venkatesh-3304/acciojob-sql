    What Makes This Enterprise-Grade?
        Materialized Views for fast dashboard queries (used by Amazon, Flipkart)
        RFM Customer Segmentation (how Swiggy targets promotions)
        Cohort Retention Analysis (how Netflix measures product-market fit)
        ABC/Pareto Analysis (how DMart manages inventory)
        Automated Business Alerts (how PhonePe catches issues early)
        JSON API Functions (how modern dashboards fetch data)
        Audit Logging (required for compliance at banks like HDFC)

    This project demonstrates mastery of every concept from Days 1-21:
        CTEs (WITH clauses) - Complex query organization
        Window Functions - ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD, NTILE
        Moving Averages - ROWS BETWEEN n PRECEDING
        Date Intelligence - DATE_TRUNC, EXTRACT, AGE, INTERVAL
        Conditional Aggregation - CASE WHEN inside SUM/COUNT
        Multi-table JOINs - Combining 5+ tables efficiently
        JSON Functions - json_build_object, json_agg
        Stored Procedures - Refresh orchestration
        Materialized Views - Pre-computed analytics

        retailmart_analytics_project/
        ├── 01_setup/                    # Foundation
        │   ├── 01_create_analytics_schema.sql
        │   ├── 02_create_metadata_tables.sql
        │   └── 03_create_indexes.sql
        ├── 02_data_quality/            # Validation
        │   └── data_quality_checks.sql
        ├── 03_kpi_queries/             # Core Analytics
        │   ├── 01_sales_analytics.sql
        │   ├── 02_customer_analytics.sql
        │   ├── 03_product_analytics.sql
        │   ├── 04_store_analytics.sql
        │   ├── 05_operations_analytics.sql
        │   └── 06_marketing_analytics.sql
        ├── 04_alerts/                  # Monitoring
        │   └── business_alerts.sql
        ├── 05_refresh/                 # Automation
        │   ├── refresh_all_analytics.sql
        │   └── export_all_json.sh
        ├── 06_dashboard/               # Visualization
        │   ├── index.html
        │   ├── css/styles.css
        │   ├── js/dashboard.js
        │   └── data/                   # 32 JSON files
        └── 07_documentation/           # Documentation
            └── README.md
    
    Data Flow Architecture
        Source Tables (sales, customers, products, stores)
                ↓
        Regular Views (real-time calculations)
                ↓
        Materialized Views (pre-computed, refreshed daily)
                ↓
        JSON Export Functions (API layer)
                ↓
        Dashboard (HTML/JS visualization)
        
    What business problem you are solving
    
    The Business Story
    Every Monday morning at Amazon India, leadership asks: "How did we do last week?" This module answers that question with precision.
    
    Real-world application: When Flipkart's Big Billion Day starts, executives refresh their dashboards every hour to monitor:
    •	Real-time revenue vs targets
    •	Hour-over-hour growth trends
    •	Payment gateway performance
    •	Regional performance variations
    

        Shared the zip file
                unzip the file
                open that in vs code

        Open the terminal
                navigate to the project folder if you are not in that
                to confirm
                        run
                                ls or dir in terminal
                                if you are getting 
                                        01_setup
                                        02_data_quality
                                we are in correct folder

        Now we will execute the each setup one by one

        Run setup scripts in order
                psql -d retailmart_22 -U postgres -f 01_setup/01_create_analytics_schema.sql
                psql -d retailmart_22 -U postgres -f 01_setup/02_create_metadata_tables.sql
                psql -d retailmart_22 -U postgres -f 01_setup/03_create_indexes.sql

        Run data quality checks
                psql -d retailmart_22 -U postgres -f 02_data_quality/data_quality_checks.sql

        Create analytics views
                psql -d retailmart_22 -U postgres -f 03_kpi_queries/01_sales_analytics.sql
                psql -d retailmart_22 -U postgres -f 03_kpi_queries/02_customer_analytics.sql
                psql -d retailmart_22 -U postgres -f 03_kpi_queries/03_product_analytics.sql
                psql -d retailmart_22 -U postgres -f 03_kpi_queries/04_store_analytics.sql
                psql -d retailmart_22 -U postgres -f 03_kpi_queries/05_operations_analytics.sql
                psql -d retailmart_22 -U postgres -f 03_kpi_queries/06_marketing_analytics.sql

        Create alerts
                psql -d retailmart_22 -U postgres -f 04_alerts/business_alerts.sql

        Set up refresh functions
                psql -d retailmart_22 -U postgres -f 05_refresh/refresh_all_analytics.sql

        Export JSON data
                chmod +x 05_refresh/export_all_json.sh
                ./05_refresh/export_all_json.sh