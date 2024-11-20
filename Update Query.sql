------------VAT DB
SELECT * FROM Revision_Request AS rr WHERE rr.Document_Id IN (
SELECT vrm.Return_ID
FROM   vat.dbo.VAT_Rtn_Main AS vrm
WHERE  vrm.Computer_No IN (SELECT rm.Computer_No
                           FROM   Reg_Main AS rm
                           WHERE  rm.NTN = '4226766'
                           AND rm.isActive = 1)
       AND vrm.isActive = 1
       AND vrm.Return_Status = 3
       AND vrm.Tax_Period >= 201911) 
	   AND rr.IsActive = 1 
       AND rr.Document_Type = 'VT';

	   -----Update CREST non active 
UPDATE crest_blocked_units
SET isActive = 0, Update_date =GETDATE(),
     Remarks = 'Income Tax Non Filer 2014 FBR-197268484 '
     WHERE ntn = '2287011'
--1 row affected
---update custom export main
update Customs_Export_Main 
set ntn =null
where NTN = '1140624' 
and SB_Type ='EC'     
AND CONVERT(DATE, SB_Date, 112)  >= '2023-09-01' AND CONVERT(DATE, SB_Date, 112) <= '2023-09-30'
---1601 rows deleted

---Biometric issue Registration No is null
Update IRIS.identity_verification
set REGISTRATION_NO='3840105056257'
where IDENTIFICATION_NO='3840105056257';
---1 row updated

-----collect code
Update IRIS_STRV.sa_custom_collectorates
set code='GBSE',
    DESCRIPTION='GBSE'
where collect_id=403;
---1 row updated

--7a Remove Script
update iris_strv.domestic_documents
set doc_stage_code   =7,
   form_pi_id        ='11111111111111',
   form_id_purchase  ='11111111111111',
   last_updated      =sysdate,
   doc_comments      =doc_comments||'FBR-184396617,ISSUE IN FILING SALES TAX RETURN - MIS ADEEL TRADERS '
where DDOC_ID IN (2350813379);
--1 row update

--WF_Payments/CPR Script
update iris.wf_payments 
set rec_status =1
where PAYMENT_SR_NO ='1000000905593785' 
and transaction_id =1000000968974421;
--1 row updated

--Payments/CPR Script
update iris.payments
set claimed =1
where CPR_NO ='ST2023092801012301015'; 
--1 row update

Update iris.wf_Data
set Col_c=402361
where transaction_id=1000000970863628 and amount_code='100107';
---1 row updated

Update IRIS_STRV.form_rtn_status
set REMARKS='As FBR letter Remove Provisonal',
    PROVISIONAL_RETURN_STATUS=0,
    PROVISIONAL_RETURN_DATE=null
WHERE TRANSACTION_ID in (1000000970279070,1000000970283486)
---2 row updated

--debit note enable in revise return
update iris_strv.domestic_documents
set INVOICE_SOURCE =9,
    SOURCE_REF_ID =111111,
	doc_status    =2,
	last_updated  =sysdate,
    doc_comments =doc_comments||'FBR-184140754,Re:Problem in Uploading Credit Notes in Annexure-I of Sales Tax Return for Tax Period February 2024 '
where ddoc_id in (2569569271,2569569255,2569571626,2569571629,2569571632,2569571633,2569569217,2569569220,2569569222,2569569267,
2569569278,2569569247,2569569249,2569569265,2569569274,2569569275,2569571637,2569569269,2569569257,2569569259,2569569261,2569571634,
2569571635);
--23 rows updated

--update rule
update iris_strv.vat_rule_grntorrevaccesstontn
set ISACTIVE =0,
   ENDDATE ='03-JUN-24',
   ENTRYDATE =SYSDATE,
   REMARKS ='FBR-184392645 ,DE-BLOCKING OF INPUT TAX CREDIT/ADJUSTMENT  YAZMAN TRADERS NTN C474554-2 IN COMPLIANCE OF LAHORE HIGH COURT ORDER Dated:03-jun-2024'
where ntn='C474554' and RULEID =44;
--1 ROW updated

--delete vat_rule_grntorrevaccesstontn
DELETE from iris_strv.vat_rule_grntorrevaccesstontn where ntn='C474554' and RULEID =44;
--1 ROW DELETED

--rule
select iris.tools.testrule(1000000900868602,2001) from dual;

---STWH INVOICES UPDATED QUERY
update IRIS_STRV.domestic_documents dd
set doc_Stage_Code=3
where doc_type_id=7
and tax_type_id=1
and doc_stage_Code=2
and form_id_Sale is null
and exists (select 1 from iris.workflow w where dd.form_id_purchase=w.transaction_id and case_stage_code=2 and task_code in (2171,2175,9177));
---1814 Rows Can be changed

--UPDATE org_id_csv FROM REGISRTATION TABLE
UPDATE iris.registration
set org_id_csv=1
where org_id_csv is null and strn is not null;
---45 Rows Can be changed

--UPDATE SALE LEDGER
update iris_strv.domestic_documents dd
set doc_Stage_Code=7,
    SPLR_RTN_STATUS=1
    where buyer_reg_no ='4230137657883'
and doc_stage_code =4
and exists (select 1 from iris_strv.form_7abc f where dd.ddoc_id=f.ddoc_id and form_id in (1000000955275277) and amount_code = '100111')
and FORM_ID_SALE in (select transaction_id from iris.workflow where case_stage_code=2 and task_code in (2171));
---722 rows updated

---Export Gd insert query
insert into FORM_EXPORT_DETAILS
      (form_id,collectorate_crn,gd_type,gd_no,gd_date,hs_code,ss_value,mr_no,mr_date,mr_value,var_value,rec_source,
       collectorate_id,gd_value,inserted_by,inserted_date,gd_id)
      select 1000000965409268,
             collectorate_code,
             (SELECT cdt.GD_TYPE_ID
                FROM IRIS_STRV.SA_CUSTOM_GD_TYPES cdt
               where lower(cdt.CODE) = lower(exp.sb_type)) gdtype,sb_no,sb_date,hscode,short_shipment_value,mr_no,
             mr_date,(export_value - short_shipment_value) mrValue,(insval - short_shipment_value) varvalue,
             source_id,(select c.COLLECT_ID
                from IRIS_STRV.SA_CUSTOM_COLLECTORATES c
               where c.type = 2
                 --and c.collectorate_type = 2
                 and lower(c.code) = lower(exp.collectorate_code)) collectorateId,
             export_value,
             '1439037',
             SYSDATE,
             SB_ID
             from CUSTOM.CUSTOMS_EXPORT_MAIN@ods_hafeez exp ---when forwarding for execution then used --ODS.FBRDC.NET
where exp.ntn = '1439037'
and ((TRUNC(exp.sb_date) between '01-MAR-24' and '31-MAR-24')
Or (TRUNC(exp.UPDDAT) BETWEEN '01-MAR-24' and '31-MAR-24')
OR (TRUNC(exp.mr_Date) BETWEEN '01-MAR-24' and '31-MAR-24')

)
and not exists
(select 1
from iris_strv.FORM_EXPORT_DETAILS fed
Join iris_strv.SA_CUSTOM_COLLECTORATES c
On fed.collectorate_id=c.COLLECT_ID
Join iris_strv.SA_CUSTOM_GD_TYPES CGT on Fed.gd_type=cgt.gd_type_id
where
lower(c.code) = lower(exp.collectorate_code)
and cgT.code=exp.sb_Type
and fed.gd_no = exp.sb_no
and fed.gd_date=exp.sb_date
and nvl(fed.hs_code,'N/A')=nvl(exp.HSCODE,'N/A')
Union all
select 1
from vat.vat_rtn_main@ods rtn join vat.vat_gde_details@ods gd on rtn.return_id=gd.return_id
join regsys.vu_profile@ods vp on rtn.computer_no=vp.computer_no and vp.ntn='1439037'
Join vat.ref_CUSTOM_COLLECTORATES@ods c
On gd.collectorate_id=c.COLLECT_ID
Join vat.ref_CUSTOM_GD_TYPES@ods CGT on gd.gd_type=cgt.gd_type_id
where
lower(c.code) = lower(exp.collectorate_code)
and cgt.code=exp.sb_Type
and gd.gd_no = exp.sb_no
and gd.gd_date=exp.sb_date
and nvl(gd.hs_code,'N/A')=nvl(exp.HSCODE,'N/A')
);
---1 ROW CREATED

--Annex-H Submission Query
UPDATE IRIS_STRV.form_rtn_status
SET ANNEXH_CASE_STAGE_CODE=2,
    ANNEXH_STATUS_DATE=sysdate,
    REMARKS=REMARKS||',As Per Email '
WHERE TRANSACTION_ID=224794445;
---1 ROW UPDATED

--Import Gd insert query
insert into IRIS_STRV.FORM_GDI_DETAILS
      (form_id,
       COLLECTORATE_CRN,
       collectorate_id,
       gd_type,
       gd_no,
       gd_date,
       hs_code,
       imp_quantity,
       imp_value,
       imp_tax,
       vat_commercial_imp,
       Spec_Tax,
       imp_fed,
       imp_fed_re,
       cash_no,
       cash_date,
       inserted_by,
       inserted_date,
       ADDITIONAL_DUTY,
       gd_id,
       IS_INADMISSIBLE,
       is_disable,
       REMARKS,
       ORG_ID,
       CLAIM_ORG_ID,
       IMP_TAX_PRA,
       TOTAL_IMP_TAX)
      SELECT  1000000985474105,
             crn,
             (select c.COLLECT_ID
                from Iris_Strv.SA_CUSTOM_COLLECTORATES c
               where c.type = 1
                 and lower(c.code) = lower(imp.collectorate_code)) collectorateId,
                cdt.GD_TYPE_ID,
             gd_no,
             gd_date,
             hscode,
             quantity,
            staxable_import_value ,
            st_paid ,
            vat_com_import ,
            vat_com_import ,
            fed_paid ,
             fed_re1,
             cdfno,
             cdfdate,
             '4004433',
             SYSDATE,
             case when ADDITIONAL_DUTY='true' then 1 else 0 end,
             gd_id,
             Decode (cdt.import_credit,1,0,1),
             Decode (cdt.import_credit,1,0,1),
             Decode (cdt.import_credit,1,null,'This GD Type is Not allowed for Credit'),
             1 ORG_ID,
             1 CLAIM_ORG_ID,
             0 IMP_TAX_PRA,
             st_paid
           from  CUSTOM.CUSTOMS_IMPORT_MAIN@ODS_HAFEEZ imp ---when forwarding for execution then used --ODS.FBRDC.NET
		   join iRIS_sTRV.SA_CUSTOM_GD_TYPES cdt on lower(cdt.CODE) = lower(imp.gd_type) 
                                                                and
nvl(imp.DECLARATION_TYPE_ID,0)=nvl(cdt.DECLARATION_TYPE_ID,0)
       where imp.gd_id=269690754;
        ---1 row created



	
--delete sale invoices from annex-c which are not exist in dd(sale ledger)	
		DELETE from iris_strv.form_sale_invoices si where form_id ='1000000937085343'
and NOT exists (select 1 from iris_strv.domestic_documents dd
where form_id_sale ='1000000937085343' 
AND si.ddoc_id  =dd.ddoc_id AND SI.FORM_SI_ID=DD.FORM_sI_ID
--and dd.ddoc_id=2446724614
and dd.form_id_sale = si.form_id);
---1000 ROWS DELETED

--invoices insert DD from annex-c
Insert into iris_Strv.domestic_documents
(  ddoc_id,    doc_type_id,    rate_id,    item_desc_id,    hs_code,    medium_code,    measurement_code,    transaction_type_id,    case_status_code,
    buyer_province_id,    seller_province_id,    sro_item_id,    sro_id,    buyer_type_id,    form_si_id,    form_pi_id,    form_id_sale,    form_id_purchase,
    ref_doc_id,    buyer_cnic,    seller_reg_no,    buyer_reg_no,    buyer_name,    seller_name,    buyer_trust_status,    doc_no,    doc_date,
    doc_tax_period,    rate_value,    qty,    sale_value,    vat_amount,    extra_tax,    vat_withheld,    further_tax,    tax_type_id,    source_regno,
    doc_stage_code,    inserted_by,    inserted_date,    updated_date,    updated_by,    reason_id,    other_reason,    seller_cnic,
    dc_date,    diff_stwh,    diff_staxfed_st,    diff_further_tax,    diff_qty,    diff_extra_tax,    diff_valueexstax,    doc_status,    remarks,
    retail_price,    pfad_sale,    input_credit_notallow,    fed_charge,    invoice_source,    last_updated,    pos_fee,    source_ref_id,    file_id,
    rec_status)
select 
    ddoc_id,doc_type_id,  rate_id,TYPE_DESC_ID    item_desc_id,HS_CODE    hs_code, 2   medium_code, measurement_code,SALE_TYPE    transaction_type_id,2    case_status_code,
     buyer_province_id,    seller_province_id, sro_item_id,  sro_id,    BUYER_TYPE,form_si_id,null    form_pi_id,form_id form_id_sale,null    form_id_purchase,
    null ref_doc_id,null    buyer_cnic,SELLER_REG_NO   seller_reg_no,BUYER_REGNO    buyer_reg_no,buyer_name,seller_name,1    buyer_trust_status,doc_no,doc_date,
    to_char(doc_date,'YYYYMM') doc_tax_period,18    rate_value,   qty,   sale_value,vat_amount,   extra_tax,vat_withheld,    further_tax,3    tax_type_id,INSERTED_BY    source_regno,
    2 doc_stage_code,   inserted_by,    inserted_date,inserted_date    updated_date,inserted_by    updated_by,null    reason_id,null    other_reason,null    seller_cnic,
    doc_date dc_date,0    diff_stwh,0    diff_staxfed_st,0    diff_further_tax,0    diff_qty,0    diff_extra_tax,0    diff_valueexstax, 2   doc_status,null    remarks,
    0 retail_price,0    pfad_sale,0    input_credit_notallow,0    fed_charge, 10   invoice_source,sysdate    last_updated,null    pos_fee, null   source_ref_id, null   file_id,
     rec_status
from IRIS_STRV.form_sale_invoices si where form_id=1000000937085343
and not exists (select 1 from IRIS_STRV.domestic_documents dd where si.ddoc_id=dd.ddoc_id and si.form_si_id=dd.form_si_id and SELLER_REG_NO='5562346' and doc_tax_period='202309');
---1000 rows created

--delete from annex-I
delete from iris_Strv.form_dcn_Details where dcn_dtl_id in (87092,87093,169474,289809);
--3 rows deleted

--Purchase invoices insert in revise return.
INSERT INTO IRIS_STRV.FORM_PURCHASE_INVOICES
(
   FORM_ID, FORM_SI_ID, 
   DDOC_ID, CASE_STATUS_CODE, IS_INADMIS, 
   INADMIS_TAX, SELLER_REGNO, INSERTED_BY, 
   INSERTED_DATE, UPDATED_BY, UPDATED_DATE, 
   SELLER_NAME, BUYER_PROVINCE_ID, SELLER_PROVINCE_ID, 
   DOC_TYPE_ID, DOC_NO, DOC_DATE, 
   HS_CODE, EXTRA_TAX, PURCHASED_TYPE, 
   CR_DISALLOWED, SPLR_TYPE, SPLR_TRUST_STATUS, 
   PURCHASE_VALUE, RATE_ID, VAT_AMOUNT, 
   FED_CHARGED, VAT_WITHHELD, FIXED_ASSET, 
   REC_STATUS, PREV_PI_ID, PREV_SI_ID,
   PFAD_SALE,MEASUREMENT_CODE,QTY,
   BUYER_REG_NO,BUYER_NAME,FURTHER_TAX,RETAIL_PRICE
,IS_DISABLE,REMARKS,ITEM_DESC_ID
--03082022  
)
SELECT 
   1000000953600067 FORM_ID, FORM_SI_ID, 
   DDOC_ID, P.CASE_STATUS_CODE, IS_INADMIS, 
   INADMIS_TAX, SELLER_REGNO, INSERTED_BY, 
   INSERTED_DATE, UPDATED_BY, UPDATED_DATE, 
   SELLER_NAME, BUYER_PROVINCE_ID, SELLER_PROVINCE_ID, 
   DOC_TYPE_ID, DOC_NO, DOC_DATE, 
   HS_CODE, EXTRA_TAX, PURCHASED_TYPE, 
   CR_DISALLOWED, SPLR_TYPE, Case when nvl(SPLR_TRUST_STATUS,0) =0 Then nvl(get_reg_trust_level(SELLER_REGNO),9) Else SPLR_TRUST_STATUS End, 
   PURCHASE_VALUE, RATE_ID, VAT_AMOUNT, 
   FED_CHARGED, VAT_WITHHELD, FIXED_ASSET, 
   1 REC_STATUS,FORM_PI_ID PREV_PI_ID,null PREV_SI_ID,
   PFAD_SALE,MEASUREMENT_CODE,QTY,
   BUYER_REG_NO,BUYER_NAME,FURTHER_TAX,RETAIL_PRICE
---03082022
  ,IS_DISABLE,REMARKS,ITEM_DESC_ID
FROM IRIS_STRV.FORM_PURCHASE_INVOICES P 
where form_id = 1000000952479321;
--19 rows created

---merge dd from annex-c more then 1000 rows
MERGE INTO iris_strv.domestic_documents a
USING (
    SELECT DDOC_ID, FORM_SI_ID, FORM_ID, UPDATED_BY
    FROM abdul_hafeez.FORM_SI b 
    WHERE b.form_id = 1000000967706362 
    AND b.form_si_id IN (SELECT form_si_id FROM iris_strv.form_sale_invoices)
) b
ON (b.DDOC_ID = a.DDOC_ID)
WHEN MATCHED THEN
    UPDATE
    SET a.form_si_id     = b.form_si_id,
        a.form_id_sale   = 1000000967706362,
        a.doc_stage_code = 3,
        a.doc_status     = 2,
        a.updated_by     = b.updated_by,
        a.updated_date   = SYSDATE,
        a.rec_status     = 0,
        a.last_updated   =sysdate,
        a.SPLR_RTN_STATUS =1,
        a.doc_comments   =doc_comments||'FBR-185796862,RE: INVOICES NOT APPEAR IN ANNEX-A'
    WHERE a.ddoc_id IN (SELECT ddoc_id FROM iris_strv.domestic_documents);
    --1553 rows merged.


--provincial invoices update
update iris_strv.COMMERCIAL_VAT_DSI_DETAILS DS
set   DS.FBR_VAT_AMOUNT=null,
      DS.MODIFY_DATE=sysdate
where ISACTIVE=1
and nvl(DS.FBR_VAT_AMOUNT,0)>0
and substr(DS.BUYER_NTN,1,7)='2128133'
and DS.DOC_PERIOD in ('202311') 
and not exists (select 1 from iris_Strv.domestic_documents dd
                              where dd.source_Ref_id=DS.commercial_id 
                              and   dd.doc_tax_period=DS.DOC_PERIOD
                              and   dd.doc_no=DS.doc_no_num
                              and   dd.DOC_DATE=DS.DOC_DATE
                              and   dd.invoice_Source not in (1,10)
                              and   dd.seller_Reg_no in(5150349839487)
                              and   dd.doc_tax_period in (202309));
							  
----insert into vat_rule_grntorrevaccesstontn
Insert into iris_strv.vat_rule_grntorrevaccesstontn
(computer_no,    cnic,    ntn,    ntn_chk,    strn,    name,    registration_no,    id,    ruleid,    refrence_id,    rangespecific,
    startdate,    enddate,    entrydate,    isactive,    remarks,    is_excluded,    is_granted)
SELECT
    computer_no,null   cnic,substr(ntn,1,7)    ntn,substr(ntn,7,1)    ntn_chk,    strn,    name,    registration_no,
   (select max(id) from Iris_Strv.vat_rule_grntorrevaccesstontn)+rownum    id,46    ruleid,1    refrence_id,1    rangespecific,
   '23-Jul-24' startdate,null    enddate,sysdate    entrydate,1    isactive,'FBR-188891743,Case No W.P.No.45014 of 2024 As Per Lahore High Court order Exempt SRO-350'
   remarks,0    is_excluded,0    is_granted
    FROM Iris.registration
where substr(ntn,1,7)='6607194';
---1 row created

--insert into annex-c
insert into iris_strv.form_Sale_invoices
      (Type_Desc_ID,DDOC_ID,
       form_id,
       CASE_STATUS_CODE,
       BUYER_REGNO,
       inserted_by,
       inserted_date,
       BUYER_NAME,
       BUYER_PROVINCE_ID,
       SELLER_PROVINCE_ID,
       DOC_TYPE_ID,
       DOC_NO,
       DOC_DATE,
       HS_CODE,
       EXTRA_TAX,
       vat_withheld,
       sale_type,
       sale_value,
       rate_id,
       buyer_type,
       vat_amount,
       quantity,
       further_tax,
       total_valueofsales,
       rec_status
       ,BUYER_VERIFICATION_STATUS,
       PFAD_SALE,
       QTY,
       MEASUREMENT_CODE,
       SELLER_REG_NO,
       SELLER_NAME,
       RETAIL_PRICE,
       SRO_ITEM_ID,
       SRO_ID,
       ORG_ID)
SELECT 
    NVL(dd.ITEM_DESC_ID, 0),
    dd.ddoc_id,
    1000000970151646,
    2,
    dd.buyer_reg_no,
    8950907,
    SYSDATE,
    SUBSTR(dd.BUYER_NAME, 1, 200),
    dd.BUYER_PROVINCE_ID,
    dd.SELLER_PROVINCE_ID,
    CASE 
        WHEN dd.DOC_TYPE_ID = 9 AND dd.tax_type_id = 1 THEN 10 
        WHEN dd.DOC_TYPE_ID = 10 AND dd.tax_type_id = 1 THEN 9 
        ELSE dd.DOC_TYPE_ID 
    END,
    dd.DOC_NO,
    dd.DOC_DATE,
    dd.HS_CODE,
    dd.EXTRA_TAX,
    dd.vat_withheld,
    dd.transaction_type_id,
    dd.sale_value,
    dd.rate_id,
    dd.buyer_type_id,
    dd.vat_amount,
    dd.qty,
    dd.further_tax,
    0,
    0,
    BUYER_VERIFICATION_STATUS,
    dd.PFAD_SALE,
    dd.QTY,
    dd.MEASUREMENT_CODE,
    dd.SELLER_REG_NO,
    dd.SELLER_NAME,
    dd.RETAIL_PRICE,
    dd.SRO_ITEM_ID,
    dd.SRO_ID,
    dd.ORG_ID
FROM 
    Iris_Strv.domestic_documents dd
    JOIN Iris.workflow w ON (dd.seller_Reg_no = w.registration_no 
                                AND dd.doc_tax_period = TO_CHAR(w.period_start_Date, 'YYYYMM') 
                                AND case_Stage_code = 1)
where dd.DDOC_ID IN (SELECT DDOC_ID FROM ABDUL_HAFEEZ.SALE_INV);
     -----19 rows inserted
     
    MERGE INTO Iris_Strv.domestic_documents a
    USING (
    SELECT  DDOC_ID,form_si_id,FORM_ID,3 doc_stage_code,seller_Reg_no updated_by 
   from iris_Strv.form_Sale_invoices  b 
    where  b.form_id=1000000970151646 and b.ddoc_id in (SELECT DDOC_ID FROM ABDUL_HAFEEZ.SALE_INV)
    ) b
    ON (b.DDOC_ID = a.DDOC_ID)
    WHEN MATCHED THEN
      UPDATE
         SET a.form_si_id     = b.form_si_id,
             A.FORM_ID_SALE   = 1000000970151646,
             a.doc_stage_code = 3,                             
             a.doc_Status     = 2,
             a.updated_by     = b.updated_by,
             a.updated_date   = sysdate,
             a.rec_Status     =0,
             a.doc_comments   =doc_comments||'Issue in sale tax return reported by field office'
      where  a.ddoc_id in (SELECT DDOC_ID FROM ABDUL_HAFEEZ.SALE_INV);
      --------19 rows merged

	  ---FORM_PURCHASE_INVOICES

UPDATE IRIS_STRV.DOMESTIC_DOCUMENTS
SET SELLER_REG_NO='1158490',
   SELLER_NAME ='SECURITY GENERAL INS. CO LIMITED',
   LAST_UPDATED  =SYSDATE,
   FORM_ID_SALE=9999999999999,
   form_si_id=9999999999999,
   DOC_STAGE_CODE=3,
   DOC_STATUS=2,
   SOURCE_REGNO='1158490',
   INSERTED_BY='1158490',
   SRO_ITEM_ID=NULL,
   SRO_ID=NULL,
   SPLR_RTN_STATUS=1,
   DOC_DATE=CASE WHEN DOC_NO='1967' THEN '09-DEC-14'
                 WHEN DOC_NO='3325' THEN '17-APR-15'
                 WHEN DOC_NO='2142' THEN '31-JUL-15'
                 WHEN DOC_NO='2142' THEN '31-DEC-15'
                 WHEN DOC_NO='2233' THEN '23-SEP-16'
                 WHEN DOC_NO='2233' THEN '15-DEC-16'
                 WHEN DOC_NO='2233' THEN '17-MAR-17'
                 WHEN DOC_NO='2233' THEN '14-JUN-17'
                 WHEN DOC_NO='2407' THEN '18-SEP-17' END,
  DOC_TAX_PERIOD=CASE WHEN DOC_NO='1967' THEN '201214'
                 WHEN DOC_NO='3325' THEN '201504'
                 WHEN DOC_NO='2142' THEN '201507'
                 WHEN DOC_NO='2142' THEN '201512'
                 WHEN DOC_NO='2233' THEN '201609'
                 WHEN DOC_NO='2233' THEN '201612'
                 WHEN DOC_NO='2233' THEN '201703'
                 WHEN DOC_NO='2233' THEN '201706'
                 WHEN DOC_NO='2407' THEN '201709' END,
        DOC_COMMENTS='FBR-188908014'
      WHERE DDOC_ID IN (2717847559,2717849053,2717847621,2717849076,2717849157,2717850289,2717849126,2717850391,2717847701);
      ---9 ROWS UPDATED
      
 UPDATE IRIS_STRV.DOMESTIC_DOCUMENTS
SET SELLER_REG_NO='0712140',
   SELLER_NAME ='SIEMENS PAKISTAN ENGINEERING COMPANY LIMITED',
   LAST_UPDATED  =SYSDATE,
   FORM_ID_SALE=9999999999999,
   form_si_id=9999999999999,
   DOC_STAGE_CODE=3,
   DOC_STATUS=2,
   SOURCE_REGNO='0712140',
   INSERTED_BY='0712140',
   SRO_ITEM_ID=NULL,
   SRO_ID=NULL,
   SPLR_RTN_STATUS=1,
   DOC_DATE=CASE WHEN DOC_NO='111198' THEN '28-SEP-13'
                 WHEN DOC_NO='400450' THEN '03-JUN-15'
                 WHEN DOC_NO='10435' THEN '03-SEP-15'
                 WHEN DOC_NO='400597' THEN '21-DEC-15' END,
  DOC_TAX_PERIOD=CASE WHEN DOC_NO='111198' THEN '202109'
                 WHEN DOC_NO='400450' THEN '201506'
                 WHEN DOC_NO='10435' THEN '201509'
                 WHEN DOC_NO='400597' THEN '201512' END,
        DOC_COMMENTS='FBR-188908014'
WHERE DDOC_ID IN(2717851096,2717853256,2717852662,2717850445);
        --4 ROWS UPDATED


insert into form_Purchase_invoices
      (DDOC_ID,
       FORM_ID,
       form_si_id,
       CASE_STATUS_CODE,
       Seller_REGNO,
       inserted_by,
       inserted_date,
       SELLER_NAME,
       BUYER_PROVINCE_ID,
       SELLER_PROVINCE_ID,
       DOC_TYPE_ID,
       DOC_NO,
       DOC_DATE,
       HS_CODE,
       EXTRA_TAX,
       purchased_type,
       purchase_value,
       rate_id,
       vat_amount,
       vat_withheld,
       cr_disallowed,
       splr_type,
       splr_trust_status,
       fed_charged,
       REC_STATUS,
       PFAD_SALE,
       MEASUREMENT_CODE,
       QTY,
       BUYER_REG_NO,
       BUYER_NAME,FURTHER_TAX,
       RETAIL_PRICE,
       ITEM_DESC_ID,
       ORG_ID,
       CLAIM_ORG_ID,
       FBR_VAT_AMOUNT,
       PRA_VAT_AMOUNT,
       KPRA_VAT_AMOUNT,
       BRA_VAT_AMOUNT,
       SRB_VAT_AMOUNT,
       TOTAL_VAT_AMOUNT)
      select ddoc_id,
             1000000975003088,
             form_si_id,
             2,
             seller_reg_no,
             '0786171',
             sysdate,
             substr(SELLER_NAME,1,200),
             BUYER_PROVINCE_ID,
             SELLER_PROVINCE_ID,
             case
               when DOC_TYPE_ID = 4 then
               1
               when (DOC_TYPE_ID = 9 and TAX_TYPE_ID = 3) then
               10
               when (DOC_TYPE_ID =10 and TAX_TYPE_ID = 3) then
               9 else
                DOC_TYPE_ID
             end DOC_TYPE_ID,
             DOC_NO,
             DOC_DATE,
             HS_CODE,
             EXTRA_TAX,
             transaction_type_id,
            -- sale_value,
             sale_value ,
             rate_id,
             --vat_amount,
             vat_amount ,
             vat_withheld,
                 case when nvl(iris_strv.get_reg_trust_level(seller_reg_no),9) = 9 and invoice_Source<>11 then case when tax_type_id=3 then vat_amount else vat_withheld end  else 0  end,
                 case when invoice_Source=11 then 1 else NVL(Iris_strv.GET_ST_REG_TYPE(DD.SELLER_REG_NO),2) end splr_type,
                 case when invoice_Source=11 then 1 else nvl(Iris_Strv.get_reg_trust_level(seller_reg_no),9) end,
             
             --vat_amount
             DD.FED_CHARGE,
             0 REC_STATUS
                         ,DD.PFAD_SALE,
             DD.MEASUREMENT_CODE,
             DD.QTY,
             DD.BUYER_REG_NO,
             DD.BUYER_NAME             ,DD.FURTHER_TAX,
             DD.RETAIL_PRICE,
             DD.ITEM_DESC_ID,
             DD.ORG_ID,
             1 CLAIM_ORG_ID,
             DD.VAT_AMOUNT FBR_VAT_AMOUNT,
             0,
             0,
             0,
             0,
             DD.vat_amount TOTAL_VAT_AMOUNT
        FROM IRIS_STRV.domestic_documents dd 
       where FORM_ID_PURCHASE IS NULL 
        AND DD.DDOC_ID IN (2717847559,2717849053,2717847621,2717849076,2717849157,2717850289,2717849126,2717850391,2717847701,2717851096,2717853256,
2717852662,2717850445);
         ---13 rows created

    MERGE INTO Iris_Strv.domestic_documents a
    USING (Select ddoc_id, FORM_ID, form_pi_id,claim_org_id ,buyer_reg_no
            From Iris_strv.form_Purchase_invoices 
    Where DDOC_ID IN (2717847559,2717849053,2717847621,2717849076,2717849157,2717850289,2717849126,2717850391,2717847701,2717851096,2717853256,
2717852662,2717850445)
    ) b
    ON (a.DDOC_ID = b.DDOC_ID)
    WHEN MATCHED THEN
      UPDATE
        SET   a.form_pi_id =  b.form_pi_id,
              A.FORM_ID_PURCHASE =B.FORM_ID,
              a.DOC_STATUS     =  5,
              a.DOC_STAGE_CODE = 3,
              a.updated_by     = b.buyer_reg_no,
              a.updated_date   = sysdate,
              a.claim_org_id = 1
              where a.DDOC_ID IN (2717847559,2717849053,2717847621,2717849076,2717849157,2717850289,2717849126,2717850391,2717847701,2717851096,2717853256,
2717852662,2717850445);
                    ---13 rows merged
	
update iris_strv.FORM_RTN_STATUS
set PROVISIONAL_RETURN_STATUS =0,
     remarks= 'FBR-189843978,Case No W.P.No.45472 of 2024 As Per Lahore High Court order Exempt SRO-350'
where transaction_id = '1000000970378387';
--1 row update	

-----insert into wf_data
INSERT INTO iris.wf_data (
    TRANSACTION_ID,SOURCE_REGISTRATION_NO_A, AMOUNT_CODE,SORT_ORDER,COL_A,COL_B,COL_C,COL_D, SOURCE_REGISTRATION_NO_B,
    COL_E,COL_F,COL_G, COL_H, COL_I,COL_J, DATE_COL_A, SRC_REG_NO_B_DESC, ADD_ALLOWED, EDIT_ALLOWED, DELETE_ALLOWED, CLNT_SOURCE_REGISTRATION_NO_B,
    STATUS_CODE, IDENTIFIERVALUE,CONTENTVALUE, CURRENCY_CODE )
SELECT 
    1000000980361524, 0, AMOUNT_CODE,SORT_ORDER, COL_A,COL_B, COL_C, COL_D, 1, COL_E, COL_F, COL_G, COL_H, COL_I, COL_J,
    NULL, '- YES- DISTRIBUTOR',  ADD_ALLOWED, EDIT_ALLOWED, DELETE_ALLOWED, CLNT_SOURCE_REGISTRATION_NO_B, STATUS_CODE,
    'Yes', 13, CURRENCY_CODE
FROM IRIS.WF_DATA
WHERE TRANSACTION_ID = 1000000976887639
and amount_code =100301
and SOURCE_REGISTRATION_NO_B =1;


---------------24-10/24 :::9-45
select * from iris_strv.domestic_documents dd
where doc_stage_code =2
 and exists (select 1 from iris_strv.form_sale_invoices si
 where dd.ddoc_id = si.ddoc_id and dd.form_id_sale=si.form_id
 and exists (select 1 from iris.st_workflow w1 where si.form_id =w1.transaction_id
 and si.seller_reg_no =w1.registration_no and  case_stage_code =2));

 
--------------------------------update rtn status
update iris_strv.FORM_RTN_STATUS
set PROVISIONAL_RETURN_STATUS =0,
    PROVISIONAL_RETURN_DATE  =null,
     remarks= 'FBR-194335406,Case No W.P.No.11402 of 2024 As Per Lahore High Court order Exempt SRO-350'
where transaction_id in (1000000973194926);
---1 row updated

--------------------------vat rules

Insert into iris_strv.vat_rule_grntorrevaccesstontn
(computer_no,    cnic,    ntn,    ntn_chk,    strn,    name,    registration_no,    id,    ruleid,    refrence_id,    rangespecific,
    startdate,    enddate,    entrydate,    isactive,    remarks,    is_excluded,    is_granted)
SELECT
    computer_no,null   cnic,substr(ntn,1,7)    ntn,substr(ntn,7,1)    ntn_chk,    strn,    name,    registration_no,
   (select max(id) from Iris_Strv.vat_rule_grntorrevaccesstontn)+rownum    id,46    ruleid,1    refrence_id,1    rangespecific,
   '08-AUG-24' startdate,null    enddate,sysdate    entrydate,1    isactive,'FBR-196585596,Case No W.P.No.61533 of 2024 As Per Lahore High Court order Exempt SRO-350'
   remarks,0    is_excluded,0    is_granted
    FROM Iris.registration
where REGISTRATION_NO in ('3520224118865','3520223231797');
---2 rows created




