--Punto 1

CREATE TABLESPACE quiz_noche
    DATAFILE 'ARCHIVO1.dbf' SIZE 10M 
;

ALTER TABLESPACE quiz_noche ADD
    DATAFILE 'ARCHIVO2.dbf' SIZE 10M
;

--Punto 2
CREATE PROFILE estudiante LIMIT
CONNECT_TIME 300
;
ALTER PROFILE estudiante LIMIT SESSIONS_PER_USER 2;
ALTER PROFILE estudiante LIMIT CPU_PER_SESSION UNLIMITED;

--Punto 3
CREATE USER user1
    IDENTIFIED BY user1
    DEFAULT TABLESPACE quiz_noche
    PROFILE estudiante
;


GRANT CREATE SESSION,CREATE TABLE TO user1;

create table attacks (
	id INT,
	url VARCHAR(2048),
	ip_address VARCHAR(20),
	number_of_attacks INT,
	time_of_last_attack TIMESTAMP
);

CREATE USER user2
    IDENTIFIED BY user2
    DEFAULT TABLESPACE quiz_noche
    PROFILE estudiante
;


GRANT CREATE USER TO user2;


/*QUERY 1*/
SELECT
    COUNT(1) TOTAL
FROM
    attacks
WHERE
    URL LIKE '%http%'
;
    
/*QUERY 2*/    
    
SELECT
    *
FROM
    attacks  
WHERE
    URL LIKE '%google%'
ORDER BY
    NUMBER_OF_ATTACKS DESC
;
    
    
    
/*QUERY 3*/    
    
SELECT
    IP_ADDRESS
    ,TO_CHAR(TIME_OF_LAST_ATTACK,'HH:MM:SS') HORA
    ,TO_CHAR(TIME_OF_LAST_ATTACK,'YYYY') HORA
FROM
    attacks  
WHERE
    TO_CHAR(TIME_OF_LAST_ATTACK,'YYYY') = 2018
;
    
    
/*QUERY 4*/    
SELECT
    *
FROM
(
    SELECT
        IP_ADDRESS
        ,ROW_NUMBER() OVER (ORDER BY NUMBER_OF_ATTACKS desc) rn
        ,NUMBER_OF_ATTACKS
    FROM
        attacks  
    WHERE
        TO_CHAR(TIME_OF_LAST_ATTACK,'YYYY') = 2018
) T1
WHERE
    RN = 1
;
        
/*QUERY 5*/        
        
 SELECT
    COUNT(1) TOTAL
FROM
    attacks
WHERE
    URL LIKE '%instagram%'
   ;
    
    