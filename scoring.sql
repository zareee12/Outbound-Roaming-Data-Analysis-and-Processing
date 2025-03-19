UPDATE roaming_data.update_outbond_roamer_score_remark
SET score_s6a_loc_update_success_rate = 
    CASE 
        WHEN score_s6a_loc_update_success_rate BETWEEN 0 AND 31 THEN 1
        WHEN score_s6a_loc_update_success_rate > 31 AND score_s6a_loc_update_success_rate <= 69.14 THEN 2
        WHEN score_s6a_loc_update_success_rate > 69.14 AND score_s6a_loc_update_success_rate <= 93.31 THEN 3
        WHEN score_s6a_loc_update_success_rate > 93.31 and score_s6a_loc_update_success_rate <= 99.37 THEN 4
        WHEN score_s6a_loc_update_success_rate > 99.37 AND score_s6a_loc_update_success_rate <= 100 THEN 5
    END
WHERE continent IN ('America', 'Africa', 'Europe', 'Asia', 'Asean & Oceania');

--------------------------------------------------------------------------------------------------------------------------------

UPDATE roaming_data.update_outbond_roamer
SET 
    s5s8_create_session_success_rate = 
        CASE 
            WHEN s5s8_create_session_success_rate BETWEEN 0 AND 50 THEN 1
            WHEN s5s8_create_session_success_rate > 50 AND s5s8_create_session_success_rate <= 66.667 THEN 2
            WHEN s5s8_create_session_success_rate > 66.667 AND s5s8_create_session_success_rate <= 85.714 THEN 3
            WHEN s5s8_create_session_success_rate > 85.714 AND s5s8_create_session_success_rate <= 96.97 THEN 4
            WHEN s5s8_create_session_success_rate > 96.97 AND s5s8_create_session_success_rate <= 100 THEN 5
        END,

    dl_retransmitted_packet_rate = 
        CASE 
            WHEN dl_retransmitted_packet_rate BETWEEN 12.612 AND 100 THEN 1
            WHEN dl_retransmitted_packet_rate < 12.612 AND dl_retransmitted_packet_rate >= 8.965 THEN 2
            WHEN dl_retransmitted_packet_rate < 8.965 AND dl_retransmitted_packet_rate >= 4.348 THEN 3
            WHEN dl_retransmitted_packet_rate < 4.348 AND dl_retransmitted_packet_rate >= 2.297 THEN 4
            WHEN dl_retransmitted_packet_rate < 2.297 AND dl_retransmitted_packet_rate >= 0 THEN 5
        END,

    ul_retransmitted_packet_rate = 
        CASE 
            WHEN ul_retransmitted_packet_rate BETWEEN 100 AND 12.5 THEN 1
            WHEN ul_retransmitted_packet_rate < 12.5 AND ul_retransmitted_packet_rate >= 7.688 THEN 2
            WHEN ul_retransmitted_packet_rate < 7.688 AND ul_retransmitted_packet_rate >= 3.125 THEN 3
            WHEN ul_retransmitted_packet_rate < 3.125 AND ul_retransmitted_packet_rate >= 0.784 THEN 4
            WHEN ul_retransmitted_packet_rate < 0.784 AND ul_retransmitted_packet_rate >= 0 THEN 5
        END,

    internal_latency = 
        CASE 
            WHEN internal_latency >= 769.27 THEN 1
            WHEN internal_latency >= 600.78 AND internal_latency < 769.27 THEN 2
            WHEN internal_latency >= 463.5 AND internal_latency < 600.78 THEN 3
            WHEN internal_latency >= 404 AND internal_latency < 463.5 THEN 4
            WHEN internal_latency >= 0 AND internal_latency < 404 THEN 5
        END,

    external_latency = 
        CASE 
            WHEN external_latency >= 408 THEN 1
            WHEN external_latency >= 236.872 AND external_latency < 408 THEN 2
            WHEN external_latency >= 97 AND external_latency < 236.872 THEN 3
            WHEN external_latency >= 48.333 AND external_latency < 97 THEN 4
            WHEN external_latency >= 0 AND external_latency < 48.333 THEN 5
        END

WHERE continent = 'America';

------------------------------------------------------------------------------------------------------------------------------------------------------------
--scoring metrik continent Africa
UPDATE roaming_data.update_outbond_roamer
SET 
    s5s8_create_session_success_rate = 
        CASE 
            WHEN s5s8_create_session_success_rate BETWEEN 0 AND 96.154 THEN 1
            WHEN s5s8_create_session_success_rate > 96.154 AND s5s8_create_session_success_rate <= 75 THEN 2
            WHEN s5s8_create_session_success_rate > 75 AND s5s8_create_session_success_rate <= 50 THEN 3
            WHEN s5s8_create_session_success_rate > 50 AND s5s8_create_session_success_rate <= 20 THEN 4
            WHEN s5s8_create_session_success_rate > 20 AND s5s8_create_session_success_rate <= 100 THEN 5
        END,

    dl_retransmitted_packet_rate = 
        CASE 
            WHEN dl_retransmitted_packet_rate BETWEEN 100 AND 8.265 THEN 1
            WHEN dl_retransmitted_packet_rate < 8.265 AND dl_retransmitted_packet_rate >= 5.902 THEN 2
            WHEN dl_retransmitted_packet_rate < 5.902 AND dl_retransmitted_packet_rate >= 2.722 THEN 3
            WHEN dl_retransmitted_packet_rate < 2.722 AND dl_retransmitted_packet_rate >= 1.025 THEN 4
            WHEN dl_retransmitted_packet_rate < 1.025 AND dl_retransmitted_packet_rate >= 0 THEN 5
        END,

    ul_retransmitted_packet_rate = 
        CASE 
            WHEN ul_retransmitted_packet_rate BETWEEN 100 AND 12.602 THEN 1
            WHEN ul_retransmitted_packet_rate < 12.602 AND ul_retransmitted_packet_rate >= 7.15 THEN 2
            WHEN ul_retransmitted_packet_rate < 7.15 AND ul_retransmitted_packet_rate >= 2.513 THEN 3
            WHEN ul_retransmitted_packet_rate < 2.513 AND ul_retransmitted_packet_rate >= 0.532 THEN 4
            WHEN ul_retransmitted_packet_rate < 0.532 AND ul_retransmitted_packet_rate >= 0 THEN 5
        END,

    internal_latency = 
        CASE 
            WHEN internal_latency >= 847.371 THEN 1
            WHEN internal_latency >= 662.632 AND internal_latency < 847.371 THEN 2
            WHEN internal_latency >= 488.667 AND internal_latency < 662.632 THEN 3
            WHEN internal_latency >= 426.976 AND internal_latency < 488.667 THEN 4
            WHEN internal_latency >= 0 AND internal_latency < 426.976 THEN 5
        END,

    external_latency = 
        CASE 
            WHEN external_latency >= 386.279 THEN 1
            WHEN external_latency >= 233.318 AND external_latency < 386.279 THEN 2
            WHEN external_latency >= 94.278 AND external_latency < 233.318 THEN 3
            WHEN external_latency >= 51 AND external_latency < 94.278 THEN 4
            WHEN external_latency >= 0 AND external_latency < 51 THEN 5
        END
WHERE continent = 'Africa';

--------------------------------------------------------------------------------------------------------------------------------
--scoring metrik continent Europe
UPDATE roaming_data.update_outbond_roamer
SET 
    s5s8_create_session_success_rate = 
        CASE 
            WHEN s5s8_create_session_success_rate BETWEEN 0 AND 98.936 THEN 1
            WHEN s5s8_create_session_success_rate > 98.936 AND s5s8_create_session_success_rate <= 97.802 THEN 2
            WHEN s5s8_create_session_success_rate > 97.802 AND s5s8_create_session_success_rate <= 90 THEN 3
            WHEN s5s8_create_session_success_rate > 90 AND s5s8_create_session_success_rate <= 40 THEN 4
            WHEN s5s8_create_session_success_rate > 40 AND s5s8_create_session_success_rate <= 100 THEN 5
        END,

    dl_retransmitted_packet_rate = 
        CASE 
            WHEN dl_retransmitted_packet_rate BETWEEN 100 AND 12.415 THEN 1
            WHEN dl_retransmitted_packet_rate >= 12.415 AND dl_retransmitted_packet_rate < 9.091 THEN 2
            WHEN dl_retransmitted_packet_rate < 9.091 AND dl_retransmitted_packet_rate >= 5.044 THEN 3
            WHEN dl_retransmitted_packet_rate < 5.044 AND dl_retransmitted_packet_rate >= 2.823 THEN 4
            WHEN dl_retransmitted_packet_rate < 2.823 AND dl_retransmitted_packet_rate >= 0 THEN 5
        END,

    ul_retransmitted_packet_rate = 
        CASE 
            WHEN ul_retransmitted_packet_rate BETWEEN 100 AND 12.677 THEN 1
            WHEN ul_retransmitted_packet_rate < 12.677 AND ul_retransmitted_packet_rate >= 7.321 THEN 2
            WHEN ul_retransmitted_packet_rate < 7.321 AND ul_retransmitted_packet_rate >= 2.749 THEN 3
            WHEN ul_retransmitted_packet_rate < 2.749 AND ul_retransmitted_packet_rate >= 0.632 THEN 4
            WHEN ul_retransmitted_packet_rate < 0.632 AND ul_retransmitted_packet_rate >= 0 THEN 5
        END,

    internal_latency = 
        CASE 
            WHEN internal_latency >= 602 THEN 1
            WHEN internal_latency >= 459 AND internal_latency < 602 THEN 2
            WHEN internal_latency >= 355.667 AND internal_latency < 459 THEN 3
            WHEN internal_latency >= 311 AND internal_latency < 355.667 THEN 4
            WHEN internal_latency >= 0 AND internal_latency < 311 THEN 5
        END,

    external_latency = 
        CASE 
            WHEN external_latency >= 280.5 THEN 1
            WHEN external_latency >= 161.333 AND external_latency < 280.5 THEN 2
            WHEN external_latency >= 62.667 AND external_latency < 161.333 THEN 3
            WHEN external_latency >= 32 AND external_latency < 62.667 THEN 4
            WHEN external_latency >= 0 AND external_latency < 32 THEN 5
        END
WHERE continent = 'Europe';

--------------------------------------------------------------------------------------------------------------------------------
--scoring metrik continent Asia
UPDATE roaming_data.update_outbond_roamer
SET 
    s5s8_create_session_success_rate = 
        CASE 
            WHEN s5s8_create_session_success_rate BETWEEN 0 AND 99.667 THEN 1
            WHEN s5s8_create_session_success_rate > 99.667 AND s5s8_create_session_success_rate <= 99.308 THEN 2
            WHEN s5s8_create_session_success_rate > 99.308 AND s5s8_create_session_success_rate <= 97.196 THEN 3
            WHEN s5s8_create_session_success_rate > 97.196 AND s5s8_create_session_success_rate <= 60 THEN 4
            WHEN s5s8_create_session_success_rate > 60 AND s5s8_create_session_success_rate <= 100 THEN 5
        END,

    dl_retransmitted_packet_rate = 
        CASE 
            WHEN dl_retransmitted_packet_rate BETWEEN 100 AND 7.083 THEN 1
            WHEN dl_retransmitted_packet_rate < 7.083 AND dl_retransmitted_packet_rate >= 4.545 THEN 2
            WHEN dl_retransmitted_packet_rate < 4.545 AND dl_retransmitted_packet_rate >= 1.922 THEN 3
            WHEN dl_retransmitted_packet_rate < 1.922 AND dl_retransmitted_packet_rate >= 0.799 THEN 4
            WHEN dl_retransmitted_packet_rate < 0.799 AND dl_retransmitted_packet_rate >= 0 THEN 5
        END,

    ul_retransmitted_packet_rate = 
        CASE 
            WHEN ul_retransmitted_packet_rate BETWEEN 100 AND 13.294 THEN 1
            WHEN ul_retransmitted_packet_rate < 13.294 AND ul_retransmitted_packet_rate >= 6.928 THEN 2
            WHEN ul_retransmitted_packet_rate < 6.928 AND ul_retransmitted_packet_rate >= 2.439 THEN 3
            WHEN ul_retransmitted_packet_rate < 2.439 AND ul_retransmitted_packet_rate >= 0.704 THEN 4
            WHEN ul_retransmitted_packet_rate < 0.704 AND ul_retransmitted_packet_rate >= 0 THEN 5
        END,

    internal_latency = 
        CASE 
            WHEN internal_latency >= 414.5 THEN 1
            WHEN internal_latency >= 333 AND internal_latency < 414.5 THEN 2
            WHEN internal_latency >= 267 AND internal_latency < 333 THEN 3
            WHEN internal_latency >= 236.117 AND internal_latency < 267 THEN 4
            WHEN internal_latency >= 0 AND internal_latency < 236.117 THEN 5
        END,

    external_latency = 
        CASE 
            WHEN external_latency >= 327.667 THEN 1
            WHEN external_latency >= 185.129 AND external_latency < 327.667 THEN 2
            WHEN external_latency >= 66 AND external_latency < 185.129 THEN 3
            WHEN external_latency >= 29 AND external_latency < 66 THEN 4
            WHEN external_latency >= 0 AND external_latency < 29 THEN 5
        END
WHERE continent = 'Asia';

---------------------------------------------------------------------------------------------------------------------------------------------
--scoring metrik continent asean & oceania
UPDATE roaming_data.update_outbond_roamer
SET 
    s5s8_create_session_success_rate = 
        CASE 
            WHEN s5s8_create_session_success_rate BETWEEN 0 AND 97.565 THEN 1
            WHEN s5s8_create_session_success_rate > 97.565 AND s5s8_create_session_success_rate <= 75 THEN 2
            WHEN s5s8_create_session_success_rate > 75 AND s5s8_create_session_success_rate <= 50 THEN 3
            WHEN s5s8_create_session_success_rate > 50 AND s5s8_create_session_success_rate <= 20 THEN 4
            WHEN s5s8_create_session_success_rate > 20 AND s5s8_create_session_success_rate <= 100 THEN 5
        END,

    dl_retransmitted_packet_rate = 
        CASE 
            WHEN dl_retransmitted_packet_rate BETWEEN 100 AND 5.882 THEN 1
            WHEN dl_retransmitted_packet_rate >= 5.882 AND dl_retransmitted_packet_rate < 3.763 THEN 2
            WHEN dl_retransmitted_packet_rate < 3.763 AND dl_retransmitted_packet_rate >= 1.581 THEN 3
            WHEN dl_retransmitted_packet_rate < 1.581 AND dl_retransmitted_packet_rate >= 0.668 THEN 4
            WHEN dl_retransmitted_packet_rate < 0.668 AND dl_retransmitted_packet_rate >= 0 THEN 5
        END,

    ul_retransmitted_packet_rate = 
        CASE 
            WHEN ul_retransmitted_packet_rate BETWEEN 100 AND 12.5 THEN 1
            WHEN ul_retransmitted_packet_rate < 12.5 AND ul_retransmitted_packet_rate >= 6.667 THEN 2
            WHEN ul_retransmitted_packet_rate < 6.667 AND ul_retransmitted_packet_rate >= 2.563 THEN 3
            WHEN ul_retransmitted_packet_rate < 2.563 AND ul_retransmitted_packet_rate >= 0.841 THEN 4
            WHEN ul_retransmitted_packet_rate < 0.841 AND ul_retransmitted_packet_rate >= 0 THEN 5
        END,

    internal_latency = 
        CASE 
            WHEN internal_latency >= 340.222 THEN 1
            WHEN internal_latency >= 249.286 AND internal_latency < 340.222 THEN 2
            WHEN internal_latency >= 167.719 AND internal_latency < 249.286 THEN 3
            WHEN internal_latency >= 138.4 AND internal_latency < 167.719 THEN 4
            WHEN internal_latency >= 0 AND internal_latency < 138.4 THEN 5
        END,

    external_latency = 
        CASE 
            WHEN external_latency >= 213 THEN 1
            WHEN external_latency >= 118 AND external_latency < 213 THEN 2
            WHEN external_latency >= 45.667 AND external_latency < 118 THEN 3
            WHEN external_latency >= 22.5 AND external_latency < 45.667 THEN 4
            WHEN external_latency >= 0 AND external_latency < 22.5 THEN 5
        END
WHERE continent = 'Asean & Oceania';

-----------------------------------------------------------------------------------------------------------------------------------
--scoring final_score
UPDATE roaming_data.update_outbond_roamer_score_remark
SET final_score = 
    (
        (CASE WHEN score_s5s8_create_session_success_rate IS NOT NULL AND weight1 IS NOT NULL 
              THEN score_s5s8_create_session_success_rate * weight1 ELSE 0 END) + 
        (CASE WHEN score_s6a_loc_update_success_rate IS NOT NULL AND weight2 IS NOT NULL 
              THEN score_s6a_loc_update_success_rate * weight2 ELSE 0 END) + 
        (CASE WHEN score_dl_retransmitted_packet_rate IS NOT NULL AND weight3 IS NOT NULL 
              THEN score_dl_retransmitted_packet_rate * weight3 ELSE 0 END) + 
        (CASE WHEN score_ul_retransmitted_packet_rate IS NOT NULL AND weight4 IS NOT NULL 
              THEN score_ul_retransmitted_packet_rate * weight4 ELSE 0 END) + 
        (CASE WHEN score_internal_latency IS NOT NULL AND weight5 IS NOT NULL 
              THEN score_internal_latency * weight5 ELSE 0 END) + 
        (CASE WHEN score_external_latency IS NOT NULL AND weight6 IS NOT NULL 
              THEN score_external_latency * weight6 ELSE 0 END)
    ) / 
    NULLIF(
        (CASE WHEN weight1 IS NOT NULL AND score_s5s8_create_session_success_rate IS NOT NULL THEN weight1 ELSE 0 END) + 
        (CASE WHEN weight2 IS NOT NULL AND score_s6a_loc_update_success_rate IS NOT NULL THEN weight2 ELSE 0 END) + 
        (CASE WHEN weight3 IS NOT NULL AND score_dl_retransmitted_packet_rate IS NOT NULL THEN weight3 ELSE 0 END) + 
        (CASE WHEN weight4 IS NOT NULL AND score_ul_retransmitted_packet_rate IS NOT NULL THEN weight4 ELSE 0 END) + 
        (CASE WHEN weight5 IS NOT NULL AND score_internal_latency IS NOT NULL THEN weight5 ELSE 0 END) + 
        (CASE WHEN weight6 IS NOT NULL AND score_external_latency IS NOT NULL THEN weight6 ELSE 0 END),
    0);

--remark
UPDATE roaming_data.update_outbond_roamer_score_remark
SET remark = 
    CASE 
        WHEN final_score BETWEEN 0 AND 1 THEN 'Bad'
        WHEN final_score > 1 AND final_score <= 2 THEN 'Poor'
        WHEN final_score > 2 AND final_score <= 3 THEN 'Fair'
        WHEN final_score > 3 AND final_score <= 4 THEN 'Good'
        WHEN final_score > 4 AND final_score <= 5 THEN 'Excellent'
    end;










