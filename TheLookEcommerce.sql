-- Data analysis using SQL on The Look e-commerce data. The Look e-commerce database is a public database provided on BigQuery. The tables used in this analysis are the orders, order_items, and products tables.

-- Displays the best selling products
SELECT
  b.product_id,
  c.name AS name_product,
  ROUND(c.cost) AS cost,
  ROUND(c.retail_price) AS retail_price,
  SUM(b.sale_price) AS total_sale
FROM
  bigquery-public-data.thelook_ecommerce.orders AS a
INNER JOIN
  bigquery-public-data.thelook_ecommerce.order_items AS b ON a.order_id = b.order_id
INNER JOIN
  bigquery-public-data.thelook_ecommerce.products AS c ON b.product_id = c.id
WHERE
  b.status = 'Complete'
GROUP BY
  b.product_id,
  c.name,
  c.cost,
  c.retail_price
ORDER BY
  total_sale DESC
LIMIT 10;

-- Displays the top 10 categories with the best sales
SELECT
  c.category,
  ROUND(SUM(b.sale_price)) AS total_sale,
  SUM(a.num_of_item) AS total_item
FROM
  bigquery-public-data.thelook_ecommerce.orders AS a
INNER JOIN
  bigquery-public-data.thelook_ecommerce.order_items AS b ON a.order_id = b.order_id
INNER JOIN
  bigquery-public-data.thelook_ecommerce.products AS c ON b.product_id = c.id
WHERE
  b.status = 'Complete'
GROUP BY
  c.category
ORDER BY
  total_sale DESC
LIMIT 10;

-- Displays the top 10 most returned products
SELECT
  c.category,
  ROUND(SUM(b.sale_price)) AS total_sale,
  SUM(a.num_of_item) AS total_item
FROM
  bigquery-public-data.thelook_ecommerce.orders AS a
INNER JOIN
  bigquery-public-data.thelook_ecommerce.order_items AS b ON a.order_id = b.order_id
INNER JOIN
  bigquery-public-data.thelook_ecommerce.products AS c ON b.product_id = c.id
WHERE
  b.status = 'Return'
GROUP BY
  c.category
ORDER BY
  total_item DESC
LIMIT 10;

-- Displays data trends per month and per year
SELECT
  EXTRACT(YEAR FROM a.created_at) AS year,
  EXTRACT(MONTH FROM a.created_at) AS month,
  ROUND(SUM(b.sale_price)) AS total_sale,
  SUM(a.num_of_item) AS total_item,
FROM
  bigquery-public-data.thelook_ecommerce.orders AS a
INNER JOIN
  bigquery-public-data.thelook_ecommerce.order_items AS b ON a.order_id = b.order_id
INNER JOIN
  bigquery-public-data.thelook_ecommerce.products AS c ON b.product_id = c.id
WHERE
  b.status = 'Complete'
GROUP BY 
  year,
  month
ORDER BY
  year,
  month;

-- Displays data trends based on status per month and per year
SELECT
  EXTRACT(YEAR FROM a.created_at) AS year,
  EXTRACT(MONTH FROM a.created_at) AS month,
  ROUND(SUM(b.sale_price)) AS total_sale,
  SUM(a.num_of_item) AS total_item,
  b.status
FROM
  bigquery-public-data.thelook_ecommerce.orders AS a
INNER JOIN
  bigquery-public-data.thelook_ecommerce.order_items AS b ON a.order_id = b.order_id
INNER JOIN
  bigquery-public-data.thelook_ecommerce.products AS c ON b.product_id = c.id
GROUP BY 
  b.status,
  year,
  month
ORDER BY
  year,
  month;

-- Displays total items and purchases according to user gender
SELECT
  a.user_id,
  a.gender,
  SUM(a.num_of_item) AS total_item,
  ROUND(SUM(b.sale_price)) AS total_sale
FROM
  bigquery-public-data.thelook_ecommerce.orders AS a
INNER JOIN
  bigquery-public-data.thelook_ecommerce.order_items AS b ON a.order_id = b.order_id
WHERE
  b.status = 'Complete'
GROUP BY 
  a.user_id,
  a.gender
ORDER BY
  a.user_id;

-- Displays the top 10 users based on total sales
SELECT
  a.user_id,
  SUM(a.num_of_item) AS total_item,
  ROUND(SUM(b.sale_price)) AS total_sale
FROM
  bigquery-public-data.thelook_ecommerce.orders AS a
INNER JOIN
  bigquery-public-data.thelook_ecommerce.order_items AS b ON a.order_id = b.order_id
WHERE
  b.status = 'Complete'
GROUP BY 
  a.user_id
ORDER BY
  total_sale DESC
LIMIT 10;
  
-- Displays the top 10 users from total sales
SELECT
  a.user_id,
  SUM(a.num_of_item) AS total_item
FROM
  bigquery-public-data.thelook_ecommerce.orders AS a
INNER JOIN
  bigquery-public-data.thelook_ecommerce.order_items AS b ON a.order_id = b.order_id
WHERE
  b.status = 'Complete'
GROUP BY 
  a.user_id
ORDER BY
  total_item DESC
LIMIT 10;