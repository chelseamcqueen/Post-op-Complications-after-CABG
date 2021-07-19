--Charles3379 Surgical Metrics

SELECT  
fso.Coid AS HospID
,Substr(Cast(Cast(Trim(OTranslate(reg.Medical_Record_Num,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' ,'')) AS INTEGER) + 135792468 + Cast(fso.Coid AS INTEGER) + 1000000000000 AS CHAR(13)),2,12) AS PtID
,Cast((reg.Patient_DW_ID (Format '999999999999999999')) + 135792468 + Cast(fso.Coid AS INTEGER)AS DECIMAL(18,0)) AS AdmtID
,Surgical_Output_Vol
,Surgical_Output_Value_Txt
,Surgical_Output_Type_Code
FROM    EDWCDM_Views.Fact_Surgical_Output fso

INNER JOIN qwu6617.Charles3379GI pop
ON fso.Patient_DW_Id = pop.Patient_DW_Id
AND fso.Coid = pop.Coid
AND fso.Company_Code = pop.Company_Code

INNER JOIN EDWCL_Views.Clinical_Registration reg
ON fso.Patient_DW_Id = reg.Patient_DW_Id
AND fso.CoID = reg.CoID
AND fso.company_code = reg.company_code 

GROUP BY 1,2,3,4,5,6