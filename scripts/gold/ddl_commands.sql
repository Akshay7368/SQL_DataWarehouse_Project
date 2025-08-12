
Drop view if Exists gold.dim_products
Go
Create view gold.dim_products as 
Select 
	ROW_NUMBER() over(order by pr.prd_key) as product_key, 
	pr.prd_id as product_id,
	pr.prd_key as product_number,
	pr.prd_nm as product_name,
	pr.cat_id as category_id,
	px.cat as category,
	px.subcat as subcategory,
	px.maintenance as maintenance,
	pr.prd_cost as cost,
	pr.prd_line as product_line,
	pr.Prd_start_dt as start_date
from silver.crm_prd_info as pr
Left Join silver.erp_px_cat_g1v2 as px
on pr.cat_id = px.id
where prd_end_dt is Null  -- This will filter out and give the current data of the product

------------------------------------------------------
Drop View if Exists gold.dim_customers
Go
Create View gold.dim_customers as 
Select 
ROW_NUMBER() over(order by ci.cst_id) as Customer_key,
ci.cst_id as customer_id,
ci.cst_key as customer_number,
ci.cst_firstname as first_name,
ci.cst_lastname as last_name,
la.cntry as country,
ci.cst_marital_status as marital_status,
Case 
	When ci.cst_gndr != 'N/A' Then ci.cst_gndr
	Else Coalesce(ca.gen,'N/A')
End as gender,
ca.bdate as birth_date,
ci.cst_create_date as create_date
from silver.crm_cust_info As ci
Left Join silver.erp_cust_az12 AS ca
on ci.cst_key = ca.cid
Left Join silver.erp_loc_a101 as la
on ci.cst_key = la.cid

------------------------------------------------------
Drop View if Exists gold.fact_sales
Go
Create view gold.fact_sales as 
select 
sd.sls_ord_num as order_number,
pd.product_key,
cu.Customer_key,
sd.sls_order_dt as order_date,
sd.sls_ship_dt as shipping_date,
sd.sls_due_dt as due_date,
sd.sls_sales as sales,
sd.sls_quantity as quantity,
sd.sls_price as price
from silver.crm_sales_details as sd
Left Join gold.dim_products as pd
on sd.sls_prd_key = pd.product_number
Left Join gold.dim_customers as cu
on sd.sls_cust_id = cu.customer_id











































