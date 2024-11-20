select * from EFBR.REG_BUSINESS ;

select * from EFBR.REG_MAIN where COMPUTER_NO = '0949754';
---regsys
select * from regsys.vu_profile  where CNIC = '4210118897383';
where ntn  in ('0949754');

--vat return main
 SELECT * FROM VAT.VAT_RTN_MAIN where computer_no='949754'
 and tax_period >= '201008' ;
 and REVISION_COUNT =0;
 ----; and EXTRACT(YEAR FROM TAX_PERIOD) = 2024;
 
---annex-c
select * from VAT.VAT_DSI_DETAILS where RETURN_ID in (10871459);
---annex-a
select * from VAT.VAT_DPI_DETAILS where  RETURN_ID in (10871459);

SELECT * FROM EFBR.Revision_Request rr
WHERE rr.Document_Id IN (
  SELECT vrm.Return_ID
  FROM vat.VAT_Rtn_Main vrm
  INNER JOIN EFBR.Reg_Main rm 
  ON vrm.Computer_No = rm.Computer_No
  WHERE rm.NTN = '2242380'
    AND rm.isActive = 1
    AND vrm.isActive = 1
    AND vrm.Tax_Period >= 202108);

--CUSTOM IMPORT MAIN
SELECT * FROM custom.CUSTOMS_IMPORT_MAIN WHERE TRACKING_id in (23415036);
where ntn='8381497'  AND gd_no in ('2319','2744'); and GD_date = '23-jan-2023' ;
and (TRUNC(GD_date) between '23-01-2023' and '31-JUL-24');
/*  
PGHI-HC-624-16-08-2024
*/
select 5202445+ 425644 + 15325 from dual;

--Import details_all_New table 
 select  tracking_id,GD_NO_COMPLETE,HS_CODE, sales_tax,ADDSALETAX ,VERSION_ID
 from Custom.IMPORT_DETAIL_ALL_NEW --WHERE TRACKING_id in (22906895);
 where GD_NO_COMPLETE IN ('PGHI-HC-624-16-08-2024');

--Import header_all_New table 
select  tracking_id,GD_NO_COMPLETE, custom_duty,sales_tax,ADDITIONAL_SALES_TAX
from Custom.IMPORT_HEADER_ALL_NEW --WHERE TRACKING_id in (21946661);
where GD_NO_COMPLETE IN ('KAPS-HC-36035-06-09-2024');

--Import Paymnet breakup_temp table 
select * from Custom.PAYMENT_BREAKUP_TEMP --where tracking_id in (19729405);
where GD_NO_COMPLETE IN ('KAPW-HC-22012-18-08-2022');

--Import Detail_clreance table
select * from Custom.IMPORT_DETAIL_CLEARANCE -- where tracking_id in (21971763);
where GD_NO_COMPLETE IN ('KAPW-HC-22012-18-08-2022');

--Import Header_afterclear Table
select * from Custom.IMPORT_HEADER_AFTERCLEAR where tracking_id in (18386905);
where GD_NO_COMPLETE IN ('KAPW-HC-22012-18-08-2022');

----check if Gd exists in export_fe and custom_exp main
SELECT * FROM  custom.CUSTOMS_EXPORT_MAIN EM
where exists (select 1  from Custom.export_fe FE
where GD_NO_Complete in ('KPEX-SB-29463-16-08-2024','KPEX-SB-37482-30-08-2024')
AND EM.SB_NO =FE.SBNO
AND EM.SB_DATE =FE.SBDATE);

--CUSTOM EXPORTS MAIN
SELECT * FROM  custom.CUSTOMS_EXPORT_MAIN
where ntn='1560383'
-- and sb_no in (3410) AND (TRUNC(SB_date) ='31-jul-24';
and (TRUNC(SB_date) between '01-SEP-24' and '30-SEP-24');

--Export Form-E Table
select * from Custom.export_fe where GD_NO_Complete in ('KPAE-ES-34856-14-10-2024');

/* 
KPAE-ES-34856-14-10-2024
*/

----EXPORT DETAILS ALL
 SELECT * from CUSTOM.EXPORT_DETAIL_ALL_TEMP;
 
 ---EXPORT HEADER ALL
 SELECT * from CUSTOM.EXPORT_HEADER_ALL_TEMP;
 
 ---EXPORT COURIER DATA
 SELECT * from CUSTOM.EXPORT_COURIER_ALL ;
 
 select * from VAT.REF_CUSTOM_COLLECTORATES ;

select * from VAT.REF_CUSTOM_GD_TYPES ;

select * from VAT.VAT_GDE_DETAILS ;


---REGNTN for COM
select * from VAT_CENTRAL.REGNTN_FORCOMMERCIAL where ntn = '6586077' ;

--FBR to Provincial
SELECT * from VAT_CENTRAL.VAT_FBR_DSI_DETAILS_FOR_COMM
where substr(BUYER_NTN,1,7 )='5556471' 
and SUBSTR(SPLR_NTN,1,7) = '0712048' 
AND DOC_PERIOD IN ('202406');

--Provincial to FBR
SELECT * FROM  VAT_CENTRAL.COMMERCIAL_VAT_DSI_DETAILS --where commercial_id in (55044803,54130872);
where substr(buyer_NTN,1,7 )='0225967'  
and SUBSTR(SPLR_NTN,1,7) ='1655684'
--and DOC_NO_NUM in ('PK01P1L2301816');
AND DOC_PERIOD IN ('202408');
AND isactive =1;


---check POS invoices
select *-- sum(totalsales),sum(vatamount) 
from VAT.IMS_FOR_ANNEXC
where substr(NTN,1,7)='4667061'
and ISACTIVE =1
--and invoicedate ='04-JUL-23'
and taxperiod =202408 ;

SET SERVEROUTPUT ON;

SELECT OBJECT_NAME   FROM ALL_OBJECTS
WHERE OBJECT_TYPE = 'table' 
AND OWNER = 'vat'
 ORDER BY OBJECT_NAME;
     
update EFBR.Revision_Request
set ISACTIVE =1,
   REQUEST_STATUS =1,
   LAST_MODIFY_DATE =sysdate,
   REMARKS = REMARKS||'FBR-196428724,old revise return applcation aug,sep,oct,nov-2021'
where REVISION_REQUEST_ID in (990263,976683,976681,976682)
and document_id in (21095346,21095344,21226311,21226312);
---4 rows affected






  
    

       