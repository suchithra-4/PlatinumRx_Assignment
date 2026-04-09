SELECT sales_channel, SUM(amount) AS revenue
FROM clinic_sales
GROUP BY sales_channel;


--> 2 Q2: Monthly Revenue
SELECT MONTH(sale_date) AS month, SUM(amount) AS revenue
FROM clinic_sales
GROUP BY month;

--> 3 Q3: Profit / Loss
SELECT 
    r.month,
    r.revenue,
    e.expense,
    (r.revenue - e.expense) AS profit
FROM
    (SELECT MONTH(sale_date) AS month, SUM(amount) AS revenue
     FROM clinic_sales GROUP BY month) r
JOIN
    (SELECT MONTH(expense_date) AS month, SUM(amount) AS expense
     FROM expenses GROUP BY month) e
ON r.month = e.month;