--IRIS Registration
 select  REGISTRATION_NO,NAME,ntn,STRN,cell_no,email,ST_REGISTERED_ON,BUS_ACT_IRIS,QUARTERLY_FILER,person_code,ORG_ID_CSV
 from iris.registration where ntn like '%7287663%';

 --Iris sale tax workflow view
 select * from iris.st_workflow where  registration_no  = '3840215712363' and  case_stage_code <>  9 and task_code like '217%';
--Iris sale tax workflow view
select * from iris.st_workflow where  registration_no  = '9011305'  and  case_stage_code <> 9 and TAX_CODE in (10);
--Iris sale tax workflow view
select * from iris.st_workflow where transaction_id in (1000000982668152);
--iris wf_payments
select * from iris.wf_payments where payment_id ='10000000000136343880';
---iris wf_data
select * from iris.ST_WF_DATA where transaction_id='1000000970252597'
and amount_code =100301;
 ----1035523     
--iris payments 
select * from iris.payments where CPR_NO ='ST2024103001011937800'; 
where registration_no ='3204694' and tax_year =2023 and tax_month ='5';

select * from iris.st_workflow where  registration_no = '7287663' and period_start_date ='01-feb-24'
and case_stage_code <> 9 ;and task_code like '217%'; 

---
--Pre-aneexure Sale ledger 
   select * from iris_strv.domestic_documents dd 
 where seller_reg_no = '7287663' 
-- and buyer_reg_no='7278708'
--and doc_no in ('765','766')
--and SPLR_RTN_STATUS =null
-- and case_status_code =3
-- and doc_stage_code =3
-- and doc_status =3
--and INVOICE_SOURCE =1
--AND FORM_ID_purchase is null
and doc_type_id =4
AND DOC_TAX_PERIOD in (202402);
---251963
select 57720259 + 13197424 from dual;

select * from iris_strv.domestic_documents 
where ddoc_id in (1921994130);

select * from iris_strv.CARRY_FORWARD_FOR_STRV where ntn='3980281';
---7abc
select * from iris_strv.form_7abc -- where form_id='1000000949673711'; and amount_code =100111;
where ddoc_id in (1921994130);

--Annex-A Purchase

select * from iris_strv.form_purchase_invoices where form_id='1000000991860540';
where ddoc_id in (2675144746);

select 7910799632 -2577308085  from dual;

--Annex-I Debit/Credit notes
select * from iris_strv.FORM_DCN_DETAILS -- where form_id =1000000990256261 and doc_type_id =9;
where ddoc_id in (2704711819);

--annex-C Sale
select * from iris_strv.form_sale_invoices -- where form_id ='1000000990623958' ;---251966 Invoices 
where ddoc_id in (2746890485);
 
--Annex-B Import
select * from iris_strv.FORM_GDI_DETAILS  where gd_ID in(269980202);
where inserted_by='0299433' and gd_no in (26078,60097);

--Annex-D Export
select *from iris_strv.FORM_EXPORT_DETAILS where FORM_id ='1000000988017917';
where gd_no = '49998'  and inserted_by ='0999488';

 -- Annex-H
select * from iris_strv.FORM_PRM_DETAILS where form_id ='1000000919474810';

--Annex-J
select * from iris_strv.FORM_SRPS_DETAILS where form_id ='1000000985872342'; 

--Annex-K
select * from iris_strv.FORM_ANNEXK_DETAILS where transaction_id ='1000000979744043'; 

--Annex-G
Select * from iris_strv.FORM_STA_DETAILS;

--use for status of invoices
select * from iris_strv.SA_STATUS_CODES;

select  * from iris_strv.SA_VAT_HSCODES WHERE HS_CODE LIKE '8708%';

select * from iris_strv.SA_VAT_ITEM_TYPES;

---Used for SRO item details descriptions
select * from iris_strv.SA_VAT_ITEM_DESC_CODE where item_desc_id ='384';

---used for SRO description
select * from iris_strv.SA_VAT_SRO_CODE where sro_desc ='3rd Schd Table II';

-- This is used for STGOs data and other rules
select * from iris_strv.VAT_RULE_GRNTORREVACCESSTONTN where REGISTRATION_NO ='D036768';
where ruleid = '16';

--this is used for rules define description
select * from iris_strv.SA_VAT_RULES 
where ruleid in (37,27,3,16,51,46);

----Invoices sources like SRB,PRA
select * from iris_strv.SA_INVOICE_SOURCES;

--commercial invoices table
select * from iris_strv.COMMERCIAL_VAT_DSI_DETAILS where commercial_id in (55044803,54130872);
where substr(buyer_NTN,1,7 )='3067933'  
and SUBSTR(SPLR_NTN,1,7) ='3011207'
AND DOC_PERIOD IN ('202408') 
--and doc_date ='28-JUN-24'
--and DOC_NO_NUM in ('135');
and isactive =1;

select * from iris_strv.domestic_documents 
where source_ref_id in (55044803,54130872);


--used for active status in sales tax
select * from iris_strv.REG_TRUST_LEVEL where REGISTRATION_NO ='3520266324608';

--This is used for annex submission record like Annex-c and annex-H
select * from iris_strv.FORM_RTN_STATUS where transaction_id = '1000000979733338';

select * from iris_strv.FORM_RTN_STATUS where registration_no ='3520236705121' order by ST_TAX_PERIOD;

----provisional invoices check 
select *  FROM
             (  SELECT DD.SELLER_REGNO,TO_CHAR(TRUNC(DD.DOC_DATE),'YYYYMM')  TAX_PERIOD,DD.DDOC_ID
                FROM iris_strv.FORM_PURCHASE_INVOICES DD
                WHERE DD.FORM_ID = 1000000980820643
                AND DD.BUYER_REG_NO = '9010518'
                AND DD.FORM_SI_ID <> '444444444444444487'
                AND NVL(DD.CLAIM_ORG_ID,0) IN (10,1)
                GROUP BY DD.SELLER_REGNO,TO_CHAR(TRUNC(DD.DOC_DATE),'YYYYMM') ,DD.DDOC_ID
                UNION ALL
                SELECT DCD.SELLER_REG_NO,TO_CHAR(TRUNC(DCD.DOC_DATE),'YYYYMM')  TAX_PERIOD ,DCD.DDOC_ID
                FROM iris_strv.FORM_DCN_DETAILS DCD
                WHERE  DCD.FORM_ID = 1000000980820643
                AND DCD.BUYER_REG_NO = '9010518'
                AND DCD.DOC_TYPE_ID=10 AND DCD.TAX_TYPE_ID=3
                GROUP BY DCD.SELLER_REG_NO,TO_CHAR(TRUNC(DCD.DOC_DATE),'YYYYMM'),DDOC_ID 
            ) DD
            WHERE-- DD.TAX_PERIOD>=202402 AND 
            EXISTS (SELECT 1 FROM IRIS.ST_WORKFLOW W 
                           WHERE 1=1
                           AND W.REGISTRATION_NO = DD.SELLER_REGNO
                           AND DD.TAX_PERIOD = TO_CHAR(TRUNC(W.PERIOD_START_DATE),'YYYYMM') 
                           AND W.TASK_CODE IN (2171,2175)
                           AND W.CASE_STAGE_CODE = 1 );

------HS-codes check query
--------------Current Month Sale------------------------
      select *--DISTINCT HS_CODE
      from iris_Strv.Form_Sale_Invoices s
       where s.hs_codE IS NOT NULL
        and s.form_id = 1000000980388524  
---------------------------------------
       and not exists(with main as (select w.transaction_id
                                  from iris.ST_workflow w
                                 where w.task_code in (2171, 2175)
                                   and w.case_status_code in (2,4)
                                   and w.case_stage_code in  (1,2)
                                  and w.period_start_date between add_months('01-AUG-24',-13) and '01-AUG-24'
                                   and w.registration_no = '0665014')
      -----------------Previous 12 month Purchase------------
        select 1
          from iris_Strv.Form_purchase_Invoices p, main m
         where m.transaction_id = p.form_id  --join with main
           and trim(p.hs_code) = trim(s.hs_code)  --join with sale
           and p.case_status_code <> 4 --Deleted purchase invoices
           and p.hs_code is not null
        Union all
        -----------------Previous 12 month Imports------------
        select 1
          from iris_Strv.Form_Gdi_Details g, main m
         where m.transaction_id = g.form_id  --join with main
           and substr(g.hs_code, 1, 4) =substr(s.hs_code,1,4)  --join with sale 
           and g.case_status_code <> 4 --in-case of deleted GDs
           and g.hs_code is not null);

-------fetch all data
select reg.registration_no,reg.name,decode(person_code,1,'Ind',2,'AOP',3,'COY') Person_type,reg.st_registered_on,ST_TAX_PERIOD,w.sent_Date Return_subm_date,ANNEXC_CASE_STAGE_CODE,ANNEXC_STATUS_DATE
from iris_strv.form_rtn_status rtn join iris.st_workflow w on rtn.transaction_id=w.transaction_id and case_Stage_code=2 and w.task_code in (2171,2173)
join iris.registration reg on rtn.registration_no=reg.registration_no
where reg.registration_no in ('4230187548709') order by ST_TAX_PERIOD asc;

select DD.DOC_TAX_PERIOD,DD.BUYER_NAME,regsys.CNIC,regsys.NTN,regsys.STRN,regsys.IT_OFFICE_TITLE as TAX_OFFICE,
DD.sale_value,DD.vat_amount
from iris_strv.domestic_documents DD
join  regsys.vu_profile@ODS_hafeez regsys 
ON DD.BUYER_NAME =REGSYS.NAME
where DD.seller_reg_no ='4230187548709';
and dd.doc_tax_period in (202107);

--lesco : 3041094

SELECT
  CASE WHEN BUS_ACT_IRIS = 5 THEN 'Wholesallers' ELSE 'Retailers' END AS Taxpayer_Type,
  COUNT(DISTINCT CASE WHEN TO_CHAR(reg.ST_REGISTERED_ON, 'YYYYMM') BETWEEN '202007' AND '202106' THEN NTN ELSE NULL END) AS TY_2021,
  COUNT(DISTINCT CASE WHEN TO_CHAR(reg.ST_REGISTERED_ON, 'YYYYMM') BETWEEN '202107' AND '202206' THEN NTN ELSE NULL END) AS TY_2022,
  COUNT(DISTINCT CASE WHEN TO_CHAR(reg.ST_REGISTERED_ON, 'YYYYMM') BETWEEN '202207' AND '202306' THEN NTN ELSE NULL END) AS TY_2023
FROM   iris.registration reg
WHERE   TO_CHAR(reg.ST_REGISTERED_ON, 'YYYYMM') BETWEEN '202007' AND '202306'
  AND STRN IS NOT NULL
  AND reg.BUS_ACT_IRIS IN (5, 6)
GROUP BY BUS_ACT_IRIS;


---test
WITH original_query AS 
 ( SELECT * FROM iris_strv.form_sale_invoices 
  WHERE form_id = '1000000964631816' AND doc_type_id = 4),
revised_query AS 
( SELECT *  FROM iris_strv.form_sale_invoices 
  WHERE form_id = '1000000979733338' AND doc_type_id = 4)
SELECT * FROM original_query 
WHERE NOT EXISTS ( SELECT 1  FROM revised_query 
  WHERE original_query.form_id = revised_query.form_id );
  
  WITH original_query AS (
  SELECT *  FROM iris_strv.form_sale_invoices 
  WHERE form_id = '1000000964631816' AND doc_type_id = 4),
revised_query AS ( SELECT *  FROM iris_strv.form_sale_invoices 
  WHERE form_id = '1000000979733338' AND doc_type_id = 4)
SELECT DISTINCT * FROM original_query 
WHERE NOT EXISTS ( SELECT 1  FROM revised_query 
  WHERE original_query.form_id = revised_query.form_id);

 
