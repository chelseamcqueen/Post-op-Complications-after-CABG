-- Charles3379GI SURGERY

SELECT
		SC.Coid as HospID
		,SC.Company_Code as company_code
		,Substr(Cast(Cast(Trim(OTranslate(SC.Medical_Record_Num,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' ,
		'')) AS INTEGER) + 135792468 + Cast(SC.Coid AS INTEGER) + 1000000000000 AS CHAR(13)),2,12) AS PtID
		,Cast((SC.Patient_DW_ID (Format '999999999999999999')) + 135792468 + Cast(SC.Coid AS INTEGER)AS DECIMAL(18,0)) AS AdmtID,
		Procedure_Desc,
		Case_Type_SID,
		Cast(SC.Pat_In_Dt_Id AS DATE) - fp.Admission_Date AS Rel_Surg_Day,
		Scheduled_Start_Time,
		Actual_Case_Min_Cnt,
		dal.ASA_Level_Alias_Name AS ASA_Desc
FROM	EDWCDM_Views.Fact_Surgical_Case_Detail SC

INNER JOIN EDWCDM_Views.Fact_Patient fp
	ON fp.Patient_DW_Id = sc.Patient_DW_Id
	AND fp.CoID = sc.CoID
	AND fp.company_code = sc.company_code 

INNER JOIN qwu6617.Charles3379GI pop		--replace pop
	ON SC.Patient_DW_Id = pop.Patient_DW_Id
	AND SC.Company_Code = pop.Company_Code
	AND SC.Coid = pop.Coid
	
LEFT JOIN EDW_DIM_VIEWS.Dim_ASA_Level dal
ON dal.ASA_Level_Sid = sc.ASA_Level_Sid
	
GROUP BY 1,2,3,4,5,6,7,8,9,10