Dear,
Please execute on Iris_strv (prod).

Update Iris_Strv.Domestic_documents
set sale_Value=119036,
    vat_amount=17855,
    last_updated=sysdate,
    doc_comments='CRM CASE # FBR-138621656'
where ddoc_id=2220589709;
---1 row updated

Issue : purchase invoices not showing in annexure-A 

merge into iris_strv.domestic_Documents A
Using
(
select f.form_id,f.ddoc_id,f.form_si_id
from iris_strv.form_sale_invoices f
where form_si_id in (322933706,322933707,322933708)
) b
on (A.ddoc_id=b.ddoc_id)
When matched then
Update 
set a.form_si_id=b.form_si_id,
    a.form_id_sale=b.form_id,
    A.Doc_Comments=A.Doc_Comments||'[ Sales Invoice Link To Original Return ]',
    a.doc_stage_code=3,
    a.case_Status_code=2,
    a.rec_Status=null,
    A.Last_Updated=Sysdate;
---3 rows merge

Dear,
Please execute on iris_Strv (prod).

merge into iris_strv.domestic_Documents A
Using
(
select f.form_id,f.ddoc_id,f.form_si_id
from iris_strv.form_sale_invoices f
where form_si_id=266241350
) b
on (A.ddoc_id=b.ddoc_id)
When matched then
Update 
set a.form_si_id=b.form_si_id,
    a.form_id_sale=b.form_id,
    A.Doc_Comments=A.Doc_Comments||'[ Sales Invoice Link To Original Return ]',
    a.doc_stage_code=3,
    a.case_Status_code=2,
    a.rec_Status=null,
    A.Last_Updated=Sysdate;
    ---1 rows merged
:requested to allow the respective input claims of the above customer:
Dear,
Please execute on Iris_Strv (prod).

Update Iris_Strv.Domestic_Documents
set doc_Stage_code=6,
    last_updated=sysdate,
    Doc_Comments='FBR-139049202'
    where ddoc_id=1921987234
    ---1 rows updated




