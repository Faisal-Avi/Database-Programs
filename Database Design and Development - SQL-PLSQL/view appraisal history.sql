CREATE OR REPLACE VIEW hr_employee_appraisal_hist_v
AS
      SELECT history_table_id,
             id,
             level_ind,
             appraisal_type,
             appraisal_by,
             appraisal_by_name,
             appraisal_by_emp,
             appraisal_date,
             kpi_score,
             general_evaluation_score,
             overall_score,
             overall_category,
             performance_period,
             emp_id,
             emp_no,
             emp_name,
             designation,
             department
        FROM (SELECT h.history_table_id,
                     h.id,
                     h.level_ind,
                     'Self'                       appraisal_type,
                     h.self_app_by                appraisal_by,
                     u.user_name                  appraisal_by_name,
                     e.emp_name                   appraisal_by_emp,
                     h.self_app_date              appraisal_date,
                     h.self_app_kpi_score         kpi_score,
                     h.self_app_ge_score          general_evaluation_score,
                     h.self_app_overall_score     overall_score,
                     h.self_app_overall_cat       overall_category,
                     h.performance_period,
                     h.emp_id,
                     h.emp_no,
                     h.emp_name,
                     h.designation,
                     h.department
                FROM hr_emp_appraisal_mst_hist h, sys_users u, hr_employee_v e
               WHERE     h.level_ind = 1
                     AND h.self_app_by = u.user_id(+)
                     AND u.emp_id = e.emp_id(+)
              UNION ALL
              SELECT h.history_table_id,
                     h.id,
                     h.level_ind,
                     'Supervisor'     appraisal_type,
                     h.supv_app_by,
                     u.user_name      appraisal_by_name,
                     e.emp_name,
                     h.supv_app_date,
                     h.supv_kpi_score,
                     h.supv_app_ge_score,
                     h.supv_app_overall_score,
                     h.supv_app_overall_cat,
                     h.performance_period,
                     h.emp_id,
                     h.emp_no,
                     h.emp_name,
                     h.designation,
                     h.department
                FROM hr_emp_appraisal_mst_hist h, sys_users u, hr_employee_v e
               WHERE     h.level_ind = 2
                     AND h.supv_app_by = u.user_id(+)
                     AND u.emp_id = e.emp_id(+)
              UNION ALL
              SELECT h.history_table_id,
                     h.id,
                     h.level_ind,
                     'Head of Department'     appraisal_type,
                     h.hod_app_by,
                     u.user_name              appraisal_by_name,
                     e.emp_name,
                     h.hod_app_date,
                     h.hod_kpi_score,
                     h.hod_app_ge_score,
                     h.hod_app_overall_score,
                     h.hod_app_overall_cat,
                     h.performance_period,
                     h.emp_id,
                     h.emp_no,
                     h.emp_name,
                     h.designation,
                     h.department
                FROM hr_emp_appraisal_mst_hist h, sys_users u, hr_employee_v e
               WHERE     h.level_ind = 3
                     AND h.hod_app_by = u.user_id(+)
                     AND u.emp_id = e.emp_id(+)
              UNION ALL
              SELECT h.history_table_id,
                     h.id,
                     h.level_ind,
                     'Management'     appraisal_type,
                     h.ceo_app_by,
                     u.user_name      appraisal_by_name,
                     e.emp_name,
                     h.ceo_app_date,
                     h.ceo_kpi_score,
                     h.ceo_app_ge_score,
                     h.ceo_app_overall_score,
                     h.ceo_app_overall_cat,
                     h.performance_period,
                     h.emp_id,
                     h.emp_no,
                     h.emp_name,
                     h.designation,
                     h.department
                FROM hr_emp_appraisal_mst_hist h, sys_users u, hr_employee_v e
               WHERE     h.level_ind = 4
                     AND h.ceo_app_by = u.user_id(+)
                     AND u.emp_id = e.emp_id(+)
              UNION ALL
              SELECT h.history_table_id,
                     h.id,
                     h.level_ind,
                     'HR'            appraisal_type,
                     h.hr_app_by,
                     u.user_name     appraisal_by_name,
                     e.emp_name,
                     h.hr_app_date,
                     h.hr_kpi_score,
                     h.hr_app_ge_score,
                     h.hr_app_overall_score,
                     h.hr_app_overall_cat,
                     h.performance_period,
                     h.emp_id,
                     h.emp_no,
                     h.emp_name,
                     h.designation,
                     h.department
                FROM hr_emp_appraisal_mst_hist h, sys_users u, hr_employee_v e
               WHERE     h.level_ind = 5
                     AND h.hr_app_by = u.user_id(+)
                     AND u.emp_id = e.emp_id(+))
    ORDER BY level_ind;