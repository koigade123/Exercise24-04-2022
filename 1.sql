-- 1.Obtain the names of all physicians that have performed a medical procedure THAT they have never been certified to perform.

SELECT 
P.Name
 FROM Physician as P
     JOIN Undergoes AS u
   ON P.EmployeeID = U.Physician
   left JOIN Trained_In as T
   ON U.Procedures = T.Treatment  AND P.EmployeeID = T.Physician
 WHERE T.Treatment IS NULL
 GROUP BY P.EmployeeID;

-- 2.	Same as the previous query, but include the following information in the results:
-- Physician name, name of procedure, date when the procedure was carried out,
-- name of the patient the procedure was carried out on.

SELECT 
p.name AS "Physician",
pr.name AS "Procedure",
 u.DateUndergoes,
pt.name AS "Patient"
FROM physician p,
     undergoes u,
     patient pt,
     procedures pr
WHERE u.patient = pt.SSN
  AND u.procedures = pr.Code
  AND u.physician = p.EmployeeID
  AND NOT EXISTS
    ( SELECT *
     FROM trained_in t
     WHERE t.treatment = u.procedures
       AND t.physician = u.physician );
       
-- 3.Obtain the names of all physicians that have performed a medical procedure that 
-- they are certified to perform, but such that the procedure was done at a date 
--  (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires).    
 
 SELECT 
 P.Name 
 FROM 
 Physician AS P,    
 Trained_In T,
 Undergoes AS U
 WHERE T.Physician=U.Physician 
 AND T.Treatment=U.Procedures
 AND U.DateUNDERGOES>T.CertificationExpires 
 AND P.EmployeeID=U.Physician;
 
       
-- 4.Same as the previous query, but include the following information in the results: 
-- Physician name, name of procedure, date when the procedure was carried out, 
-- name of the patient the procedure was carried out on, and date when the certification expired.   

SELECT
 P.Name AS Physician, 
 Pr.Name AS Procedures, 
 U.Dateundergoes,
 Pt.Name AS Patient, 
 T.CertificationExpires
  FROM 
  Physician P, 
  Undergoes U, 
  Patient Pt, 
  Procedures Pr,
  Trained_In T
  WHERE U.Patient = Pt.SSN
    AND U.Procedures = Pr.Code
    AND U.Physician = P.EmployeeID
    AND Pr.Code = T.Treatment
    AND P.EmployeeID = T.Physician
    AND U.Dateundergoes > T.CertificationExpires;    