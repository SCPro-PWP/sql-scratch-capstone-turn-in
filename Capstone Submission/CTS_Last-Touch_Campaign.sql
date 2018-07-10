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
