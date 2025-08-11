Create or Alter Procedure bronze.load_bronze as 
Begin
Declare @start_time Datetime, @end_time Datetime;
Begin Try


Print '================================';
Print 'Loading Bronze Layer';
Print '================================';


Print '--------------------------------';
Print 'Loading CRM Tables';
Print '--------------------------------';


Set @start_time = GETDATE();
Truncate Table bronze.crm_cust_info
Bulk Insert bronze.crm_cust_info
From 'F:\sqlserver\Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
With (
	Firstrow = 2,
	FieldTerminator = ',',
	Tablock
);
Set @end_time = GETDATE();
Print '>> Load Duration:' + Cast(Datediff(second,@start_time,@end_time) as nvarchar) + 'Seconds';
Print '------------------------------';
--------------------------

Set @start_time = GETDATE();
Truncate Table bronze.crm_prd_info
Bulk Insert bronze.crm_prd_info
From 'F:\sqlserver\Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
With (
	Firstrow = 2,
	FieldTerminator = ',',
	Tablock
);
Set @end_time = GETDATE();
Print '>> Load Duration:' + Cast(Datediff(second,@start_time,@end_time) as nvarchar) + 'Seconds';
Print '------------------------------';
-------------------------------

Set @start_time = GETDATE();
Truncate Table bronze.crm_sales_details
Bulk Insert bronze.crm_sales_details
From 'F:\sqlserver\Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
With (
	Firstrow = 2,
	FieldTerminator = ',',
	Tablock
);
Set @end_time = GETDATE();
Print '>> Load Duration:' + Cast(Datediff(second,@start_time,@end_time) as nvarchar) + 'Seconds';
Print '------------------------------';
-----------------------------------


Print '--------------------------------';
Print 'Loading ERP Tables';
Print '--------------------------------';

Set @start_time = GETDATE();
Truncate Table bronze.erp_cust_az12
Bulk Insert bronze.erp_cust_az12
From 'F:\sqlserver\Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
With (
	Firstrow = 2,
	FieldTerminator = ',',
	Tablock
);
Set @end_time =GETDATE();
Print '>> Load Duration:' + Cast(Datediff(second,@start_time,@end_time) as nvarchar) + 'Seconds';
Print '------------------------------';
---------------------------------
Set @start_time = GETDATE();
Truncate Table bronze.erp_loc_a101
Bulk Insert bronze.erp_loc_a101
From 'F:\sqlserver\Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
With (
	Firstrow = 2,
	FieldTerminator = ',',
	Tablock
);
set @end_time = GETDATE();
Print '>> Load Duration:' + Cast(Datediff(second,@start_time,@end_time) as nvarchar) + 'Seconds'
Print '------------------------------'
----------------------------------
set @start_time = GETDATE();
Truncate Table bronze.erp_px_cat_g1v2
Bulk Insert bronze.erp_px_cat_g1v2
From 'F:\sqlserver\Project\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
With (
	Firstrow = 2,
	FieldTerminator = ',',
	Tablock
);
Set @end_time =GETDATE();
Print '>> Load Duration:' + Cast(Datediff(second,@start_time,@end_time) as nvarchar) + 'Seconds'
Print '------------------------------'


End Try
Begin Catch
Print '=========================================';
Print 'ERROR OCCURED DURING LOADING OF BRONZE LAYOR';
Print 'Error Message' + Error_Message(); 
Print 'Error Message' + Cast(Error_number() as nvarchar);
Print '=========================================';
Print 'Error Message' + Cast(Error_State() as nvarchar);

End Catch
End
















