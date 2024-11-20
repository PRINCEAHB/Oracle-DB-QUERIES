-- Create sample tables (for demonstration purposes)
CREATE TABLE #temp3 (
    id INT PRIMARY KEY,
    value_tem INT
);

CREATE TABLE #dual (
    id INT PRIMARY KEY,
    value_dual INT
);

-- Insert sample data
INSERT INTO #temp4 (id, value_tem) VALUES (4, 86467);
INSERT INTO #dual (id, value_dual) VALUES (4, 112586);

-- Perform a calculation using a JOIN
SELECT t4.id,
       t4.value_tem,
       d4.value_dual,
       t4.value_tem + d4.value_dual AS calculated_value
FROM #temp4 t4
JOIN #dual d4 ON t4.id = d4.id
where t4.id =4;

select 86467 + 112586

select * from #temp_Add


-- To get a list of all tables in the master schema
 -- Use the appropriate database
SELECT *--table_name
FROM information_schema.tables
WHERE table_type = 'BASE TABLE';

delete FROM information_schema.tables
WHERE table_type = 'BASE TABLE';

