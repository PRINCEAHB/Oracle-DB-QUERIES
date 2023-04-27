--S.T IRIS TEST USERS  3310462329905 3610315876515

SELECT * FROM iris_strv.domestic_documents
WHERE seller_reg_no = '3310462329905'  AND DOC_TAX_PERIOD='202206';

SELECT * FROM IRIS_STRV.form_sale_invoices WHERE seller_reg_no = '3310462329905';

SELECT * FROM IRIS_STRV.FORM_PURCHASE_INVOICES WHERE buyer_reg_no='3310462329905';

SELECT * FROM Iris_new.workflow where REGISTRATION_NO='3610315876515';

select TRANSACTION_ID,AMOUNT_CODE,COL_A,COL_B,COL_C from iris_new.wf_data where TRANSACTION_ID='1000000902426017';


select * from iris_strv.sa_vat_rules;

select * from iris_strv.document_stages;

SELECT * FROM IRIS_STRV.DOCUMENT_STATUS WHERE DOC_STATUS ='2';

select *  --PAYMENT_ID,CPR_NO,REGISTRATION_NO,AMOUNT,TAX_MONTH,TAX_YEAR 
from iris_new.payments where registration_no='3610315876515'
and tax_month = '6'
--and CPR_NO='ST2021062900001146803'
;
SELECT * FROM IRIS_STRV.SA_REG_VERIFICATION_STATUS;
SELECT * FROM IRIS_STRV.FORM_PRM_DETAILS_FOR_STRV;

Select * from iris_strv.SA_VAT_ITEM_DESC_CODE where ITEM_DESC_CODE ='9018';

select * from iris_new.sa_messages where message_desc='&Transaction is not allowed as it is barred by time&';
select * from all_source where upper(text)like '%MSG.ST.VLD-012%';
select * from iris_new.registration;
select * from iris_strv.SA_VAT_UOM;
select * from iris_strv.st_types;
select * from iris_strv.sa_workflow_rules_sales_tax;
select DESCRIPTION from iris_strv.sa_custom_gd_types where CODE='TI';
SELECT * FROM IRIS_STRV.SA_DOC_TYPES;
SELECT * FROM IRIS_STRV.SA_VAT_ANNEXURE_CODE;
SELECT * FROM IRIS_STRV.DOMESTIC_DOCUMENTS;
SELECT * FROM IRIS_STRV.SA_VAT_DOC_TYPE_CODE;
select * from IRIS_STRV.DOCUMENT_STATUS;
select * from IRIS_STRV.DOCUMENT_STAGES;
select * from iris_new.payments;
select * from iris_strv.mvu_pos_invoice_count where REGISTRATION_NO ='3520105258813';
select * from iris_strv.ims_for_annexc;

Select * From IRIS_NEW.WF_DATA 
where amount_Code in (200104, 200204, 200304, 100601 ,100108)
and transaction_id = 1000000902417474
and (Col_A < 0 or Col_B < 0 or Col_C < 0);

SELECT * FROM IRIS_STRV.SA_VAT_SRO_CODE;
SELECT * FROM IRIS_STRV.Form_GDI_Details;
SELECT * FROM IRIS_STRV.Form_export_Details;
SELECT * FROM IRIS_STRV.SA_VAT_TRANSACTION_TYPE_CODE;

select * from iris_new.ledger;



SELECT * FROM IRIS_STRV.SA_VAT_UOM;

select * from iris_strv.sa_workflow_rules_sales_tax;
select * from iris_strv.sa_vat_rules;
select * from iris_strv.sa_trans_type_field_rule;
select * from iris_new.payments;
SELECT * FROM IRIS_STRV.Domestic_documents;
SELECT * FROM IRIS_STRV.Form_Purchase_Invoices;
SELECT * FROM IRIS_STRV.Form_Sale_invoices;
SELECT * FROM IRIS_STRV.Form_GDI_Details;
SELECT * FROM IRIS_STRV.Form_export_Details;
SELECT * FROM IRIS_STRV.SA_VAT_TRANSACTION_TYPE_CODE;
SELECT * FROM IRIS_STRV.SA_VAT_RATE_CODE;
SELECT * FROM IRIS_STRV.SA_VAT_TRANS_RATES;
SELECT * FROM IRIS_STRV.SA_VAT_UOM;
SELECT * FROM IRIS_STRV.SA_VAT_SRO_CODE;
SELECT * FROM IRIS_STRV.SA_VAT_SRO_ITEM_CODE;
SELECT * FROM IRIS_STRV.DOCUMENT_STATUS;
SELECT * FROM IRIS_STRV.DOCUMENT_STAGES;
SELECT * FROM IRIS_STRV.SA_DOC_TYPES;
SELECT * FROM IRIS_STRV.SA_STATES_PROVINCES;
SELECT * FROM IRIS_STRV.SA_VAT_ANNEXURE_CODE;
SELECT * FROM IRIS_STRV.SA_VAT_8B_EXCLUSION_REASONS;
SELECT * FROM IRIS_STRV.SA_VAT_REASONS;
SELECT * FROM IRIS_STRV.COMMERCIAL_VAT_DSI_DETAILS;
SELECT * FROM IRIS_STRV.SA_VAT_ANNEXK_DESCRIPTION;
SELECT * FROM IRIS_STRV.FORM_ANNEXK_DETAILS ;           
SELECT * FROM IRIS_STRV.FORM_ANNEXK_DTLS_SHIP_BREAKING ;       
SELECT * FROM IRIS_STRV.FORM_FED_DETAILS ;                    
SELECT * FROM IRIS_STRV.FORM_PRM_DETAILS ;            
SELECT * FROM IRIS_STRV.FORM_RTN_STATUS;                  
SELECT * FROM IRIS_STRV.FORM_SERVICES_DETAILS;      
SELECT * FROM IRIS_STRV.FORM_SRPS_DETAILS ;         
SELECT * FROM IRIS_STRV.FORM_STWITHHOLDING_INVOICES;
SELECT * FROM IRIS_STRV.SA_INVOICE_SOURCES;
SELECT * FROM IRIS_STRV.FORM_CF_DETAILS;
SELECT * FROM IRIS_STRV.Form_7ABC;
SELECT * FROM IRIS_NEW.Registration;
SELECT * FROM IRIS_NEW.Workflow;
SELECT * FROM IRIS_NEW.wf_data;
SELECT * FROM iris_Strv.SA_VAT_ITEM_DESC_CODE;
SELECT * FROM IRIS_STRV.DDOC_LOG;
SELECT * FROM IRIS_STRV.CUSTOMS_EXPORT_MAIN;
SELECT * FROM IRIS_STRV.CUSTOMS_IMPORT_MAIN;
SELECT * FROM IRIS_STRV.DATA_FORM_LEDGER;
SELECT * FROM IRIS_STRV.DDOC_STAGES;
SELECT * FROM IRIS_STRV.ACCOUNT_CLASSIFICATION;
SELECT * FROM IRIS_STRV.FORM_DCN_MASTER;
SELECT * FROM IRIS_STRV.SA_HS_CODES;
SELECT * FROM IRIS_STRV.SEC_8B;
SELECT * FROM IRIS_STRV.WORKFLOW_X;
 select * from iris_strv.data_forms ; 
 select * from iris_strv.data_form_ledger;
 select * from iris_strv.customs_import_main_tst;
 select * from iris_strv.credit_not_allowed_hscode;
 select * from iris_strv.ddoc_log;
 select * from iris_strv.ddoc_reference;
 select * from iris_strv.account_classification;
 select * from iris_strv.domestic_documents_old;
 select * from iris_strv.form_annexk_details_for_strv;
 select * from iris_strv.form_annexk_details;
 select * from iris_strv.form_cf_details;
 select * from iris_strv.form_cf_details_for_strv;
 select * from iris_strv.sa_account_heads;
 select * from iris_strv.sa_account_sub_heads ;
 select * from iris_strv.sa_accounts;
 select * from iris_strv.sa_hs_codes;
 select * from iris_strv.sa_status_codes;
 select * from iris_strv.sa_vat_hscodes; 
 select * from iris_strv.sa_vat_steel_melters;
 select * from iris_strv.sa_vat_trans_rates;
 select * from iris_strv.st_types;
 select * from iris_strv.temp_zahid;
 select * from iris_strv.temp1;
 select * from iris_strv.vat_dsi_details;
 select * from iris_strv.workflow_x ;
 select * from iris_strv.sa_vat_annexk_description;
 select * from iris_strv.sa_vat_doc_type_code;

SELECT * FROM IRIS_STRV.SA_INVOICE_SOURCES;

SELECT * FROM IRIS_STRV.DOCUMENT_STAGES WHERE DOC_STAGE_CODE ='3' ;

SELECT * FROM IRIS_STRV.SA_DOC_TYPES; 

select * from iris_new.workflow where REGISTRATION_NO='4210123112440';
 
select * from iris_new.payments WHERE REGISTRATION_NO='4210123112440' and tax_month='07'; 

select * from iris_strv.sa_vat_rules;

select * From iris_strv.domestic_documents
Where TRANSACTION_TYPE_ID not in ( Select TRANSACTION_TYPE_ID From iris_Strv.SA_VAT_TRANSACTION_TYPE_CODE);

select count(*) From iris_strv.domestic_documents
Where ITEM_DESC_ID not in (Select ITEM_DESC_ID From iris_Strv.SA_VAT_ITEM_DESC_CODE );

select Count(*) From iris_strv.domestic_documents
Where rate_id not in (Select rate_id From iris_Strv.SA_VAT_RATE_CODE );

select count(*) From iris_strv.domestic_documents
Where MEASUREMENT_CODE not in (Select UOM_ID From iris_Strv.SA_VAT_UOM );

select count(*) From iris_strv.domestic_documents
Where SRO_ID not in (Select SRO_ID From iris_Strv.SA_VAT_SRO_CODE );

select Count(*) From iris_strv.domestic_documents
Where SRO_ITEM_ID not in (Select SRO_ITEM_ID From iris_Strv.SA_VAT_SRO_ITEM_CODE);

select Count(*) From iris_strv.domestic_documents
Where DOC_STATUS not in (Select DOC_STATUS From iris_Strv.DOCUMENT_STATUS);

select * From iris_strv.domestic_documents
where doc_type_id not in (Select DOC_TYPE_ID From iris_strv.SA_DOC_TYPES);

select count(*) From iris_strv.domestic_documents
where SELLER_PROVINCE_ID not in (Select SELLER_PROVINCE_ID From iris_strv.SA_STATES_PROVINCES);

select Count(*) From iris_strv.domestic_documents
where BUYER_PROVINCE_ID not in (Select BUYER_PROVINCE_ID From iris_strv.SA_STATES_PROVINCES);

select Count(*) From iris_strv.domestic_documents
where TAX_TYPE_ID not in (Select TAX_TYPE_ID From iris_strv.SA_VAT_ANNEXURE_CODE);

select Count(*) From iris_strv.domestic_documents
where REASON_ID not in (Select REASON_ID From iris_strv.SA_VAT_REASONS);

SELECT * FROM IRIS_NEW.BUGS_LOG;
