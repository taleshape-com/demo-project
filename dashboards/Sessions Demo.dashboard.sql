-- shaperid:omoyip0dnyn1bmmq6ssd3hpe

SELECT 'Shaper Sessions Demo Dashboard'::SECTION;

CREATE TEMP TABLE sessions AS (
  FROM 'https://taleshape.com/sample-data/sessions.csv'
);

SELECT
  min(created_at)::DATE::DATEPICKER_FROM AS start_date,
  max(created_at)::DATE::DATEPICKER_TO AS end_date,
FROM sessions;

SELECT 'Category'::LABEL;
SELECT category::DROPDOWN_MULTI AS category
FROM sessions GROUP BY category ORDER BY category;

CREATE TEMP TABLE dataset AS (
  SELECT * FROM sessions
    WHERE category IN getvariable('category')
      AND created_at BETWEEN getvariable('start_date')
                         AND getvariable('end_date')
);

SELECT ('sessions-' || today())::DOWNLOAD_CSV AS "CSV";
SELECT * FROM dataset;

SELECT count(*) AS "Total Sessions" FROM dataset;

SELECT 'Summary'::LABEL;
SELECT
  category AS "Category",
  count(*) AS "Sessions",
  to_seconds(round(avg(duration))) AS "Avg Duration",
FROM dataset GROUP BY "Category" ORDER BY "Sessions" DESC;

SELECT 'Sessions By Time of Day'::LABEL;
SELECT
  date_trunc('hour', created_at)::TIME::XAXIS AS "Time of Day",
  count(*)::BARCHART AS "Total Sessions",
FROM dataset GROUP BY ALL ORDER BY ALL;

SELECT ''::SECTION;

SELECT 'Sessions per Week'::LABEL;
SELECT
  date_trunc('week', created_at)::XAXIS,
  category::CATEGORY,
  count(*)::BARCHART_STACKED,
FROM dataset GROUP BY ALL ORDER BY ALL;

SELECT 'Average Session Duration per Week'::LABEL;
SELECT
  date_trunc('week', created_at)::XAXIS,
  category::CATEGORY,
  to_seconds(round(avg(duration)))::LINECHART,
FROM dataset GROUP BY ALL ORDER BY ALL;
