-- 5.Obtain the information for appointments where a patient met with a physician 
-- other than his/her primary care physician. Show the following information: Patient name, 
-- physician name, nurse name (if any), start and end time of appointment, examination room, 
-- and the name of the patient's primary care physician.

SELECT 
Pt.Name AS Patient, 
Ph.Name AS Physician,
 N.Name AS Nurse,
 A.Start, 
 A.End, 
 A.ExaminationRoom, 
 PhPCP.Name AS PCP
  FROM 
  Patient Pt, 
  Physician Ph, 
  Physician PhPCP,
  Appointment A 
  LEFT JOIN Nurse N 
  ON A.PrepNurse = N.EmployeeID
 WHERE A.Patient = Pt.SSN
   AND A.Physician = Ph.EmployeeID
   AND Pt.PCP = PhPCP.EmployeeID
   AND A.Physician <> Pt.PCP;
   
-- 6.The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. 
-- There are no constraints in force to prevent inconsistencies between these two tables. 
-- More specifically, the Undergoes table may include a row where the patient ID does not match 
-- the one we would obtain from the Stay table through the Undergoes.Stay foreign key. 
-- Select all rows from Undergoes that exhibit this inconsistency.

SELECT 
* FROM Undergoes U
 WHERE Patient <> 
   (
     SELECT Patient FROM Stay S
      WHERE U.Stay = S.StayID
   );
   
   -- Obtain the names of all the nurses who have ever been on call for room 123.
   SELECT
   N.Name 
   FROM Nurse N
 WHERE EmployeeID IN
   (
     SELECT OC.Nurse FROM On_Call OC, Room R
      WHERE OC.BlockFloor = R.BlockFloor
        AND OC.BlockCode = R.BlockCode
        AND R. RoomNumber = 123
   );