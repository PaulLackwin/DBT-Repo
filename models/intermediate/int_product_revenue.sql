WITH transaction_revenue AS (
  SELECT
    t.PRODUCTID,
    SUM(t.TOTALAMOUNT) AS total_revenue
  FROM
    {{ ref('stg_transaction') }} t
  GROUP BY
    t.PRODUCTID
)

SELECT
  p.*,
  tr.total_revenue 
FROM
  {{ ref('stg_product') }} p
LEFT JOIN
  transaction_revenue tr ON p.PRODUCTID = tr.PRODUCTID
WHERE
  tr.total_revenue IS NOT NULL
ORDER BY
  tr.total_revenue ASC
