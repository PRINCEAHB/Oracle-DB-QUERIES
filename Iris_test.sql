select   
             DDOC_ID,DOC_TYPE_ID,case_status_code,FORM_ID_SALE,FORM_ID_PURCHASE,SELLER_REG_NO,
             BUYER_REG_NO,DOC_NO,DOC_DATE,DOC_TAX_PERIOD,DOC_STAGE_CODE
     from iris_strv.domestic_documents 
     where buyer_reg_no = '4410372615443' and doc_type_id ='4' ;
     
                   
select * from iris_new.workflow where  registration_no  = '4410372615443' ; --case_stage_code <> 9  and

select * from iris_new.wf_data where transaction_id = '210537143' ;

SELECT * FROM IRIS_NEW.WORKFLOW WHERE TRANSACTION_ID ='4120306303925';

select * from iris_new.payments where registration_no = '4410372615443';

select * from iris_new.registration where registration_no ='8885801'; 

--PRE-ANNEXTURE INVOICE STAGES/STATUS
--DOCTYPE -1 PURCHASE INVOICE , -4 SALE INVOICE ,7 SWTH, 9 DEBIT , 10 CREDIT
--DOCSTAGE=1 FOR PREANNEXTURE INVOICE
--DOC_STATUS =2
--CASE_STATUS_CODE =2
--PROVISIONAL CREDIT AVAILABLE (WHEN INVOICE CLAIM AND SUBMIT ANNEX-C OF PERIOD-A THEN STAGE_CODE (3) )
--CLAMANT PAYABLE (WHEN INVOICE CLAIM AND SUBMIT RETURN OF PERIOD-A THEN STAGE CODE (4) 7A MADE)



 select * from iris_strv.domestic_documents 
 where buyer_reg_no = '3520191354993'  and seller_reg_no ='3520191354993' and doc_tax_period= '202201'
-- and invoice_source ='10'
 --and doc_type_id ='10'
 --and doc_stage_code ='4'
 ;
 
       
       
             SELECT       
             DD.DDOC_ID,DD.DOC_TYPE_ID,DD.case_status_code,DD.FORM_ID_SALE,
             DD.FORM_ID_PURCHASE,DD.SELLER_REG_NO,
             DD.BUYER_REG_NO,DD.DOC_NO,DD.DOC_DATE,DD.DOC_TAX_PERIOD,DD.DOC_STAGE_CODE 
             from IRIS_STRV.DOMESTIC_DOCUMENTS DD
             WHERE EXISTS 
             ( SELECT 1 from IRIS_STRV.FORM_SALE_INVOICES SI
              WHERE SI.DDOC_ID = DD.DDOC_ID
                   ); 
             
             
             

--This is used for documents status like valid claimed rejected
SELECT * FROM IRIS_STRV.DOCUMENT_STATUS;

--This is used for doc_Stages_code
SELECT * FROM IRIS_STRV.DOCUMENT_STAGES;

--Document Tpyes like which type of documents like purchase sale etc
SELECT * FROM IRIS_STRV.SA_DOC_TYPES;

-- ANNEXK-A (PURCHASES)
SELECT * FROM Iris_strv.FORM_PURCHASE_INVOICES where buyer_reg_no = '4120306303925';

-- ANNEXK-C (SALES)
  SELECT * FROM IRIS_STRV.FORM_SALE_INVOICES WHERE seller_reg_no='3310091542647';

--This is used for Annex-B Import
select * from iris_strv.FORM_GDI_DETAILS;

--This is used for Annex-D Export GD 
select * from iris_strv.FORM_EXPORT_DETAILS;

--REGISTRATION (TP)
  select * from iris_new.registration where registration_no ='3310091542647';  

--TP WORKFLOW
select * from iris_new.workflow where transaction_id ='210538746';
   
--MESSAGES(IRIS)
select * from iris_new.sa_messages ;

-- sa_tasks
select * from iris_new.sa_tasks WHERE TASK_DESC LIKE '%Application for correction in CPR';
    
--It is used for active status in sales tax      
select * from iris_strv.REG_TRUST_LEVEL;

--This is used for Annex-J
select * from iris_strv.FORM_SRPS_DETAILS;
 
--this is used for rules define description
SELECT * FROM IRIS_STRV.SA_VAT_RULES;

--This is used for invoice source status
select * from iris_strv.SA_INVOICE_SOURCES;

--This is used for documents source means online manual etc
select * from iris_strv.DOCUMENT_SOURCE_MEDIUMS;

--This is used for medium like online or manual
select * from iris_strv.SA_MEDIUMS;

--This is used for provinces
select * from iris_strv.SA_STATES_PROVINCES;

--Used for Import GD types data
select * from iris_strv.SA_CUSTOM_GD_TYPES;

--use for status of invoices
select * from iris_strv.SA_STATUS_CODES;

--This is user for provincial invoices for claim in FBR
select * from iris_strv.COMMERCIAL_VAT_DSI_DETAILS;

--this is used for 8b exclusion description SRO 1190
select * from iris_strv.SA_VAT_8B_EXCLUSION_REASONS;

--Details of annex descriptions
select * from iris_strv.SA_VAT_ANNEXURE_CODE;

--This is used for documents type
select * from iris_strv.SA_VAT_DOC_TYPE_CODE;

--this is used for sec-8b reason
select * from iris_strv.SA_VAT_REASONS;


select dd.seller_reg_no, count(*)  No_Of_Invoices
from iris_strv.domestic_documents dd ,
  iris_strv.form_sale_invoices si
where si.ddoc_id = dd.ddoc_id 
group by dd.seller_reg_no
order by 2 desc;




select 118039-72199 from dual;




