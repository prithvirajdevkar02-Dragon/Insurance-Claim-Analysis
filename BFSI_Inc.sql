create database BFSI_Inc
use BFSI_Inc

# --------------------------------------------------------{ Agent Query }---------------------------------------------------------
-- display all records from agent table
select * from agent;

-- modify data types and rename bom column
alter table agent
change column `ï»¿agent_id` agent_id varchar(10),
modify agent_code varchar(15),
modify agent_full_name varchar(100),
modify agent_type varchar(50),
modify phone_number varchar(15),
modify email_address varchar(100),
modify city_id varchar(10);

-- add primary key on agent_id
alter table agent
add primary key (agent_id);

-- check data types of agent table
desc agent;

# --------------------------------------------------------{ Channel Query }---------------------------------------------------------
-- display all records from channel table
select * from channel;

-- modify data types and rename bom column
alter table channel
change column `ï»¿channel_id` channel_id varchar(10),
modify channel_name varchar(30);

-- add primary key on channel_id
alter table channel
add primary key (channel_id);

-- verify updated structure
desc channel;

# --------------------------------------------------------{ Claim Query }---------------------------------------------------------
-- display all records from claim table
select * from claim;

-- rename bom column
alter table claim
change column `ï»¿claim_id` claim_id varchar(20);

-- modify id columns
alter table claim
modify claim_number varchar(30),
modify policy_id varchar(20),
modify customer_id varchar(20),
modify product_id varchar(20),
modify insurance_id varchar(20),
modify agent_id varchar(20),
modify region_id varchar(20),
modify city_id varchar(20),
modify channel_id varchar(20),
modify claim_status_id varchar(20),
modify loss_driver_id varchar(20);

-- modify date columns
alter table claim
modify incident_date date,
modify registration_date date,
modify assessment_date date,
modify approval_date date,
modify payment_date date,
modify closure_date date;

-- modify amount columns
alter table claim
modify bill_amount decimal(12,2),
modify approved_amount decimal(12,2),
modify annual_premium decimal(12,2),
modify paid_amount decimal(12,2),
modify benchmark_amount decimal(12,2),
modify bill_vs_benchmark_ratio decimal(10,2);

-- modify text columns
alter table claim
modify claim_month varchar(20),
modify claim_status varchar(30),
modify claim_status_group varchar(30),
modify flag_reason_code varchar(50);

-- add primary key
alter table claim
add primary key (claim_id);

-- Update this column
ALTER TABLE claim
RENAME COLUMN `High-Cost Claim Flag` TO high_cost_claim_flag;

-- verify updated structure
desc claim;

# --------------------------------------------------------{ Claim_Status Query }---------------------------------------------------------
-- display all records from claim_status table
select * from claim_status;

-- rename bom column and modify data types
alter table claim_status
change column `ï»¿claim_status_id` claim_status_id varchar(20),
modify claim_status_name varchar(30);

-- add primary key
alter table claim_status
add primary key (claim_status_id);

-- verify updated structure
desc claim_status;

# --------------------------------------------------------{ Customer Query }---------------------------------------------------------
-- display all records from customer table
select * from customer;

-- rename both column and modify data types
alter table customer
change column `ï»¿customer_id` customer_id varchar(20),
modify customer_full_name varchar(100),
modify date_of_birth date,
modify customer_age int,
modify gender varchar(10),
modify occupation varchar(50),
modify income_band varchar(30),
modify phone_number varchar(15),
modify email_address varchar(100),
modify address_line1 varchar(255),
modify city_id varchar(20);

-- add primary key
alter table customer
add primary key (customer_id);

-- verify updated structure
desc customer;

# --------------------------------------------------------{ date Query }---------------------------------------------------------
-- display all records from date table
select * from date;

-- rename bom column and modify data types
alter table date
change column `ï»¿full_date` full_date date,
modify day int,
modify month int,
modify month_name varchar(20),
modify quarter varchar(10),
modify year int;

-- add primary key
alter table date
add primary key (full_date);

-- verify updated structure
desc date;

# --------------------------------------------------------{ insurance Query }---------------------------------------------------------
-- display all records from insurance table
select * from insurance;

-- rename bom column and modify data types
alter table insurance
change column `ï»¿insurance_id` insurance_id varchar(20),
modify insurance_main_type varchar(50),
modify insurance_subtype_id varchar(20),
modify insurance_subtype_name varchar(100),
modify insurance_subtype_code varchar(20),
modify coverage_type varchar(30);

-- add primary key
alter table insurance
add primary key (insurance_id);

-- verify updated structure
desc insurance;

# --------------------------------------------------------{ loss_driver Query }---------------------------------------------------------
-- display all records from loss_driver table
select * from loss_driver;

-- rename bom column and modify data types
alter table loss_driver
change column `ï»¿loss_driver_id` loss_driver_id varchar(20),
modify loss_driver_name varchar(100);

-- add primary key
alter table loss_driver
add primary key (loss_driver_id);

-- verify updated structure
desc loss_driver;

# --------------------------------------------------------{ policy Query }---------------------------------------------------------
-- display all records from policy table
select * from policy;

-- rename bom column and modify data types
alter table policy
change column `ï»¿policy_id` policy_id varchar(20),
modify policy_number varchar(30),
modify customer_id varchar(20),
modify product_id varchar(20),
modify insurance_id varchar(20),
modify policy_start_date varchar(20),
modify policy_end_date varchar(20),
modify policy_tenure_years int,
modify policy_status varchar(30),
modify sum_insured decimal(12,2),
modify deductible_amount decimal(12,2),
modify annual_premium decimal(12,2),
modify payment_frequency varchar(20),
modify no_of_lives_covered int,
modify channel_id varchar(20),
modify agent_id varchar(20),
modify hospital_id varchar(20),
modify hospital_name varchar(100),
modify hospital_type varchar(50);

-- add primary key
alter table policy
add primary key (policy_id);

-- verify updated structure
desc policy;
# --------------------------------------------------------{ region Query }---------------------------------------------------------
-- display all records from region table
select * from region;

-- rename bom column and modify data types
alter table region
change column `ï»¿region_id` region_id varchar(20),
modify region_name varchar(50),
modify state_id varchar(20),
modify state varchar(50),
modify city_id varchar(20),
modify city varchar(50),
modify country varchar(50);

-- add primary key
alter table region
add primary key (region_id);

-- verify updated structure
desc region;

# --------------------------------------------------------{ Add this for KPI Query }---------------------------------------------------------
use bfsi_inc
SHOW TABLES;

# ===========================
-- KPI 1 - Total Claims
# ===========================

SELECT
COUNT(claim_id) AS Total_Claims
FROM claim;

-- ===========================================
-- KPI 2 : Approved Claims
-- ===========================================

SELECT
COUNT(claim_id) AS Approved_Claims
FROM claim
WHERE claim_status_group = 'Approved';

-- ===========================================
-- KPI 3 : Rejected Claims
-- ===========================================

SELECT
COUNT(claim_id) AS Rejected_Claims
FROM claim
WHERE claim_status_group = 'Rejected';


-- ===========================================
-- KPI 4 : Approval Rate (%)
-- ===========================================

SELECT
ROUND(
(
COUNT(CASE
WHEN claim_status_group = 'Approved'
THEN claim_id
END) * 100.0
)
/ COUNT(claim_id),2
) AS Approval_Rate
FROM claim;

-- ===========================================
-- KPI 5 : Total Approved Amount (₹)
-- ===========================================

SELECT
ROUND(SUM(paid_amount),2) AS Total_Approved_Amount
FROM claim
WHERE claim_status_group = 'Approved';

-- ===========================================
-- KPI 6 : High-Cost Approved Claim Ratio (%)
-- ===========================================

SELECT
ROUND(
SUM(high_cost_flag) * 100.0 / COUNT(*),
2
) AS High_Cost_Approved_Claim_Ratio
FROM claim;

/*=========================================================
  CHART 1: Approved vs Rejected Distribution (Donut Chart)
=========================================================*/

SELECT
    claim_status_group,
    COUNT(claim_id) AS total_claims
FROM claim
WHERE claim_status_group IN ('Approved', 'Rejected')
GROUP BY claim_status_group;



/*=========================================================
  CHART 2: Approved vs Rejected Trend (Month-wise Line Chart)
=========================================================*/

SELECT
    MONTHNAME(claim_month) AS `Row Labels`,

    SUM(
        CASE
            WHEN claim_status_group = 'Approved'
            THEN 1
            ELSE 0
        END
    ) AS Approved,

    SUM(
        CASE
            WHEN claim_status_group = 'Rejected'
            THEN 1
            ELSE 0
        END
    ) AS Rejected,

    COUNT(claim_id) AS `Grand Total`

FROM claim
WHERE claim_status_group IN ('Approved', 'Rejected')
GROUP BY MONTH(claim_month), MONTHNAME(claim_month)
ORDER BY MONTH(claim_month);



/*=========================================================
  CHART 3: Approved vs Rejected Amount Comparison (Column Chart)
=========================================================*/

SELECT
    claim_status_group AS `Row Labels`,

    SUM(paid_amount) AS `Sum of Paid Amount`,

    SUM(bill_amount) AS `Sum of Bill Amount`

FROM claim
WHERE claim_status_group IN ('Approved', 'Rejected')
GROUP BY claim_status_group;



/*=========================================================
  CHART 4: SLA Adherence – Approved Claims (%) (Gauge / Column Chart)
=========================================================*/

SELECT
    sla_met_flag AS `Row Labels`,

    CONCAT(
        ROUND(
            (COUNT(claim_id) * 100.0) /
            SUM(COUNT(claim_id)) OVER (),
            2
        ),
        '%'
    ) AS `SLA Adherence (%)`

FROM claim
WHERE claim_status_group = 'Approved'
GROUP BY sla_met_flag;




