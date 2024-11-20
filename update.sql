select * from iris_new.registration;

select * from iris.st_workflow where case_stage_code <>9 and task_code like '217%';

select * from iris.st_workflow where transaction_id in (1000000985019660,1000000990100454,1000000990115563);

update IRIS_STRV.domestic_documents dd
set doc_Stage_Code=3
where doc_type_id=7
and tax_type_id=1
and doc_stage_Code=2
and form_id_Sale is null
and exists (select 1 from iris.workflow w where dd.form_id_purchase=w.transaction_id and case_stage_code=2 and task_code in (2171,2175,9177));
---388 Rows Can be changed

update iris_strv.domestic_documents 
set doc_status =2,
    remarks    =null,
    last_updated=sysdate,
    doc_comments=doc_comments||'FBR-197362087,SALES TAX RETURN DEBIT NOTE ISSUE'
where ddoc_id in (2765685517,2765700277,2765776121);
---3 rows updated

--------------------IRIS
update iris.registration
set org_id_csv=1
where org_id_csv is null and strn is not null;
---263 rows can be changed
