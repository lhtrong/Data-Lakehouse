CREATE TABLE IF NOT EXISTS Part_Maker (
  part_maker_id INT ,
  name VARCHAR(50)
) WITH (
  external_location = 's3a://datalake/bronze/CarPartsDB/Jun-06-2023/Part_Maker',
  format = 'parquet'
);

CREATE TABLE IF NOT EXISTS Part (
  part_id INT ,
  brand_id INT,
  supplier_id INT,
  part_group_id INT, 
  part_maker_id INT,
  part_name VARCHAR(50),
  main_supplier_name VARCHAR(50),
  price_to_us INT,
  price_to_customer INT
) WITH (
  external_location = 's3a://datalake/bronze/CarPartsDB/Jun-06-2023/Part',
  format = 'parquet'
);

CREATE TABLE IF NOT EXISTS Part_for_Car (
  car_id INT,
  part_id INT
) WITH (
  external_location = 's3a://datalake/bronze/CarPartsDB/Jun-06-2023/Part_for_Car',
  format = 'parquet'
);

CREATE TABLE IF NOT EXISTS Part_Supplier (
  part_supplier_id INT ,
  part_id INT,
  supplier_id INT
) WITH (
  external_location = 's3a://datalake/bronze/CarPartsDB/Jun-06-2023/Part_Supplier',
  format = 'parquet'
);

CREATE TABLE IF NOT EXISTS Part_in_Order (
  part_in_order_id INT,
  order_id INT,
  part_supplier_id INT,
  actual_sale_price INT,
  quantity INT
) WITH (
  external_location = 's3a://datalake/bronze/CarPartsDB/Jun-06-2023/Part_in_Order',
  format = 'parquet'
);