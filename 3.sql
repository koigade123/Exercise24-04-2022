-- The hospital has several examination rooms where appointments take place. 
-- Obtain the number of appointments that have taken place in each examination room.
SELECT 
ExaminationRoom, 
COUNT(AppointmentID) AS Number 
FROM Appointment
GROUP BY ExaminationRoom;


/* 8. Obtain the names of all patients (also include, for each patient, the name of the patient's primary care physician), such that \emph{all} the following are true:
•	The patient has been prescribed some medication by his/her primary care physician.
•	The patient has undergone a procedure with a cost larger that $5,000
•	The patient has had at least two appointment where the nurse who prepped the appointment was a registered nurse.
•	The patient's primary care physician is not the head of any department.*/


