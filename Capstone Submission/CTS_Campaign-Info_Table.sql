SELECT DISTINCT utm_campaign AS 'Marketing Campaign'
FROM page_visits;

SELECT DISTINCT utm_source AS 'Marketing Source'
FROM page_visits;

SELECT DISTINCT utm_campaign AS 'Marketing Campaign',
  utm_source AS 'Marketing Source'
FROM page_visits;
