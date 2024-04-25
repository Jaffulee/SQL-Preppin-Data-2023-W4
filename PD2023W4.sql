--Written in Snowflake
--Temporary view for pivoted table
WITH TablePivot AS (
                    SELECT *, 2023 as "Year"
                    -- Union in sub-query to alias
                    FROM    (SELECT *, 'January' AS month
                            FROM PD2023_WK04_JANUARY
                            UNION 
                            SELECT *, 'February' AS month
                            FROM PD2023_WK04_FEBRUARY
                            UNION 
                            SELECT *, 'March' AS month
                            FROM PD2023_WK04_MARCH
                            UNION 
                            SELECT *, 'April' AS month
                            FROM PD2023_WK04_APRIL
                            UNION 
                            SELECT *, 'May' AS month
                            FROM PD2023_WK04_MAY
                            UNION 
                            SELECT *, 'June' AS month
                            FROM PD2023_WK04_JUNE
                            UNION 
                            SELECT *, 'July' AS month
                            FROM PD2023_WK04_JULY
                            UNION 
                            SELECT *, 'August' AS month
                            FROM PD2023_WK04_AUGUST
                            UNION 
                            SELECT *, 'September' AS month
                            FROM PD2023_WK04_SEPTEMBER
                            UNION 
                            SELECT *, 'October' AS month
                            FROM PD2023_WK04_OCTOBER
                            UNION 
                            SELECT *, 'November' AS month
                            FROM PD2023_WK04_NOVEMBER
                            UNION 
                            SELECT *, 'December' AS month
                            FROM PD2023_WK04_DECEMBER
                            ) AS w42021
                    PIVOT(MIN(value) FOR demographic IN ('Ethnicity', 'Account Type','Date of Birth')) as dummyaliasforcolumnrenaming
                    (id,joining_day,month,ethnicity,account_type,date_of_birth)
                    )


                    
SELECT
                    t.ID
                    --use to_date functions to convert data type, and combine day month year fields into one date
                    ,TO_DATE(t.DATE_OF_BIRTH,'MM/DD/YYYY') AS date_of_birth
                    ,TO_DATE(
                            t.JOINING_DAY||t."MONTH"||t."Year"
                            ,'DDMMMMYYYY') AS JOINING_DATE
                    ,t.ACCOUNT_TYPE
                    ,t.ETHNICITY
from TablePivot as t


;
