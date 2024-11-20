update iris.payments  
set CLAIMED =1
where CPR_NO ='ST2024041501011261175'; 
--1 row updated

update iris.wf_payments 
set REC_STATUS =1
where PAYMENT_SR_NO ='1000000905142193';
--1 row updated

update iris_strv.domestic_documents
set doc_stage_code =7,
    last_updated   =sysdate,
    doc_comments   =doc_comments||'Taxpayer paid and 7a removed as per fto letter against crm FBR-184070609,FT0-4329/KHI/ST/2024Complaint filed by Mr. Mohammad Mohsin (Prop.) of MIs. MIs. Right Solar Alternative Energy holding NTN 5377132-1 - Regarding Error in Sales Tax return column No.7 (a) for the tax period July-2023'
where DDOC_ID IN (2107925439,2107925440,2107925441,2107925442,2107925443,2107925444,2107925445);
--7 rows updated

UPDATE IRIS_STRV.domestic_documents dd
set doc_Stage_Code=3
where doc_type_id=7
and tax_type_id=1
and doc_stage_Code=2
and form_id_Sale is null
and exists (select 1 from iris.workflow w where dd.form_id_purchase=w.transaction_id and case_stage_code=2 and task_code in (2171,2175,9177));
---2168 Rows Can be changed
