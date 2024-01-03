select * from cadata.cancertable;

SELECT COUNT(*) AS NumberOfRecords
FROM cadata.cancertable;

SELECT *
FROM cadata.cancertable
where Surgery!='Breast'
ORDER BY nCases DESC
LIMIT 5;

SELECT Surgery, COUNT(*) AS SurgeryCount
FROM cadata.cancertable
where nCases!=0
GROUP BY Surgery
ORDER BY SurgeryCount DESC;

SELECT Surgery, COUNT(*) AS SurgeryCount
FROM cadata.cancertable
GROUP BY Surgery
ORDER BY SurgeryCount DESC;


SELECT Year, Surgery, County
FROM (
    SELECT 
        Year, Surgery, County,
        ROW_NUMBER() OVER (PARTITION BY Year, Surgery ORDER BY nCases DESC) AS row_num
    FROM cadata.cancertable
) ranked
WHERE row_num <= 3;

select * from cadata.cancertable
order by nCases desc
limit 5;

WITH RankedCounties AS (
    SELECT
        Year,
        Surgery,
        County,
        nCases,
        ROW_NUMBER() OVER (PARTITION BY Year, Surgery ORDER BY nCases DESC) AS RowNum
    FROM
        cadata.cancertable 
)
SELECT
    Year,
    Surgery,
    County,
    nCases
FROM
    RankedCounties
WHERE
    RowNum <= 3;
    