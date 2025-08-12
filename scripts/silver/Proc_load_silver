
Create or Alter Procedure silver.load_silver As
Begin
Begin Try
Declare @starttime Datetime, @EndTime Datetime

Print '================================';
Print 'Loading Silver Layer';
Print '================================';


Print '--------------------------------';
Print 'Loading CRM Tables';
Print '--------------------------------';

Set @starttime = GETDATE();
Print '>> Truncating Table: silver.crm_cust_info';
Truncate Table silver.crm_cust_info;
Print '>> Inserting Data Into: silver.crm_cust_info';
Insert into silver.crm_cust_info(
cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_marital_status,
cst_gndr,
cst_create_date
)

Select 
cst_id,
cst_key,
Trim(cst_firstname) as cst_firstname ,
Trim(cst_lastname) as cst_lastname,
case 
	when Trim(cst_marital_status) = 'M' then 'Married'
	when Trim(cst_marital_status) ='S'then 'Single'
	else 'N/A'
End as cst_marital_status,
case 
	when Trim(cst_gndr) = 'M' then 'Male'
	when Trim(cst_gndr) ='F'then 'Female'
	else 'N/A'
End as cst_gndr,
cst_create_date
from
(
Select *,
ROW_NUMBER() over(partition by cst_id order by cst_create_date) as Flagdate
from bronze.crm_cust_info) t 
where Flagdate = 1;
Set @EndTime = GETDATE();
Print 'Load Duration:' +  Cast(Datediff(second,@starttime, @EndTime) as nvarchar) + 'seconds';
------------------------------------------------------------------
Set @starttime = GETDATE();
Print '>> Truncating Table: silver.crm_prd_info'
Truncate Table silver.crm_prd_info;
Print '>>Inserting Data Into: silver.crm_prd_info'
Insert into silver.crm_prd_info(
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	Prd_start_dt,
	prd_end_dt
)

select 
prd_id,
Replace(Substring(prd_key, 1, 5),'-', '_') as cat_id,
SUBSTRING(prd_key, 7, len(prd_key)) as prd_key,
prd_nm,
Isnull(prd_cost, 0) as prd_cost,
Case UPPER(TRIM(prd_line))
when 'M' then 'Mountain'
when 'R' then 'Road'
when 'S' then 'Other Sales'
when 'T' then 'Touring'
Else 'N/A'
End as prd_line,
Cast(Prd_start_dt as date) as Prd_start_dt,
Cast(Lead(Prd_start_dt) over (partition by prd_key order by prd_start_dt) -1 as date) as prd_end_test
from bronze.crm_prd_info
Set @EndTime = GETDATE();
Print 'Load Duration:' +  Cast(Datediff(second,@starttime,@EndTime) as nvarchar) + 'seconds';
--------------------------------------------------------------------------
Set @starttime = GETDATE()
Print '>> Truncating Table: silver.crm_sales_details'
Truncate Table silver.crm_sales_details
Print '>> Inserting Data Into: silver.crm_sales_details'
Insert into silver.crm_sales_details(
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt,
	sls_sales,
	sls_quantity,
	sls_price
)
Select 
sls_ord_num,
sls_prd_key,
sls_cust_id,

Case 
	When sls_order_dt = 0 or len(sls_order_dt) != 8 Then Null
	Else CAST(CAST(sls_order_dt as varchar) as date)
End as sls_order_dt,
Case 
	When sls_ship_dt = 0 or len(sls_ship_dt) != 8 Then Null
	Else CAST(CAST(sls_ship_dt as varchar) as date)
End as sls_ship_dt,
Case 
	When sls_due_dt = 0 or len(sls_due_dt) != 8 Then Null
	Else CAST(CAST(sls_due_dt as varchar) as date)
End as sls_due_dt,
Case 
	when sls_sales is Null or sls_sales <=0 or sls_sales != sls_quantity * ABS(sls_price) 
	Then sls_quantity * Abs(sls_price)
	Else sls_sales
End as sls_sales,
sls_quantity,
Case 
	when sls_price is Null or sls_price <=0  
	Then sls_sales / Nullif(sls_quantity,0)
	Else sls_price
End as sls_price
from bronze.crm_sales_details
Set @EndTime = GETDATE();
Print 'Load Duration:' +  Cast(Datediff(second,@starttime,@EndTime) as nvarchar) + 'seconds';
-----------------------------------------------------------
Set @starttime = GETDATE()
Print '--------------------------------';
Print 'Loading ERP Tables';
Print '--------------------------------';


Print '>> Truncating Table: silver.erp_cust_az12'
Truncate Table silver.erp_cust_az12
Print '>> Inserting Data Into: silver.erp_cust_az12'

Insert into silver.erp_cust_az12(cid,bdate,gen)
select 
Case 
	When cid Like 'NAS%' Then SUBSTRING(cid, 4, LEN(cid))
	Else cid
End As cid,
Case
When bdate > GETDATE()  Then Null
Else bdate
End as bdate,
case 
	When Upper(Trim(gen)) IN ('M', 'MALE') Then 'Male'
	When Upper(Trim(gen)) IN ('F', 'FEMALE') Then 'Female'
	Else 'N/A'
End As gen
from bronze.erp_cust_az12
Set @EndTime = GETDATE()
Print 'Load Duration:' +  Cast(Datediff(second,@starttime,@EndTime) as nvarchar) + 'seconds'
------------------------------------------------------
Set @starttime = GETDATE();
Print '>> Truncating Table: silver.erp_px_cat_g1v2'

Truncate Table silver.erp_px_cat_g1v2
Print '>> Inserting Data Into: silver.erp_px_cat_g1v2'
Insert into silver.erp_px_cat_g1v2
(id,cat,subcat,maintenance)
select 
id,
cat,
subcat,
maintenance
from bronze.erp_px_cat_g1v2
Set @EndTime = GETDATE();
Print 'Load Duration:' +  Cast(Datediff(second,@starttime,@EndTime) as nvarchar) + 'seconds'
------------------------------------------------------
Set @starttime = GETDATE()
Print '>> Truncating Table: silver.erp_loc_a101';
Truncate Table silver.erp_loc_a101
Print '>> Inserting Data Into: silver.erp_loc_a101';

Insert into silver.erp_loc_a101(cid, cntry)
Select 
Trim(REPLACE(cid, '-', '')) as cid,
Case 
	When Trim(cntry) = 'DE' Then 'Germany'
	When Trim(Cntry) In ('US','USA') Then 'United States'
	When Trim(cntry) is Null or cntry = ' ' Then 'N/A'
	Else Trim(cntry)
End as cntry
from bronze.erp_loc_a101
Set @EndTime = GETDATE()
Print 'Load Duration:' +  Cast(Datediff(second,@starttime,@EndTime) as nvarchar) + 'seconds'

End Try

Begin Catch
Print '=========================================';
Print 'ERROR OCCURED DURING LOADING OF BRONZE LAYOR';
Print 'Error Message:' + Error_Message(); 
Print 'Error Message:' + Cast(Error_number() as nvarchar);
Print '=========================================';
Print 'Error Message:' + Cast(Error_State() as nvarchar);

End Catch
End


--Exec silver.load_silver

