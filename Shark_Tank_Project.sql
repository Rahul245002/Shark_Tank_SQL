create database sql_portfolio;
use sql_portfolio;


CREATE TABLE shark_tank (
    Ep_no INT,
    Brand VARCHAR(20),
    Male INT,
    Female INT,
    Location VARCHAR(20),
    Idea VARCHAR(50),
    Sector VARCHAR(50),
    Deal VARCHAR(50),
    Amount_Invested INT,
    Amout_Asked INT,
    Debt_Invested INT,
    Debt_Asked INT,
    Equity_Taken INT,
    Equity_Asked INT,
    Avg_age VARCHAR(50),
    Team_members INT,
    Ashneer_Amount_Invested VARCHAR(20),
    Ashneer_Equity_Taken VARCHAR(20),
    Namita_amount_Invested VARCHAR(20),
    Namita_Equity_Taken VARCHAR(20),
    Anupam_Amount_Invested VARCHAR(20),
    Anupam_Equity_Taken VARCHAR(20),
    Vineeta_Amount_Invested VARCHAR(20),
    Vineeta_Equity_Taken VARCHAR(20),
    Aman_Amount_Invested VARCHAR(20),
    Aman_Equity_Taken VARCHAR(20),
    Peyush_Amount_Invested VARCHAR(20),
    Peyush_Equity_Taken VARCHAR(20),
    Ghazal_Amount_Invested VARCHAR(20),
    Ghazal_Equity_Taken VARCHAR(20),
    Total_investors VARCHAR(20),
    Partners VARCHAR(20)
);

SELECT 
    *
FROM
    shark_tank;

-- 1) total episode?
SELECT 
    COUNT(DISTINCT (EP_no)) AS total_Episode
FROM
    shark_tank;
    
    
    
-- 2) total number of pitches?

SELECT 
    COUNT(DISTINCT (Brand)) AS total_pitches
FROM
    shark_tank;



-- 3) pitches converted

SELECT 
    SUM(a.deal_status) Received_funding, COUNT(*) Total_pitches
FROM
    (SELECT 
        Ep_no,
            Brand,
            Deal,
            CASE
                WHEN Deal = 'No Deal' THEN 0
                ELSE 1
            END AS deal_status
    FROM
        shark_tank) a;

-- 5) Sucesses Rate to convert the pitches into a Deal

SELECT 
    ROUND(((Received_funding / Total_pitches) * 100)) Sucecsses_rate
FROM
    (SELECT 
        SUM(a.deal_status) Received_funding, COUNT(*) Total_pitches
    FROM
        (SELECT 
        Ep_no,
            Brand,
            Deal,
            CASE
                WHEN Deal = 'No Deal' THEN 0
                ELSE 1
            END AS deal_status
    FROM
        shark_tank) a) b;


-- 6) Total number of male

SELECT 
    SUM(Male) AS total_male
FROM
    shark_tank;

-- 7) Total number of Female
SELECT 
    SUM(Female) AS total_Female
FROM
    shark_tank;


-- 8) Gender Ratio

SELECT 
    SUM(Female) / SUM(Male) AS Gender_ratio
FROM
    shark_tank;


-- 9) total amout which was invested

SELECT 
    SUM(Amount_Invested) AS amount_invested_in_Lakh
FROM
    shark_tank;

-- 10) Avg Equity Taken

SELECT 
    *
FROM
    shark_tank;

SELECT 
    AVG(a.Equity_Taken) AS Avg_equity_Taken
FROM
    (SELECT 
        Brand, Deal, Amount_Invested, Equity_Taken
    FROM
        shark_tank
    WHERE
        Deal != 'No Deal') a;

-- 11) Highest deal taken

SELECT 
    MAX(Amount_Invested)
FROM
    shark_tank;

-- 12) Highest equity taken

SELECT 
    MAX(Equity_Taken) AS Highest_Equity_taken
FROM
    shark_tank;

-- 13) Startups having a atleast one Female

SELECT 
    COUNT(a.Female) AS at_least_One_Feamle
FROM
    (SELECT 
        Ep_no, Brand, Deal, Female
    FROM
        shark_tank
    WHERE
        Female != 0) a;

-- 14) pitches converted a having one Feamle

SELECT 
    *
FROM
    shark_tank;

SELECT 
    COUNT(a.Deal)
FROM
    (SELECT 
        Ep_no, Brand, Female, Deal
    FROM
        shark_tank
    WHERE
        Female != 0 AND Deal != 'No Deal') a;
        
-- 15) find the avg team member

SELECT 
    AVG(Team_members)
FROM
    shark_tank;

-- 16) Amount invested in per Deal

SELECT 
    AVG(a.Amount_Invested)
FROM
    (SELECT 
        Deal, Amount_Invested
    FROM
        shark_tank
    WHERE
        Deal != 0 OR Amount_Invested != 0) a;

-- 17) most age group the enterprenuers come from

SELECT 
    Avg_age, COUNT(Avg_age)
FROM
    shark_tank
GROUP BY Avg_age
ORDER BY COUNT(Avg_age) DESC;

-- location groups of contestants 

SELECT 
    Location, COUNT(Location) AS C_L
FROM
    shark_tank
GROUP BY Location
ORDER BY C_L DESC;

-- which is the sector had come for the pitche

SELECT 
    Sector, COUNT(Sector) AS C_S
FROM
    shark_tank
GROUP BY Sector
ORDER BY C_S DESC;

-- 

SELECT 
    Partners, COUNT(Partners)
FROM
    shark_tank
GROUP BY Partners
HAVING Partners != '-'
ORDER BY COUNT(Partners) DESC;

-- Deatails of the sharks

SELECT 
    *
FROM
    shark_tank;


SELECT 
    a.Keyy,
    a.Total_Deals_Present,
    b.Total_Deals,
    c.Total_Amount_Invested,
    c.Avg_Equity_Taken
FROM
    (SELECT 
        'Ashneer' AS keyy,
            COUNT(Ashneer_Amount_Invested) AS Total_Deals_Present
    FROM
        shark_tank
    WHERE
        Ashneer_Amount_Invested != 'NA') a
        INNER JOIN
    (SELECT 
        'Ashneer' AS Keyy,
            COUNT(Ashneer_Amount_Invested) AS Total_Deals
    FROM
        shark_tank
    WHERE
        Ashneer_Amount_Invested != 'NA'
            AND Ashneer_Amount_Invested != 0) b ON a.Keyy = b.Keyy
        INNER JOIN
    (SELECT 
        'Ashneer' AS Keyy,
            SUM(x.Ashneer_Amount_Invested) AS Total_Amount_Invested,
            AVG(x.Ashneer_Equity_Taken) AS Avg_Equity_Taken
    FROM
        (SELECT 
        *
    FROM
        shark_tank
    WHERE
        Ashneer_Equity_Taken != 0
            AND Ashneer_Equity_Taken != 'NA') x) c ON a.Keyy = c.Keyy 
UNION ALL SELECT 
    a.Keyy,
    a.Total_Deals_Present,
    b.Total_Deals,
    c.Total_Amount_Invested,
    c.Avg_Equity_Taken
FROM
    (SELECT 
        'Namita' AS Keyy,
            COUNT(Namita_amount_Invested) AS Total_Deals_Present
    FROM
        shark_tank
    WHERE
        Namita_amount_Invested != 'NA') a
        INNER JOIN
    (SELECT 
        'Namita' AS Keyy,
            COUNT(Namita_amount_Invested) AS Total_Deals
    FROM
        shark_tank
    WHERE
        Namita_amount_Invested != 'NA'
            AND Namita_amount_Invested != 0) b ON a.Keyy = b.Keyy
        INNER JOIN
    (SELECT 
        'Namita' AS Keyy,
            SUM(Namita_amount_Invested) AS Total_amount_invested,
            AVG(Namita_Equity_Taken) AS Avg_Equity_Taken
    FROM
        (SELECT 
        *
    FROM
        shark_tank
    WHERE
        Namita_Equity_Taken != 0
            AND Namita_Equity_Taken != 'NA') z) c ON a.Keyy = c.Keyy 
UNION ALL SELECT 
    a.Keyy,
    a.Total_Deals_Present,
    b.Total_Deals,
    c.Total_Amount_Invested,
    c.Avg_Equity_Taken
FROM
    (SELECT 
        'Anupam' AS Keyy,
            COUNT(Anupam_Amount_Invested) AS Total_Deals_present
    FROM
        shark_tank
    WHERE
        Anupam_Amount_Invested != 'NA') a
        INNER JOIN
    (SELECT 
        'Anupam' AS Keyy,
            COUNT(Anupam_Amount_Invested) AS Total_Deals
    FROM
        shark_tank
    WHERE
        Anupam_Amount_Invested != 0
            AND Anupam_Amount_Invested != 'NA') b ON a.Keyy = b.keyy
        INNER JOIN
    (SELECT 
        'Anupam' AS Keyy,
            SUM(Anupam_Amount_Invested) AS Total_amount_invested,
            AVG(Anupam_Equity_Taken) AS Avg_Equity_Taken
    FROM
        shark_tank
    WHERE
        Anupam_Amount_Invested != 0
            AND Anupam_Equity_Taken != 'NA'
            AND Anupam_Equity_Taken != 0) c ON a.Keyy = c.Keyy 
UNION ALL SELECT 
    a.Keyy,
    a.Total_Deals_Present,
    b.Total_Deals,
    c.Total_Amount_Invested,
    c.Avg_Equity_Taken
FROM
    (SELECT 
        'Vineeta' AS Keyy,
            COUNT(Vineeta_Amount_invested) AS Total_Deals_Present
    FROM
        shark_tank
    WHERE
        Vineeta_Amount_invested != 'NA') a
        INNER JOIN
    (SELECT 
        'Vineeta' AS Keyy,
            COUNT(Vineeta_Amount_invested) AS Total_Deals
    FROM
        shark_tank
    WHERE
        Vineeta_Amount_invested != 'NA'
            AND Vineeta_Amount_invested != 0) b ON a.Keyy = b.Keyy
        INNER JOIN
    (SELECT 
        'Vineeta' AS Keyy,
            SUM(Vineeta_Amount_Invested) AS Total_amount_invested,
            AVG(Vineeta_Equity_Taken) AS Avg_Equity_Taken
    FROM
        shark_tank
    WHERE
        Vineeta_Amount_Invested != 0
            AND Vineeta_Equity_Taken != 'NA'
            AND Vineeta_Equity_Taken != 0) c ON a.Keyy = c.Keyy 
UNION ALL SELECT 
    a.Keyy,
    a.Total_Deals_Present,
    b.Total_Deals,
    c.Total_Amount_Invested,
    c.Avg_Equity_Taken
FROM
    (SELECT 
        'Aman' AS Keyy,
            COUNT(Aman_Amount_invested) AS Total_Deals_Present
    FROM
        shark_tank
    WHERE
        Aman_Amount_invested != 'NA') a
        INNER JOIN
    (SELECT 
        'Aman' AS Keyy, COUNT(Aman_Amount_invested) AS Total_Deals
    FROM
        shark_tank
    WHERE
        Aman_Amount_invested != 'NA'
            AND Aman_Amount_invested != 0) b ON a.Keyy = b.Keyy
        INNER JOIN
    (SELECT 
        'Aman' AS Keyy,
            SUM(Aman_Amount_Invested) AS Total_amount_invested,
            AVG(Aman_Equity_Taken) AS Avg_Equity_Taken
    FROM
        shark_tank
    WHERE
        Aman_Amount_Invested != 0
            AND Aman_Equity_Taken != 'NA'
            AND Aman_Equity_Taken != 0) c ON a.Keyy = c.Keyy 
UNION ALL SELECT 
    a.Keyy,
    a.Total_Deals_Present,
    b.Total_Deals,
    c.Total_Amount_Invested,
    c.Avg_Equity_Taken
FROM
    (SELECT 
        'Peyush' AS Keyy,
            COUNT(Peyush_Amount_invested) AS Total_Deals_Present
    FROM
        shark_tank
    WHERE
        Peyush_Amount_invested != 'NA') a
        INNER JOIN
    (SELECT 
        'Peyush' AS Keyy,
            COUNT(Peyush_Amount_invested) AS Total_Deals
    FROM
        shark_tank
    WHERE
        Peyush_Amount_invested != 'NA'
            AND Peyush_Amount_invested != 0) b ON a.Keyy = b.Keyy
        INNER JOIN
    (SELECT 
        'Peyush' AS Keyy,
            SUM(Peyush_Amount_Invested) AS Total_amount_invested,
            AVG(Peyush_Equity_Taken) AS Avg_Equity_Taken
    FROM
        shark_tank
    WHERE
        Peyush_Amount_Invested != 0
            AND Peyush_Equity_Taken != 'NA'
            AND Peyush_Equity_Taken != 0) c ON a.Keyy = c.Keyy 
UNION ALL SELECT 
    a.Keyy,
    a.Total_Deals_Present,
    b.Total_Deals,
    c.Total_Amount_Invested,
    c.Avg_Equity_Taken
FROM
    (SELECT 
        'Ghazal' AS Keyy,
            COUNT(Ghazal_Amount_invested) AS Total_Deals_Present
    FROM
        shark_tank
    WHERE
        Ghazal_Amount_invested != 'NA') a
        INNER JOIN
    (SELECT 
        'Ghazal' AS Keyy,
            COUNT(Ghazal_Amount_invested) AS Total_Deals
    FROM
        shark_tank
    WHERE
        Ghazal_Amount_invested != 'NA'
            AND Ghazal_Amount_invested != 0) b ON a.Keyy = b.Keyy
        INNER JOIN
    (SELECT 
        'Ghazal' AS Keyy,
            SUM(Ghazal_Amount_Invested) AS Total_amount_invested,
            AVG(Ghazal_Equity_Taken) AS Avg_Equity_Taken
    FROM
        shark_tank
    WHERE
        Ghazal_Amount_Invested != 0
            AND Ghazal_Equity_Taken != 'NA'
            AND Ghazal_Equity_Taken != 0) c ON a.Keyy = c.Keyy;
            

 
 
-- which is the Highest startup in which the highest amount has been invested in each domain/Sector

SELECT 
    *
FROM
    shark_tank;


select *,rank() over(partition by Sector order by Amount_Invested desc)
from
(select Brand,Sector,Deal,Amount_Invested from shark_tank where Deal!="No Deal" or Deal!=0)a;


