--TOTAL UNCLAIMED SALE 44733
select count(*) as No_of_Invoices 
         from iris_strv.domestic_documents dd 
         where  not exists
              (select 1 
              from iris_strv.form_sale_invoices
     where  not exists 
     (select 1
               from iris_strv.form_purchase_invoices
         where  EXISTS (select registration_no
         from          iris_new.workflow 
         where DD.doc_type_id ='4'  
         AND DD.DOC_STATUS ='2')));

--TOTAL CLAIMED INVOICES 37911
  SELECT count(*) as No_of_Invoices 
  from iris_strv.domestic_documents DD
                     where EXISTS  
     (SELECT DDOC_ID
       FROM IRIS_STRV.FORM_PURCHASE_INVOICES 
                    WHERE EXISTS
      (SELECT DDOC_ID 
      FROM IRIS_STRV.FORM_SALE_INVOICES
     WHERE DD.doc_type_id ='4'
      AND DD.DOC_STATUS ='5'));

--TOTAL SALE 74541 
select  count(*) as No_of_Invoices 
         from iris_strv.domestic_documents dd 
         where  exists
              (select * 
              from iris_strv.form_sale_invoices
     where  exists 
     (select * 
               from iris_strv.form_purchase_invoices
         where exists 
               (select *
         from          iris_new.workflow 
         where DD.doc_type_id ='4'   
         )));


 SELECT * FROM IRIS_NEW.IDENTITY_VERIFICATION;



  select * from iris_new.sa_tasks WHERE TAX_CODE ='6'
  AND TASK_CODE = '2175' ;
  
SELECT * FROM IRIS_NEW.WORKFLOW 
   WHERE TAX_CODE ='6' 
        AND TASK_CODE ='2175'
        FETCH FIRST 15 ROWS ONLY; 


select * from iris_strv.document_stages 
WHERE DOC_STAGE_CODE = '4';

SELECT * FROM IRIS_STRV.DOCUMENT_STATUS 
WHERE DOC_STATUS ='5';



-- unclaimed invoices and return submitted
select dd.SELLER_NAME, dd.SELLER_REG_NO, 
dd.DOC_TAX_PERIOD, dd.vat_amount as amount
from iris_strv.domestic_documents dd
join iris_new.workflow wf
on dd.form_id_sale = wf.transaction_id
where dd.DOC_STATUS ='2'
; 

 -- revise returns
         SELECT transaction_id,REGISTRATION_NO,PERIOD_END_DATE  
           FROM     IRIS_NEW.WORKFLOW
      where TASK_CODE ='2175' 
        AND tax_code ='6'
       AND CASE_STATUS_CODE= '2'
       AND CASE_STAGE_CODE = '2' ;
       
    
       
--7a made peoples 
  select DISTINCT wf.REGISTRATION_NO, WFD.TRANSACTION_ID,
         WFD.AMOUNT_CODE , wfd.col_c as Amount_7a
  from iris_strv.domestic_documents dd,
       iris_new.wf_data wfd
     join iris_new.workflow wf
    on wfd.transaction_id = wf.transaction_id
        where DD.DOC_STAGE_CODE = '2'
       AND WF.CASE_STATUS_CODE= '4'
       AND WFD.AMOUNT_CODE = '100111' ; 


   
   -- RETURN SUBMITTED DATA AS ON ANNEX-C
  SELECT DISTINCT    
          SI.SELLER_REG_NO,SI.SELLER_NAME, 
          WF.PERIOD_END_DATE,
          SI.SALE_VALUE as TOTAL_SALE,
          SI.VAT_AMOUNT as OUTPUT,
          PI.PURCHASE_VALUE as TOTAL_PURCHASE,
          PI.VAT_AMOUNT as INPUT 
     FROM  IRIS_STRV.FORM_SALE_INVOICES  SI 
     JOIN IRIS_STRV.FORM_PURCHASE_INVOICES PI
     ON SI.DDOC_ID = PI.DDOC_ID
     JOIN IRIS_NEW.WORKFLOW WF
      ON SI.FORM_ID = WF.TRANSACTION_ID
     WHERE  WF.CASE_STAGE_CODE = '2'
     AND WF.CASE_STATUS_CODE = '2'
     ;
     --388
     
    SELECT * FROM IRIS_NEW.LINKED_PERSONS; 
  
  select count (*) from iris_new.workflow
  where TASK_CODE ='2175' and tax_code ='6';
  
        --unclaimed invoices 44685
           SELECT * --COUNT(*) NO_OF_INVOICES
              from iris_strv.domestic_documents DD
                WHERE NOT EXISTS 
             ( SELECT *  FROM IRIS_STRV.FORM_SALE_INVOICES
                WHERE NOT EXISTS
             (SELECT * 
                 FROM IRIS_STRV.FORM_PURCHASE_INVOICES 
           WHERE DD.doc_type_id ='4'
           AND DD.DOC_STATUS ='2'
           --AND DD.SELLER_REG_NO ='4410372615443'
         )) ;
     
     select * from iris_new.workflow where registration_no ='3630315408633';
     select * from iris_new.workflow where transaction_id ='1000000902431158';

    
    -- all invoice whos made 7a from buyer 
     select * from Iris_Strv.Domestic_Documents dd
where  dd.doc_Stage_code='4';

--dd.buyer_reg_no='3520294640467'
   select * from iris_new.registration where REGISTRATION_NO ='1540214477323';
     
   
  
   
  SELECT   72199-71394 FROM  dual;
  
  SELECT   805-250 FROM  dual;
  
 
         
      
         select * from iris_new.payments pa
         where exists 
         (select * from iris_new.workflow
               where pa.registration_no ='4410372615443' 
              and pa.CLAIMED ='1'
            );
                  
SELECT * FROM IRIS_STRV.domestic_documents WHERE SELLER_REG_NO='3110155538069';

SELECT * 
      FROM IRIS_STRV.DOMESTIC_DOCUMENTS dd
      WHERE dd.DOC_STATUS ='2' 
      AND dd.DDOC_ID NOT IN 
      (SELECT DDOC_ID FROM IRIS_STRV.FORM_PURCHASE_INVOICES
      WHERE FORM_ID IN
      (SELECT TRANSACTION_ID
      FROM IRIS_NEW.WORKFLOW ));
      
    
      SELECT * FROM IRIS_NEW.WORKFLOW WHERE REGISTRATION_NO ='3110155538069';
      
      

SELECT * FROM IRIS_NEW.WF_DATA WHERE TRANSACTION_ID IN ('1000000902431113 ', '1000000902431143','1000000902431146');

select * from iris_new.payments where registration_no ='3110155538069' and claimed = '1';

SELECT * FROM IRIS_STRV.FORM_GDI_DETAILS; --ANNEX-B IMPORT DATA
SELECT * FROM IRIS_STRV.SA_CUSTOM_GD_TYPES; --GD TYPES DATA
SELECT * FROM IRIS_STRV.sa_custom_collectorates;-- COLLECTORATES DATA
SELECT * FROM IRIS_STRV.FORM_EXPORT_DETAILS;-- ANNEX-D EXPORT DATA

select * from iris_strv.MVU_POS_INVOICE_COUNT;


  
  
  SELECT * FROM iris_new.registration WHERE registration_no='3310462329905';
  
  select * from iris_strv.sa_vat_rules;
  
  select * from iris_new.sa_tasks where TAX_CODE ='6'
  where task_code ='2175';
  
 select * from iris_strv.domestic_documents;
 select * from iris_strv.form_purchase_invoices;
 
SELECT * FROM IRIS_NEW.CARRY_FORWARD_FOR_STRV;
SELECT * FROM IRIS_STRV.SA_DOC_TYPES;
  SELECT * FROM IRIS_STRV.Form_7ABC;
  SELECT * FROM IRIS_STRV.DDOC_STAGES;
  select * from iris_strv.sa_status_codes;
 SELECT * FROM IRIS_NEW.LINKED_PERSONS;
 SELECT * FROM IRIS_NEW.LINKED_RESOURCES;
 select * from iris_strv.ims_for_annexc;
