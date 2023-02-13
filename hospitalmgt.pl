% hospital management system in Prolog

% Facts
:- dynamic department/3.
department(icu, 20, 50).
department(general, 50, 100).
department(vip, 100, 50).
department(speciality, 30, 50).
:- dynamic doctor/3.
doctor(name, speciality, experience).
:- dynamic patient/3.
patient(name, age, symptoms).
:- dynamic doctorPatient/3.
doctorPatient(patient,doctor).
:- dynamic doctor_fees/2.
doctor_fees(doctor,docFees).
dept_fees(department,deptFees).

% Rules
add_patient(Name,Age,Symptoms):-
    consult('C:/Users/devar/OneDrive/Documents/Prolog/hospitalmgt.pl'),
    asserta(patient(Name,Age,Symptoms)).

add_doctor(Name,Speciality,Experience,DocFees):-
    %add path of saved file to consult and change backward to forward slash
    consult('C:/Users/devar/OneDrive/Documents/Prolog/hospitalmgt.pl'),
    asserta(doctor(Name,Speciality,Experience)),
    asserta(doctor_fees(Name,DocFees)).

available_bedsStaff(Department):-
    department(Department, Staff, Beds),
    write('No. of beds available: '),write(Beds),nl,
    write('No. of staffs available: '),write(Staff).

assign_bed(Department, Patient):-
    patient(Patient, _,_),
    department(Department, Staff, Beds),
    Beds > 0,
    NewBeds is Beds - 1,
    Staff>0,
    NewStaff is Staff-1,
    retract(department(Department, Staff, Beds)),
    asserta(department(Department, NewStaff, NewBeds)).

release_bed(Department, Patient):-
    patient(Patient, _, _),
    department(Department,Staff, Beds),
    NewBeds is Beds + 1,
    NewStaff is Staff+1,
    retract(department(Department, Staff, Beds)),
    asserta(department(Department, NewStaff, NewBeds)).


listAvlDoctors:-
    doctor(Doctor, Speciality,Experience),
    not(doctorPatient(_,Doctor)),
    write('Doctors Name: '), write(Doctor), nl,
    write('Speciality: '), write(Speciality), nl,
    write('Experience: '), write(Experience),write(' years'), nl,
    write('-----'), nl,
    fail.
listAvlDoctors.

assign_doctor(Patient, Doctor):-
    %add path of saved file to consult and change backward to forward slash
    consult('C:/Users/devar/OneDrive/Documents/Prolog/hospitalmgt.pl'),
    asserta(doctorPatient(Patient,Doctor)).

release_doctorPatient(Patient,Doctor):-
    retract(doctorPatient(Patient,Doctor)),
    retract(patient(Patient,_,_,_)).

assign_medicine(Medicine,Patient):-
    %add path of saved file to consult and change backward to forward slash
    consult('C:/Users/devar/OneDrive/Documents/Prolog/hospitalmgt.pl'),
    asserta(medicine(Medicine,Patient)).



bill(Patient,Doctor,Department):-
    patient(Patient,Age,_,_),
    doctor_fees(Doctor,DocFees),
    dept_fees(Department,DeptFees),
    medicine(Medicine,Patient),
    write('--------------------------------------'),nl,
    write('Patient: '),write(Patient),nl,
    write('Age: '),write(Age),nl,
    write('Doctor: '),write(Doctor),nl,
    write('Department: '),write(Department),nl,
    write('Medicine: '),write(Medicine),nl,
    write('Visiting Fees: '),write(DocFees),nl,
    write('Department Fees: '),write(DeptFees),nl,
    TotalFees is DocFees+DeptFees,
    write('Total Fees: '),write(TotalFees),nl,
    write('--------------------------------------').



























