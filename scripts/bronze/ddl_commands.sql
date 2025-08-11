



Drop Table If Exists bronze.crm_cust_info
Go
Create table bronze.crm_cust_info(
	cst_id int,
	cst_key Varchar(50),
	cst_firstname Varchar(50),
	cst_lastname Varchar(50),
	cst_material_status NVarchar(50),
	cst_gndr NVarchar(50),
	cst_create_date Date
);
----------------------
Drop Table If Exists bronze.crm_prd_info
Go
Create Table bronze.crm_prd_info(
	prd_id Int,
	prd_key Nvarchar(50),
	prd_nm Nvarchar(50),
	prd_cost Int,
	prd_line Nvarchar(50),
	Prd_start_dt Datetime,
	prd_end_dt Datetime
);

-----------------------
Drop Table If Exists bronze.crm_sales_details
Go
Create Table bronze.crm_sales_details(
sls_ord_num varchar(50),
sls_prd_key Nvarchar(50),
sls_cust_id Int,
sls_order_dt Int,
sls_ship_dt Int,
sls_due_dt Int,
sls_sales Int,
sls_quantity int,
sls_price Int
);

------------------------
Drop Table If Exists bronze.erp_loc_a101
Go
Create Table bronze.erp_loc_a101(
	cid Nvarchar(50),
	cntry Nvarchar(50)
);

---------------------------
Drop Table If Exists bronze.erp_cust_az12
Go
Create Table bronze.erp_cust_az12(
	cid Nvarchar(50),
	bdate Date,
	gen Nvarchar(50)
);

----------------------------
Drop Table If Exists bronze.erp_px_cat_g1v2
Go
Create Table bronze.erp_px_cat_g1v2(
	id Nvarchar(50),
	cat Nvarchar(50),
	subcat Nvarchar(50),
	maintenance Nvarchar(50)

);









































