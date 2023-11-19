HR_EMPLOYEE_ACTIVITIES_MASTER  --- Activity Master Data
---------------
EMPLOYEE_ACTIVITY_TAB          --- Objective and Employee wise activity
------------------------

HR_EMPLOYEE_OBJECTIVES_MASTER  --- Objective Master Data 
-------------------------
EMPLOYEE_OBJECTIVE_TAB         --- Employee Wise Objective

----------------------------
HR_GENERAL_EVALUATION          --- General Evaluation Setup data
HR_GENERAL_EVALUATION_DETAIL   --- General Evaluation Setup data
----------------------------

----------------------------   --- Main Table 
HR_EMPLOYEE_APPRAISAL_MST
HR_EMP_APPRAISAL_KPI
HR_EMP_APPRAISAL_GEN_EVLN

----------------------------   --- History Table
HR_EMP_APPRAISAL_MST_HIST
HR_EMP_APPRAISAL_KPI_HIST
HR_EMP_APPRAISAL_GEN_EVLN_HIST





----------------------------

CREATE TABLE hr_general_evaluation (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    created_by NUMBER,
    created_date DATE,
    last_updated_by NUMBER,
    last_updated_date DATE
);

ALTER TABLE hr_general_evaluation
ADD from_duputy_manager_ind VARCHAR2(10);

CREATE TABLE hr_general_evaluation_detail (
    id NUMBER PRIMARY KEY,
    master_id NUMBER,
    evaluation_detail VARCHAR2(300),
    marks NUMBER,
    created_by NUMBER,
    created_date DATE,
    last_updated_by NUMBER,
    last_updated_date DATE
);



CREATE TABLE hr_employee_appraisal_mst (
    id NUMBER PRIMARY KEY,
    company_id NUMBER,
    company_name VARCHAR2(100),
    branch_id NUMBER,
    branch_name VARCHAR2(100),
    emp_id NUMBER,
    emp_no VARCHAR2(50),
    emp_name VARCHAR2(100),
    designation VARCHAR2(50),
    department VARCHAR2(50),
    grade VARCHAR2(50),
    joining_date DATE,
    time_in_position VARCHAR2(50),
    fiscal_year_id NUMBER,
    performance_period VARCHAR2(50),
    start_date DATE,
    end_date DATE,
    comments VARCHAR2(500),
    ip_address VARCHAR2(50),
    terminal VARCHAR2(50),
    last_updated_ip VARCHAR2(50),
    last_updated_terminal VARCHAR2(50),
    created_by NUMBER,
    created_date DATE,
    last_updated_by NUMBER,
    last_updated_date DATE
);

CREATE TABLE hr_emp_appraisal_gen_evln (
    id NUMBER PRIMARY KEY,
    master_id NUMBER,
    general_evaluation_id NUMBER,
    general_evaluation_name VARCHAR2(50),
    obtained_marks NUMBER,
    ip_address VARCHAR2(50),
    terminal VARCHAR2(50),
    last_updated_ip VARCHAR2(50),
    last_updated_terminal VARCHAR2(50),
    created_by NUMBER,
    created_date DATE,
    last_updated_by NUMBER,
    last_updated_date DATE
);

ALTER TABLE hr_employee_appraisal_mst 
ADD (
    SELF_APP_KPI_SCORE NUMBER, 
    SELF_APP_GE_SCORE NUMBER, 
    SELF_APP_OVERALL_SCORE NUMBER, 
    SELF_APP_OVERALL_CAT VARCHAR2(50), 
    SELF_APP_BY NUMBER,
    SELF_APP_BY_NAME VARCHAR2(50), 
    SELF_APP_DATE DATE, 
    SUPV_KPI_SCORE NUMBER, 
    SUPV_APP_GE_SCORE NUMBER, 
    SUPV_APP_OVERALL_SCORE NUMBER, 
    SUPV_APP_OVERALL_CAT VARCHAR2(50),
    SUPV_APP_BY NUMBER,  
    SUPV_APP_BY_NAME VARCHAR2(50), 
    SUPV_APP_DATE DATE, 
    HOD_KPI_SCORE NUMBER, 
    HOD_APP_GE_SCORE NUMBER, 
    HOD_APP_OVERALL_SCORE NUMBER, 
    HOD_APP_OVERALL_CAT VARCHAR2(50),
    HOD_APP_BY NUMBER, 
    HOD_APP_BY_NAME VARCHAR2(50), 
    HOD_APP_DATE DATE, 
    HR_KPI_SCORE NUMBER, 
    HR_APP_GE_SCORE NUMBER, 
    HR_APP_OVERALL_SCORE NUMBER, 
    HR_APP_OVERALL_CAT VARCHAR2(50),
    HR_APP_BY NUMBER, 
    HR_APP_BY_NAME VARCHAR2(50),  
    HR_APP_DATE DATE, 
    CEO_KPI_SCORE NUMBER, 
    CEO_APP_GE_SCORE NUMBER, 
    CEO_APP_OVERALL_SCORE NUMBER, 
    CEO_APP_OVERALL_CAT VARCHAR2(50), 
    CEO_APP_BY NUMBER, 
    CEO_APP_BY_NAME VARCHAR2(50),
    CEO_APP_DATE DATE
);

CREATE TABLE gbl_sec_objectgroup
(
  OBJECTGROUP_ID     NUMBER PRIMARY KEY,
  OBJECTGROUP_NAME   VARCHAR2(100 BYTE),
  DESCR              VARCHAR2(500 BYTE),
  ACTIVE_IND         VARCHAR2(1 BYTE),
  CREATED_BY         NUMBER(10),
  CREATED_DATE       DATE,
  LAST_UPDATED_BY    NUMBER(20),
  LAST_UPDATED_DATE  DATE
);

SET DEFINE OFF;
Insert into GBL_SEC_OBJECTGROUP
   (OBJECTGROUP_ID, OBJECTGROUP_NAME, DESCR, ACTIVE_IND, CREATED_BY, 
    CREATED_DATE, LAST_UPDATED_BY, LAST_UPDATED_DATE)
 Values
   (1, 'BUTTON', 'Buttons on Forms', 'Y', NULL, 
    NULL, NULL, NULL);
Insert into GBL_SEC_OBJECTGROUP
   (OBJECTGROUP_ID, OBJECTGROUP_NAME, DESCR, ACTIVE_IND, CREATED_BY, 
    CREATED_DATE, LAST_UPDATED_BY, LAST_UPDATED_DATE)
 Values
   (2, 'TEXTFIELD', 'Text Field on Forms', 'Y', NULL, 
    NULL, NULL, NULL);
Insert into GBL_SEC_OBJECTGROUP
   (OBJECTGROUP_ID, OBJECTGROUP_NAME, DESCR, ACTIVE_IND, CREATED_BY, 
    CREATED_DATE, LAST_UPDATED_BY, LAST_UPDATED_DATE)
 Values
   (3, 'FILTEREDDATA', 'Partial Table Data', 'Y', NULL, 
    NULL, NULL, NULL);
COMMIT;



CREATE TABLE gbl_sec_object
(
  OBJECT_ID          NUMBER PRIMARY KEY,
  OBJECTGROUP_ID     NUMBER ,
  OBJECT_NAME        VARCHAR2(100 BYTE),
  DISPLAY_NAME       VARCHAR2(100 BYTE),
  DESCR              VARCHAR2(500 BYTE),
  ACTIVE_IND         VARCHAR2(1 BYTE),
  QUERY_ALLOWED      VARCHAR2(1 BYTE),
  INSERT_ALLOWED     VARCHAR2(1 BYTE),
  UPDATE_ALLOWED     VARCHAR2(1 BYTE),
  DELETE_ALLOWED     VARCHAR2(1 BYTE),
  EXECUTE_ALLOWED    VARCHAR2(1 BYTE),
  CREATED_BY         NUMBER(10),
  CREATED_DATE       DATE,
  LAST_UPDATED_BY    NUMBER(20),
  LAST_UPDATED_DATE  DATE
);

SET DEFINE OFF;
Insert into GBL_SEC_OBJECT
   (OBJECT_ID, OBJECTGROUP_ID, OBJECT_NAME, DISPLAY_NAME, DESCR, 
    ACTIVE_IND, QUERY_ALLOWED, INSERT_ALLOWED, UPDATE_ALLOWED, DELETE_ALLOWED, 
    EXECUTE_ALLOWED, CREATED_BY, CREATED_DATE, LAST_UPDATED_BY, LAST_UPDATED_DATE)
 Values
   (1, 1, 'EmpAppraisalHrActivity', 'EmpAppraisalHrActivity', 'With This Security Object User can perform HR activity in employee Appraisal', 
    'Y', 'Y', 'Y', 'Y', 'Y', 
    'Y', NULL, NULL, NULL, NULL);
Insert into GBL_SEC_OBJECT
   (OBJECT_ID, OBJECTGROUP_ID, OBJECT_NAME, DISPLAY_NAME, DESCR, 
    ACTIVE_IND, QUERY_ALLOWED, INSERT_ALLOWED, UPDATE_ALLOWED, DELETE_ALLOWED, 
    EXECUTE_ALLOWED, CREATED_BY, CREATED_DATE, LAST_UPDATED_BY, LAST_UPDATED_DATE)
 Values
   (2, 1, 'EmpAppraisalManagementActivity', 'EmpAppraisalManagementActivity', 'With This Security Object User can perform Management activity in employee Appraisal', 
    'Y', 'Y', 'Y', 'Y', 'Y', 
    'Y', NULL, NULL, NULL, NULL);
Insert into GBL_SEC_OBJECT
   (OBJECT_ID, OBJECTGROUP_ID, OBJECT_NAME, DISPLAY_NAME, DESCR, 
    ACTIVE_IND, QUERY_ALLOWED, INSERT_ALLOWED, UPDATE_ALLOWED, DELETE_ALLOWED, 
    EXECUTE_ALLOWED, CREATED_BY, CREATED_DATE, LAST_UPDATED_BY, LAST_UPDATED_DATE)
 Values
   (3, 1, 'EmpAppraisalHodActivity', 'EmpAppraisalHodActivity', 'With This Security Object User can perform HOD activity in employee Appraisal', 
    NULL, NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL);
COMMIT;


CREATE TABLE gbl_sec_objectaccess
(
  USER_ID            NUMBER,
  OBJECT_ID          NUMBER,
  DISPLAY_NAME       VARCHAR2(100 BYTE),
  ACCESS_ALLOWED     VARCHAR2(1 BYTE),
  QUERY_ALLOWED      VARCHAR2(1 BYTE),
  INSERT_ALLOWED     VARCHAR2(1 BYTE),
  UPDATE_ALLOWED     VARCHAR2(1 BYTE),
  DELETE_ALLOWED     VARCHAR2(1 BYTE),
  EXECUTE_ALLOWED    VARCHAR2(1 BYTE),
  ACTIVE_IND         VARCHAR2(1 BYTE),
  CREATED_BY         NUMBER(10),
  CREATED_DTTM       DATE,
  LAST_UPDATED_BY    NUMBER(20),
  LAST_UPDATED_DATE  DATE
);

SET DEFINE OFF;
Insert into GBL_SEC_OBJECTACCESS
   (USER_ID, OBJECT_ID, DISPLAY_NAME, ACCESS_ALLOWED, QUERY_ALLOWED, 
    INSERT_ALLOWED, UPDATE_ALLOWED, DELETE_ALLOWED, EXECUTE_ALLOWED, ACTIVE_IND, 
    CREATED_BY, CREATED_DTTM, LAST_UPDATED_BY, LAST_UPDATED_DATE)
 Values
   (109, 3, 'EmpAppraisalHodActivity', 'Y', 'Y', 
    'Y', 'Y', 'Y', 'Y', 'Y', 
    NULL, NULL, NULL, NULL);
COMMIT;



CREATE SEQUENCE seq_general_evaluation_hist
  START WITH 1
  MAXVALUE 999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER
  NOKEEP
  NOSCALE
  GLOBAL;
  
CREATE SEQUENCE seq_appraisal_kpi_hist
  START WITH 1
  MAXVALUE 999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER
  NOKEEP
  NOSCALE
  GLOBAL;


--------------------------------------------------------

---------------------------------------------------------

CREATE OR REPLACE VIEW hr_employee_appraisal_v
AS
SELECT sc.company_name,
       sb.branch_name,
       ap.performance_period,
       ap.start_date,
       ap.end_date,
       ap.emp_id,
       ap.emp_no,
       ap.emp_name,
       ap.designation,
       ap.department,
       ap.grade,
       ap.joining_date,
       ap.supervisor_name,
       ap.company_id,
       ap.branch_id,
       ap.self_app_by,
       ap.self_app_by_name,
       ap.self_app_date,
       ap.supv_app_by,
       ap.supv_app_by_name,
       ap.supv_app_date,
       ap.hod_app_by,
       ap.hod_app_by_name,
       ap.hod_app_date,
       ap.ceo_app_by,
       ap.ceo_app_by_name,
       ap.ceo_app_date,
       ap.hr_app_by,
       ap.hr_app_by_name,
       ap.hr_app_date,
       ap.appraisee_comments,
       ap.supervisor_comments,
       ap.hod_comments,
       ap.ceo_comments,
       ap.hr_comments,
       ap.id
FROM hr_employee_appraisal_mst ap, 
     sys_companies sc, 
     sys_branches sb
WHERE ap.company_id = sc.company_id(+)
AND ap.branch_id = sb.branch_id(+);



---------------------------------------------------------------





