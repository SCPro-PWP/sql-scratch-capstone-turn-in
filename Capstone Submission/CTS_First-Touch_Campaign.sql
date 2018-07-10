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
