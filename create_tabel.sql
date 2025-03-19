CREATE TABLE roaming_data."01_Outbond_Roamer_Overal_Daily" (
 datedd DATE
 , operator_name VARCHAR(30)
 , country_name VARCHAR(30)
 , numuser INT
 , active_user INT
 , trafficmb FLOAT
 , session BIGINT
 , duration_s FLOAT
 , s5s8_create_session_success_rate FLOAT
 , s6a_loc_update_success_rate FLOAT
 , dl_retransmitted_packet_rate FLOAT
 , ul_retransmitted_packet_rate FLOAT
 , internal_latency FLOAT
 , external_latency FLOAT
);

CREATE TABLE roaming_data."02_Outbond_Roamer_Country_Daily" (
 datedd DATE
 , operator_name VARCHAR(30)
 , country_name VARCHAR(100)
 , numuser INT
 , active_user INT
 , trafficmb FLOAT
 , session BIGINT
 , duration_s FLOAT
 , s5s8_create_session_success_rate FLOAT
 , s6a_loc_update_success_rate FLOAT
 , dl_retransmitted_packet_rate FLOAT
 , ul_retransmitted_packet_rate FLOAT
 , internal_latency FLOAT
 , external_latency FLOAT
);

CREATE TABLE roaming_data."03_Outbond_Roamer_Country_Operator_Daily" (
 datedd DATE
 , operator_name VARCHAR(100)
 , country_name VARCHAR(100)
 , numuser INT
 , active_user INT
 , trafficmb FLOAT
 , session BIGINT
 , duration_s FLOAT
 , s5s8_create_session_success_rate FLOAT
 , s6a_loc_update_success_rate FLOAT
 , dl_retransmitted_packet_rate FLOAT
 , ul_retransmitted_packet_rate FLOAT
 , internal_latency FLOAT
 , external_latency FLOAT
);

---------------------------------------------------------------------------------------------
-- membuat tabel baru yang akan dimanipulasi
CREATE TABLE update_outbond_roamer_score_remark AS 
SELECT * FROM roaming_data."03_Outbond_Roamer_Country_Operator_Daily";

--mengganti nama kolomnya
ALTER TABLE roaming_data.update_outbond_roamer_score_remark 
RENAME COLUMN s6a_loc_update_success_rate TO score_s6a_loc_update_success_rate;

ALTER TABLE roaming_data.update_outbond_roamer 
RENAME COLUMN s5s8_create_session_success_rate TO score_s5s8_create_session_success_rate;

ALTER TABLE roaming_data.update_outbond_roamer 
RENAME COLUMN dl_retransmitted_packet_rate TO score_dl_retransmitted_packet_rate;

ALTER TABLE roaming_data.update_outbond_roamer 
RENAME COLUMN ul_retransmitted_packet_rate TO score_ul_retransmitted_packet_rate ;

ALTER TABLE roaming_data.update_outbond_roamer 
RENAME COLUMN internal_latency TO score_internal_latency;

ALTER TABLE roaming_data.update_outbond_roamer 
RENAME COLUMN external_latency TO score_external_latency;

--menambah kolom continent
ALTER TABLE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
ADD COLUMN continent TEXT;

--isi kolom continent
UPDATE roaming_data.update_outbond_roamer_score_remark
SET continent = 
    CASE 
        WHEN country_name IN ('Argentina', 'Bolivia', 'Brazil', 'Canada', 'Chile', 'Colombia', 'Ecuador', 
                              'Mexico', 'Peru', 'Puerto Rico', 'United States of America', 'Uruguay', 'Turks & Caicos', 
                              'Aruba', 'Jamaica') --15
        THEN 'America'

        WHEN country_name IN ('Algeria', 'Egypt', 'Ethiopia', 'Gambia', 'Kenya', 'Mauritius', 'Morocco', 
                              'Seychelles', 'Sierra Leone', 'South Africa', 'Tanzania', 'Tunisia') --12
        THEN 'Africa'

        WHEN country_name IN ('Albania', 'Austria', 'Belarus', 'Belgium', 'Bosnia and Herzegovina', 'Bulgaria', 
                              'Croatia', 'Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 
                              'Germany', 'Greece', 'Hungary', 'Iceland', 'Ireland', 'Italy', 'Latvia', 
                              'Liechtenstein', 'Lithuania', 'Luxembourg', 'Malta', 'Moldova', 'Netherlands', 
                              'Norway', 'Poland', 'Portugal', 'Romania', 'Russia', 'Serbia', 'Slovak Republic', 
                              'Slovenia', 'Spain', 'Sweden', 'Switzerland', 'Ukraine', 'United Kingdom', 'Georgia') --39
        THEN 'Europe'

        WHEN country_name IN ('Afghanistan', 'Armenia', 'Azerbaijan', 'Bahrain', 'Bangladesh', 'China', 
                              'Georgia', 'Hongkong', 'India', 'Iraq', 'Israel', 'India', 'Japan', 'Jordan', 'Kazakhstan', 
                              'Kuwait', 'Kyrgyz Republic', 'Lebanon', 'Macau', 'Maldives', 'Mongolia', 'Nepal', 
                              'Oman', 'Pakistan', 'Qatar', 'Saudi Arabia', 'South Korea', 'Sri Lanka', 'Tajikstan', 
                              'Taiwan', 'Turkey', 'United Arab Emirates', 'Uzbekistan') --33
        THEN 'Asia'

        WHEN country_name IN ('Brunei', 'Cambodia', 'East Timor', 'Laos', 'Malaysia', 
                              'Philippines', 'Singapore', 'Thailand', 'Vietnam', 'Australia', 'Fiji',
                               'New Caledonia', 'New Zealand', 'Papua New Guinea') --14
        THEN 'Asean & Oceania'
        
        ELSE 'Unknown'
    END;
 --------------------------------------------------------------------------------------------------------------------------
 --Menambah kolom baru untuk calculate scoring
ALTER TABLE roaming_data.update_outbond_roamer_score_remark 
ADD COLUMN weight1 FLOAT,
ADD COLUMN weight2 FLOAT,
ADD COLUMN weight3 FLOAT,
ADD COLUMN weight4 FLOAT,
ADD COLUMN weight5 FLOAT,
ADD COLUMN weight6 FLOAT,
ADD COLUMN final_score FLOAT,
ADD COLUMN remark TEXT;

--mengisi kolom weight

UPDATE roaming_data.update_outbond_roamer_score_remark
SET weight1 = 0.209;

UPDATE roaming_data.update_outbond_roamer_score_remark
SET weight2 = 0.132;

UPDATE roaming_data.update_outbond_roamer_score_remark
SET weight3 = 0.094;

UPDATE roaming_data.update_outbond_roamer_score_remark
SET weight4 = 0.277;

UPDATE roaming_data.update_outbond_roamer_score_remark
SET weight5 = 0.113;

UPDATE roaming_data.update_outbond_roamer_score_remark
SET weight6 = 0.175;

        
-------------------------------------------------------------------------------------------------------------------------
--membuat tabel ERD untuk normalisasi
CREATE TABLE roaming_data.country (
    country_name VARCHAR(30) PRIMARY KEY,
    continent VARCHAR(30)
);

-- Insert data dari tabel utama
INSERT INTO roaming_data.country (country_name, continent)
SELECT DISTINCT country_name, continent
FROM roaming_data.update_outbond_roamer;

-- Tabel Operator

CREATE TABLE roaming_data.operator (
    operator_name VARCHAR(100),
    country_name VARCHAR(30) REFERENCES roaming_data.country(country_name) ON DELETE CASCADE,
    PRIMARY KEY (operator_name, country_name)
);

--INSERT
INSERT INTO roaming_data.operator (operator_name, country_name)
SELECT DISTINCT operator_name, country_name
FROM roaming_data.update_outbond_roamer
WHERE operator_name IS NOT NULL AND country_name IS NOT NULL;


-- Tabel roaming_data
CREATE TABLE roaming_data.roaming_data_noscore (
    datedd DATE,
    operator_name VARCHAR(30),
    country_name VARCHAR(100),
    active_user INTEGER,
    trafficmb FLOAT,
    session BIGINT,
    duration_s FLOAT,
    s5s8_create_session_success_rate FLOAT,
    s6a_loc_update_success_rate FLOAT,
    dl_retransmitted_packet_rate FLOAT,
    ul_retransmitted_packet_rate FLOAT,
    internal_latency FLOAT,
    external_latency FLOAT
);

-- Insert data dari tabel utama ke tabel baru di schema roaming_data_noscore
INSERT INTO roaming_data.roaming_data_noscore (
    datedd, operator_name, country_name, active_user, trafficmb, session, duration_s,
    s5s8_create_session_success_rate, s6a_loc_update_success_rate,
    dl_retransmitted_packet_rate, ul_retransmitted_packet_rate,
    internal_latency, external_latency
)
SELECT 
    datedd, operator_name, country_name, active_user, trafficmb, session, duration_s,
    s5s8_create_session_success_rate, s6a_loc_update_success_rate,
    dl_retransmitted_packet_rate, ul_retransmitted_packet_rate,
    internal_latency, external_latency
FROM roaming_data."03_Outbond_Roamer_Country_Operator_Daily"

ALTER TABLE roaming_data.roaming_data_noscore
ALTER COLUMN operator_name 
TYPE VARCHAR(50);


-- Tabel roaming_data_score
CREATE TABLE roaming_data.roaming_data_score (
    datedd DATE,
    operator_name VARCHAR(30),
    country_name VARCHAR(100),
    active_user INTEGER,
    trafficmb FLOAT,
    session BIGINT,
    duration_s FLOAT,
    score_s5s8_create_session_success_rate FLOAT,
    score_s6a_loc_update_success_rate FLOAT,
    score_dl_retransmitted_packet_rate FLOAT,
    score_ul_retransmitted_packet_rate FLOAT,
    score_internal_latency FLOAT,
    score_external_latency FLOAT,
    weight1 FLOAT,
    weight2 FLOAT,
    weight3 FLOAT,
    weight4 FLOAT,
    weight5 FLOAT,
    weight6 FLOAT,
    final_score FLOAT,
    remark TEXT,
    PRIMARY KEY (datedd, operator_name, country_name),
    FOREIGN KEY (operator_name, country_name) 
        REFERENCES roaming_data_score.operator(operator_name, country_name) 
        ON DELETE CASCADE
);

-- Insert data dari tabel utama ke tabel baru di schema roaming_data
INSERT INTO roaming_data.roaming_data_score (
    datedd, operator_name, country_name, active_user, trafficmb, session, duration_s,
    score_s5s8_create_session_success_rate, score_s6a_loc_update_success_rate,
    score_dl_retransmitted_packet_rate, score_ul_retransmitted_packet_rate,
    score_internal_latency, score_external_latency,
    weight1, weight2, weight3, weight4, weight5, weight6,
    final_score, remark
)
SELECT 
    datedd, operator_name, country_name, active_user, trafficmb, session, duration_s,
    score_s5s8_create_session_success_rate, score_s6a_loc_update_success_rate,
    score_dl_retransmitted_packet_rate, score_ul_retransmitted_packet_rate,
    score_internal_latency, score_external_latency,
    weight1, weight2, weight3, weight4, weight5, weight6,
    final_score, remark
FROM roaming_data.update_outbond_roamer_score_remark
ON CONFLICT (datedd, operator_name, country_name) DO NOTHING;















