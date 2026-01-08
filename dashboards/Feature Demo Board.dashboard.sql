-- shaperid:d0uttrsce5i0lik6gg9rux8r

CREATE TEMP TABLE timestamp_data AS (
  SELECT
    d,
    round(random() * 100) AS n
  FROM generate_series(DATE '2025-07-01', DATE '2026-05-30', INTERVAL '3' MONTH) dates(d)
);

CREATE TEMP VIEW category_data AS (
  VALUES
  ('AAA', 1, 10),
  ('BBB', 1, 15),
  ('CCC', 1, 13),
  ('AAA', 2, 25),
  ('BBB', 2, 10),
  ('CCC', 2, 15),
  ('AAA', 3, 30),
  ('BBB', 3, 20),
  ('CCC', 3, 36),
);



SELECT 'https://taleshape.com/images/logo-h36.webp'::HEADER_IMAGE;


SELECT 'Shaper Feature Demo Board'::SECTION;


SELECT ('myboard-' || today())::DOWNLOAD_PDF AS "PDF";
SELECT ('myboard-' || today())::DOWNLOAD_PDF AS "PDF";

SELECT ('mydata-' || today())::DOWNLOAD_CSV AS "CSV";
SELECT * FROM timestamp_data;

SELECT ('mydata-' || today())::DOWNLOAD_XLSX AS "Excel";
SELECT * FROM timestamp_data;


SELECT 'Welcome!' AS 'The SQL is here on Github: https://github.com/taleshape-com/demo-project';


SELECT 'Single Value'::SECTION;

SELECT 123 AS Number;

SELECT 'PERCENT'::LABEL;
SELECT 0.42::PERCENT;

SELECT 'COMPARE'::LABEL;
SELECT
  100,
  75::COMPARE AS Previous;


SELECT 'This is a longer description text.

It spans over multiple lines.
The format adapts to display longer text.

This might be useful to add some description below or next to a graphic.';


SELECT 'Tables'::SECTION;

SELECT 'Table Title'::LABEL;
SELECT
  col0 AS Name,
  col1::PERCENT AS Percent,
  col2::INTERVAL AS Duration
FROM (
  VALUES
  ('One', 0.1, '1h'),
  ('Two', 0.2, '20min'),
  ('Three', 0.3, '20min 10s'),
  ('Four', 0.4, '4days 3hours'),
);

SELECT 'Table with Trend'::LABEL;
SELECT
  d AS Date,
  n AS Number,
  (n / lag(n) OVER (ORDER BY d))::TREND AS Trend
FROM timestamp_data
ORDER BY Date;


SELECT 'Pie and Donut Charts'::SECTION;

SELECT 'DONUTCHART'::LABEL;
SELECT col1::DONUTCHART AS "My Number", col0::CATEGORY
FROM (
  VALUES
    ('One', 5728),
    ('Two', 2854),
    ('Three', 2152),
    ('Four', 2044),
    ('Five', 702),
);

SELECT 'PIECHART'::LABEL;
SELECT col1::PIECHART AS "My Number", col0::CATEGORY, col2 AS "Extra Data"
FROM (
  VALUES
    ('One', 5728, 'Some extra data'),
    ('Two', 2854, 'More data'),
    ('Three', 2152, NULL),
    ('Four', 2044, NULL),
    ('Five', 702, NULL),
);

SELECT 'DONUTCHART_PERCENT'::LABEL;
SELECT col1::DONUTCHART_PERCENT AS "Percentage", col0::CATEGORY
FROM (
  VALUES
    ('One', 0.4),
    ('Two', 0.2),
    ('Three', 0.1),
);

SELECT 'PIECHART with COLOR'::LABEL;
SELECT col1::PIECHART AS "My Number", col0::CATEGORY, col2::COLOR
FROM (
  VALUES
    ('Bad', 5728, '#f55d5d'),
    ('Okay', 2854, '#fbd953'),
    ('Good', 2152, '#48af45'),
);


SELECT 'Gauges'::SECTION;

SELECT 'GAUGE'::LABEL;
SELECT 8::GAUGE, [0, 10]::RANGE;

SELECT 'GAUGE_PERCENT'::LABEL;
SELECT 0.36::GAUGE_PERCENT;

SELECT 'GAUGE with RANGE, LABELS and COLORS'::LABEL;
SELECT
    75::GAUGE,
    [0,     33,        66,       100]::RANGE,
    ['Bad',        'Okay',    'Good']::LABELS,
    ['#f55d5d', '#fbd953', '#48af45']::COLORS;


SELECT 'Line Charts'::SECTION;

SELECT 'LINECHART with XLINE'::LABEL;
SELECT '2025-11-28'::DATE::XLINE, 'Black Friday'::LABEL;
SELECT
  d::XAXIS,
  n::LINECHART,
  monthname(d) AS "Month"
FROM timestamp_data;

SELECT 'LINECHART with YLINE'::LABEL;
SELECT 65::YLINE, 'Goal'::LABEL;
SELECT
  col0::CATEGORY,
  col1::XAXIS,
  col2::LINECHART,
FROM category_data;


SELECT 'LINECHART_PERCENT'::LABEL;
SELECT 65::YLINE, 'Goal'::LABEL;
SELECT
  col0::XAXIS,
  col1::LINECHART_PERCENT,
FROM (
  VALUES
  ('One', 0.17),
  ('Two', 0.43),
  ('Three', 0.82),
);


SELECT 'Bar Charts'::SECTION;

SELECT 'BARCHART_STACKED'::LABEL;
SELECT
  col0::CATEGORY,
  col1::XAXIS,
  col2::BARCHART_STACKED,
FROM category_data;

SELECT 'BARCHART with YAXIS'::LABEL;
SELECT
  col0::YAXIS,
  col1::BARCHART,
FROM (
  VALUES
  ('One', 10),
  ('Two', 20),
  ('Three', 30),
);

SELECT 'BARCHART with COLOR'::LABEL;
SELECT
  col0::CATEGORY,
  col1::XAXIS,
  col2::BARCHART,
  (CASE col0 WHEN 'BBB' THEN '#37b19dff' ELSE '#e7de3eff' END)::COLOR,
FROM category_data;

SELECT 'BARCHART_PERCENT'::LABEL;
SELECT
  col0::XAXIS,
  col1::BARCHART_PERCENT,
FROM (
  VALUES
  ('One', 0.55),
  ('Two', 0.22),
  ('Three', 0.88),
);

SELECT 'Boxplots'::SECTION;

SELECT 'BOXPLOT with COLOR'::LABEL;
SELECT col0::XAXIS, BOXPLOT(col1), col2::COLOR
FROM (
  VALUES
  ('One', 10, '#f55d5d'),
  ('One', 20, '#f55d5d'),
  ('One', 30, '#f55d5d'),
  ('One', 40, '#f55d5d'),
  ('One', 50, '#f55d5d'),
  ('Two', 15, '#48af45'),
  ('Two', 25, '#48af45'),
  ('Two', 40, '#48af45'),
  ('Two', 45, '#48af45'),
  ('Two', 65, '#48af45'),
)
GROUP BY col0, col2 ORDER BY col0;

SELECT 'BOXPLOT with Outliers'::LABEL;
SELECT col0::XAXIS, BOXPLOT(col1, outlier_info := MAP {'Customer': col2})
FROM (
  VALUES
  ('One', 10, ''),
  ('One', 20, ''),
  ('One', 30, ''),
  ('One', 40, ''),
  ('One', 50, ''),
  ('One', 90, 'Unicorn Inc.'),
  ('Two', 15, ''),
  ('Two', 25, ''),
  ('Two', 40, ''),
  ('Two', 45, ''),
  ('Two', 65, ''),
)
GROUP BY col0, ORDER BY col0;

SELECT ''::PLACEHOLDER;


SELECT 'Filters'::SECTION;

SELECT 'DROPDOWN_MULTI'::LABEL;
SELECT col0::DROPDOWN_MULTI AS categories
FROM category_data GROUP BY col0 ORDER BY col0;

SELECT 'DROPDOWN'::LABEL;
SELECT col0::DROPDOWN AS category
FROM category_data GROUP BY col0 ORDER BY col0;

SELECT 'DATEPICKER'::LABEL;
SELECT
  (today())::DATEPICKER AS date;

SELECT 'Date Range Picker'::LABEL;
SELECT
  (today() - INTERVAL '1 year')::DATE::DATEPICKER_FROM AS start_date,
  (today())::DATEPICKER_TO AS end_date;

SELECT 'INPUT'::LABEL;
SELECT 'Placeholder'::INPUT AS input;

SELECT 'DROPDOWN_MULTI'::LABEL;
SELECT getvariable('categories');
SELECT 'DROPDOWN'::LABEL;
SELECT getvariable('category');
SELECT 'DATEPICKER'::LABEL;
SELECT getvariable('date');
SELECT 'Date Range Picker'::LABEL;
SELECT getvariable('start_date');
SELECT getvariable('end_date');
SELECT 'INPUT'::LABEL;
SELECT getvariable('input');


SELECT 'taleshape.com'::FOOTER_LINK;

