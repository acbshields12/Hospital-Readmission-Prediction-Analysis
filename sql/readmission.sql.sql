create database Readmission_Analysis;
use Readmission_Analysis;

CREATE TABLE readmission_data (
    patient_id INT,
    age INT,
    gender VARCHAR(10),
    admission_date DATE,
    discharge_date DATE,
    diagnosis VARCHAR(50),
    treatment_type VARCHAR(50),
    length_of_stay INT,
    readmitted VARCHAR(5),
    comorbidities INT,
    insurance_type VARCHAR(20),
    hospital_department VARCHAR(50)
);

select *
from readmission_data;

-- Total Patients --
select count(*)
from readmission_data;

-- Average Length of Stay --
select avg(length_of_stay) as avg_stay
from readmission_data;

-- Count by Gender --
select gender, count(*)
from readmission_data
group by gender;

-- Readmitted Count --
select readmitted, count(*)
from readmission_data
group by readmitted;

-- Readmission Rate --
select 
count(case when readmitted = 'Yes' then 1 end) * 100.0 / count(*) as readmission_rate
from readmission_data;

-- Age Group --
select
case 
when age < 30 then 'Young'
when age between 30 and 60 then 'Adult'
else 'Senior'
end as age_group,
count(*) as total
from readmission_data
group by age_group;

-- Department Performance --
select hospital_department,
count(*) as total_patients,
sum(readmitted = 'Yes') as readmitted_count
from readmission_data
group by hospital_department;

-- Patients who were Admitted --
select *
from readmission_data
where patient_id in (select patient_id from readmission_data where readmitted = 'Yes');

-- Patients with above-average stay --
select *
from readmission_data
where length_of_stay > (select avg(length_of_stay) from readmission_data);

-- Percentage per Diagnosis --
select diagnosis,
count(*) as total,
sum(readmitted = 'Yes') *100.0 / count(*) as readmission_rate
from readmission_data
group by diagnosis
order by readmission_rate desc;

-- Multiple Conditions --
select *
from readmission_data
where age > 60 
and readmitted = 'Yes'
and comorbidities >= 2;



