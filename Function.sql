-----CREATE FUNCTION-----

---Function get all countries---
CREATE OR REPLACE FUNCTION get_all_countries(p_country_name VARCHAR(30) DEFAULT NULL)
RETURNS TABLE(name VARCHAR(30)) AS $$
BEGIN
    RETURN QUERY 
    SELECT c.country_name 
    FROM roaming_data.country c
    WHERE p_country_name IS NULL OR c.country_name = p_country_name;
END;
$$ LANGUAGE plpgsql;

--Memanggil function--
SELECT * FROM get_all_countries();
SELECT * FROM get_all_countries('India');

---Function get_all_operators---
CREATE OR REPLACE FUNCTION get_all_operators(p_country_name VARCHAR DEFAULT NULL)
RETURNS TABLE(operator_name VARCHAR, country_name VARCHAR) AS 
$$
BEGIN
    RETURN QUERY 
    SELECT o.operator_name, o.country_name
    FROM roaming_data.operator o
    WHERE p_country_name IS NULL OR o.country_name = p_country_name;
END;
$$ LANGUAGE plpgsql;

--Memanggil fungsi
SELECT * FROM get_all_operators();
SELECT * FROM get_all_operators('India');

---Function get_country_operator_metrics
CREATE OR REPLACE FUNCTION get_country_operator_metrics(
    p_start_date DATE,
    p_end_date DATE,
    p_country_name VARCHAR DEFAULT NULL,
    p_operator_name VARCHAR DEFAULT NULL
)
RETURNS TABLE(
	datedd DATE,
    country_name VARCHAR,
    operator_name VARCHAR,
    active_user INTEGER,
    trafficmb FLOAT,
    s5s8_create_session_success_rate FLOAT,
    s6a_loc_update_success_rate FLOAT,
    ul_retransmitted_packet_rate FLOAT,
    dl_retransmitted_packet_rate FLOAT,
    internal_latency FLOAT,
    external_latency FLOAT
) AS
$$
BEGIN
    RETURN QUERY
    SELECT
		r.datedd, 
        r.country_name,
        r.operator_name,
        r.active_user,
        r.trafficmb,
        r.s5s8_create_session_success_rate,
        r.s6a_loc_update_success_rate,
        r.ul_retransmitted_packet_rate,
        r.dl_retransmitted_packet_rate,
        r.internal_latency,
        r.external_latency
    FROM roaming_data.roaming_data_noscore r
    WHERE r.datedd BETWEEN p_start_date AND p_end_date
        AND (p_country_name IS NULL OR r.country_name = p_country_name)
        AND (p_operator_name IS NULL OR r.operator_name = p_operator_name);
END;
$$ LANGUAGE plpgsql;

---Calling the Function
--Without Country & Operator Filters (All data within a specified date range)
SELECT * FROM get_country_operator_metrics('2024-12-13', '2025-01-30');

--Filter by Country (Example: India)
SELECT * FROM get_country_operator_metrics('2024-12-13', '2025-01-30', 'India');

--Filter by Operator (Example: Orange)
SELECT * FROM get_country_operator_metrics('2024-12-13', '2025-01-30', NULL, 'Orange');

--Filter berdasarkan negara dan operator (contoh: India - Airtel)
SELECT * FROM get_country_operator_metrics('2025-01-29', '2025-01-30', 'India', 'Airtel');

---------------------------------------------------------------------------------------------------

------Function get_countries_with_score
CREATE OR REPLACE FUNCTION get_countries_with_score(
    p_start_date DATE,
    p_end_date DATE
)
RETURNS TABLE(
	datedd DATE,
    country_name VARCHAR,
    avg_score FLOAT,
    remark TEXT
) AS
$$
BEGIN
    RETURN QUERY
    SELECT 
		r.datedd,
        r.country_name,
        AVG(r.final_score) AS avg_score,
        CASE 
            WHEN AVG(r.final_score) BETWEEN 0 AND 1 THEN 'Bad'
            WHEN AVG(r.final_score) > 1 AND AVG(r.final_score) <= 2 THEN 'Poor'
            WHEN AVG(r.final_score) > 2 AND AVG(r.final_score) <= 3 THEN 'Fair'
            WHEN AVG(r.final_score) > 3 AND AVG(r.final_score) <= 4 THEN 'Good'
            WHEN AVG(r.final_score) > 4 AND AVG(r.final_score) <= 5 THEN 'Excellent'
            ELSE 'Unknown'
        END AS remark
    FROM roaming_data.roaming_data r
    WHERE r.datedd BETWEEN p_start_date AND p_end_date
    GROUP BY r.datedd, r.country_name
    ORDER BY r.datedd ASC, avg_score;  -- Urutkan dari yang terburuk ke terbaik
END;
$$ LANGUAGE plpgsql;

--Calling the Function
--Displaying all countries within a specified date range
SELECT * FROM get_countries_with_score('2024-12-13', '2025-01-31');

--Jika ingin melihat skor negara tertentu, bisa tambahkan WHERE setelah pemanggilan:
SELECT * FROM get_countries_with_score('2024-12-13', '2025-01-31')
WHERE country_name = 'Canada';

--------------------------------------------------------------------------------------------------

------Function get_get_worst_operators
CREATE OR REPLACE FUNCTION get_worst_operators(
    start_date DATE,
    end_date DATE
) 
RETURNS TABLE (
    datedd DATE,
    country_name VARCHAR(100),
    operator_name VARCHAR(100),
    final_score FLOAT,
    remark TEXT
) 
LANGUAGE plpgsql 
AS $$ 
BEGIN
    RETURN QUERY
    WITH RankedOperators AS (
        SELECT 
            o.datedd,
            o.country_name, 
            o.operator_name, 
            o.final_score,
            o.remark,
            RANK() OVER (PARTITION BY o.datedd, o.country_name ORDER BY o.final_score ASC) AS rank
        FROM roaming_data.roaming_data o
        WHERE o.datedd BETWEEN start_date AND end_date
            AND o.final_score IS NOT NULL  
    )
    SELECT  
        RankedOperators.datedd,
        RankedOperators.country_name,
        RankedOperators.operator_name,
        RankedOperators.final_score,
        RankedOperators.remark
    FROM RankedOperators
    WHERE RankedOperators.rank <= 5
    ORDER BY 
        RankedOperators.datedd ASC,
        RankedOperators.country_name ASC,
        RankedOperators.final_score ASC;
END;
$$;




SELECT * FROM get_worst_operators('2024-11-01', '2024-12-31');




--DROP
DROP FUNCTION IF EXISTS get_worst_operators;





















