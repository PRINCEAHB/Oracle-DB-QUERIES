--575 purchase invoices
SELECT * --sum(PURCHASE_VALUE),sum(vat_amount)
FROM IRIS_STRV.FORM_PURCHASE_INVOICES 
where  FORM_ID IN (SELECT  transaction_id
FROM iris.st_workflow
WHERE registration_no = '2532306'
AND trunc(period_start_date) >= '01-Jun-22'
AND trunc(period_end_date) <= '30-sep-22'
AND case_stage_code = '2'
AND task_code = '2171');
--remarks is not null and
--get data of purchase invoices which submitted returns
SELECT * FROM IRIS_STRV.FORM_PURCHASE_INVOICES where remarks is not null and FORM_ID IN (SELECT  transaction_id
FROM iris.st_workflow
WHERE registration_no = '0660308'
AND trunc(period_start_date) >= '01-Feb-22'
AND trunc(period_end_date) <= '30-Apr-23'
AND case_stage_code = '2'
AND task_code = '2171');


SELECT  dd.DDOC_ID, si.FORM_SI_ID, pi.FORM_PI_ID, wf.TRANSACTION_ID,
    CASE  WHEN dd.DDOC_ID IS NOT NULL THEN 'Exists in Domestic_documents'
        ELSE 'Does not exist in Domestic_documents'
    END AS in_domestic_documents,
    CASE  WHEN si.FORM_SI_ID IS NOT NULL THEN 'Exists in Form_Sale_invoices'
        ELSE 'Does not exist in Form_Sale_invoices'
    END AS in_form_sale_invoices,
    CASE WHEN pi.FORM_PI_ID IS NOT NULL THEN 'Exists in Form_Purchase_Invoices'
        ELSE 'Does not exist in Form_Purchase_Invoices'
    END AS in_form_purchase_invoices,
    CASE WHEN wf.TRANSACTION_ID IS NOT NULL THEN 'Exists in Workflow'
        ELSE 'Does not exist in Workflow'
    END AS in_workflow
FROM   IRIS_STRV.Domestic_documents dd
LEFT JOIN   IRIS_STRV.Form_Sale_invoices si ON dd.FORM_SI_ID = si.FORM_SI_ID
LEFT JOIN   IRIS_STRV.Form_Purchase_Invoices pi ON dd.FORM_PI_ID = pi.FORM_PI_ID
LEFT JOIN   IRIS.ST_Workflow wf ON dd.FORM_ID_SALE = wf.TRANSACTION_ID;
where dd.seller_reg_no ='0256219' and dd.doc_tax_period ='202309';

SELECT * FROM v$version;

--display all ojbects in database
SELECT * --OBJECT_NAME
FROM ALL_OBJECTS
 WHERE OBJECT_TYPE = 'TABLE'
AND OWNER = 'IRIS_STRV'
 ORDER BY OBJECT_NAME;
 
 SELECT registration_no, transaction_id, period_start_date
FROM iris.st_workflow
WHERE registration_no = '2532306'
AND trunc(period_start_date) >= '01-Jun-22'
AND trunc(period_end_date) <= '30-sep-22'
AND case_stage_code = '2'
AND task_code = '2171';

SELECT form_id,HS_CODE,COUNT(*) Total_Records FROM iris_strv.form_sale_invoices
where form_id in (233132214,1000000904702593) 
group by form_id,HS_CODE;

 --8b Exclusion List
SELECT *--COUNT(*)
FROM IRIS.ST_WORKFLOW wf
JOIN iris_strv.VAT_RULE_GRNTORREVACCESSTONTN b
ON b.registration_no = wf.registration_no
WHERE trunc(wf.PERIOD_START_DATE) between '01-dec-23' and '31-dec-23'
    AND b.isactive = 1
    AND b.ruleid IN (16, 3)
    AND wf.registration_no = '8844460';
    