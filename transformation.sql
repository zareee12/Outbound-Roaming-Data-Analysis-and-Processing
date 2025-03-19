--Clean & Transformation--

--clean & transformation column country_name---
--menghapus angka dalam tanda kurung 
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET country_name = regexp_replace(country_name, '\(\d+\)', '', 'g');

--menyamakan format negara tidak ada yg kapital
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET country_name = INITCAP(country_name)
WHERE country_name IN ('TURKS & CAICOS', 'CAMBODIA', 'SERBIA');

--Menyisakan nama negara utama
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET country_name = regexp_replace(country_name, '\s*\(.*\)', '', 'g')

--cek
SELECT country_name 
FROM roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
WHERE country_name = 'Kazakhstan';

---Menghapus Baris Negara Indonesia---
DELETE FROM roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
WHERE country_name = 'Indonesia';

--cek--
SELECT * FROM roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
WHERE country_name = 'Indonesia';

-------------------------------------------------------------------------------------------------------
--clean & transformation column operator_name---
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET operator_name = 
    regexp_replace(
        regexp_replace(operator_name, '\s*--\s*[A-Z ]+$', '', 'g'), -- Hapus negara setelah "--"
        '\s*\(.*\)', '', 'g' -- Hapus isi dalam tanda kurung "()"
    );

UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET operator_name = REGEXP_REPLACE(operator_name, '\s*--.*$', '', 'g');


--perbaiki nama operator negara turks & caicos
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET operator_name = 'Flow'
WHERE country_name = 'Turks & Caicos'
AND operator_name ILIKE '%Cable & Wireless West Indies Ltd%';


--perbaiki nama operator di negara India
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET operator_name = 'Airtel'
WHERE country_name = 'India';

--perbaiki nama operator di negara argentina
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET operator_name = 'Movistar'
WHERE country_name = 'Argentina'
AND operator_name = 'TelefÃƒÂ³nica MÃƒÂ³viles Argentina S.A.';

--perbaiki nama operator di negara canada
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET operator_name = 'Videotron'
WHERE country_name = 'Canada'
AND operator_name = 'Videotron(';

--perbaiki nama operator di negara Hongkong
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET operator_name = 'China Mobile - Peoples'
WHERE country_name = 'Hongkong'
AND operator_name = 'China Mobile Hongkong';


--perbaiki nama operator di negara Hongkong
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET operator_name = 
    CASE 
        WHEN operator_name = 'China Mobile - Peoples' THEN 'China Mobile Hongkong'
        WHEN operator_name = 'H3G' THEN '3 Hongkong'
        ELSE operator_name
    END
WHERE country_name = 'Hongkong';

--perbaiki nama operator di negara Egypt
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET operator_name = 
    CASE 
        WHEN operator_name = 'Mobinil - Arento' THEN 'Mobinil'
        WHEN operator_name = 'Vodafone' THEN 'Vodafone Egypt'
        ELSE operator_name
    END
WHERE country_name = 'Egypt';

--perbaiki nama operator di negara Sweden
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET operator_name = 
    CASE 
        WHEN operator_name = 'Tele2 - Comviq' THEN 'Tele2'
        WHEN operator_name = 'Telenor' THEN 'Telenor Sweden'
        WHEN operator_name = 'TeliaSonera Mobile' THEN 'Telia'
        ELSE operator_name
    END
WHERE country_name = 'Sweden';

--perbaiki nama operator di negara Vietnam
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET operator_name = 
    CASE 
        WHEN operator_name = 'Vietnam Mobile Telecom Services Company' THEN 'Mobifone'
        WHEN operator_name = 'Vietnamobile Telecommunications JSC' THEN 'Vietnamobile'
        WHEN operator_name = 'Viettel' THEN 'Viettel Vietnam'
        ELSE operator_name
    END
WHERE country_name = 'Vietnam';

--perbaiki nama operator di negara Mexico
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET operator_name = 'Movistar Mexico'
WHERE country_name = 'Mexico' AND operator_name LIKE 'Telef%';

--perbaiki operator name di negara Indonesia--
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET operator_name = 
    CASE 
        WHEN operator_name = 'MiTV Corporation Sdn Bhd' THEN 'MiTV Corporation'
        WHEN operator_name = 'Packet One Networks(' THEN 'Packet One Networks'
        WHEN operator_name = 'YTL Communications Sdn Bhd(' THEN 'YTL Communications'
    END
WHERE country_name = 'Malaysia' 
AND operator_name IN ('MiTV Corporation Sdn Bhd', 'Packet One Networks(', 'YTL Communications Sdn Bhd(');

--perbaiki operator negara czech republic
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET operator_name = 'Vodafone Czech Republic'
WHERE country_name = 'Czech Republic'
AND operator_name = 'Vodafone Czech Republic-Oskar';

--perbaiki operator negara America
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET operator_name = 'Verizon Wireless'
WHERE country_name = 'United States of America'
AND operator_name = 'Verizon Wireless(';

--perbaiki operator negara Kuwait
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET operator_name = 'Zain Kuwait'
WHERE country_name = 'Kuwait'
AND operator_name = 'MTC/Zain';

--perbaiki operator negara Uzbekistan
UPDATE roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
SET operator_name = 'Beeline Uzbekistan'
WHERE country_name = 'Uzbekistan'
AND operator_name = 'Unitel/Beeline';

--cek--
SELECT * FROM roaming_data."03_Outbond_Roamer_Country_Operator_Daily"

--cek detail--
select distinct (count)operator_name, country_name 
FROM roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
where country_name = 'Uzbekistan';

SELECT country_name, COUNT(DISTINCT operator_name) AS total_operators
FROM roaming_data."03_Outbond_Roamer_Country_Operator_Daily"
GROUP BY country_name;

SELECT COUNT(DISTINCT operator_name) AS total_operators
FROM roaming_data."03_Outbond_Roamer_Country_Operator_Daily";


