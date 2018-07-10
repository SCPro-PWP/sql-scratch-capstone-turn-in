# Campaign info tables

SELECT DISTINCT utm_campaign AS 'Marketing Campaign'
FROM page_visits;

SELECT DISTINCT utm_source AS 'Marketing Source'
FROM page_visits;

SELECT DISTINCT utm_campaign AS 'Marketing Campaign',
  utm_source AS 'Marketing Source'
FROM page_visits;



# Number of campaigns and sources

SELECT COUNT(DISTINCT utm_campaign) AS 'Campaign Count'
FROM page_visits;

SELECT COUNT(DISTINCT utm_source) AS 'Campaign Source'
FROM page_visits;



# CoolTShirts.com page names 

SELECT DISTINCT page_name AS 'Page Names'
FROM page_visits;



#First touch query

WITH first_touch AS (
  SELECT user_id,
    MIN(timestamp) AS 'first_touch_at'
  FROM page_visits
  GROUP BY user_id),
ft_attr AS (
  SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
    pv.utm_campaign
  FROM first_touch AS 'ft'
  JOIN page_visits AS 'pv'
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
)
SELECT ft_attr.utm_source AS 'First Touch Source',
  ft_attr.utm_campaign AS 'First Touch Campaign',
  COUNT(*) AS 'No. of Users'
FROM ft_attr
GROUP BY 1, 2
ORDER BY 3 DESC;



#Last touch query

WITH last_touch AS (
  SELECT user_id,
    MAX(timestamp) AS 'last_touch_at'
  FROM page_visits
  GROUP BY user_id),
lt_attr AS (
  SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
    pv.utm_campaign
  FROM last_touch AS 'lt'
  JOIN page_visits AS 'pv'
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source AS 'Last Touch Source',
  lt_attr.utm_campaign AS 'Last Touch Campaign',
  COUNT(*) AS 'No. of Users'
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;



# Number of visitors to purchase page 

SELECT COUNT(DISTINCT user_id) AS 'Vistors Make Purchase'
FROM page_visits
WHERE page_name = '4 - purchase';



# Last touch query on purchase page

WITH last_touch AS (
  SELECT user_id,
    MAX(timestamp) AS 'last_touch_at'
  FROM page_visits
  WHERE page_name = '4 - purchase'
  GROUP BY user_id),
lt_attr AS (
  SELECT lt.user_id,
    lt.last_touch_at,
    pv.utm_source,
    pv.utm_campaign
  FROM last_touch AS 'lt'
  JOIN page_visits AS 'pv'
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt_attr.utm_source AS 'Source - Purchase Page',
  lt_attr.utm_campaign AS 'Campaign - Purchase Page',
  COUNT(*) AS 'No. of Users'
FROM lt_attr
GROUP BY 1, 2
ORDER BY 3 DESC;