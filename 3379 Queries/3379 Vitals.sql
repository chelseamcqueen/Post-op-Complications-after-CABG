--Charles3379 VITALS 


SELECT 
fvs.Coid AS HospID,
Substr(Cast(Cast(Trim(OTranslate(reg.Medical_Record_Num,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' ,'')) AS INTEGER) + 135792468 + Cast(fvs.Coid AS INTEGER) + 1000000000000 AS CHAR(13)),2,12) AS PtID,
Cast((fp.Patient_DW_ID (Format '999999999999999999'))  + 135792468 + Cast(fp.Coid AS INTEGER)AS DECIMAL(18,0)) AS AdmtID,
CASE
	WHEN fvs.Vital_Id_Txt = fvs.Source_System_Original_Code THEN dvt.Vital_Test_Desc
	ELSE fvs.Vital_Id_Txt
	END AS Vital_Test_Desc,		--updated dvt.Vital_Test_Desc to a case/when to eliminate all the null values to actual descriptions
fvs.Vital_Result_Value_Txt,
fvs.Vital_Result_Unit_Type_Code AS Vital_UOM,
Cast(fvs.Vital_Occr_Date_Time AS DATE) - fp.Admission_Date AS Vital_Rel_Day,
Cast(fvs.Vital_Occr_Date_Time AS TIME) AS Vital_Time,
fvs.Source_System_Original_Code
FROM EDWCDM_PC_VIEWS.Fact_Vital_Signs fvs

INNER JOIN EDWCDM_Views.Fact_Patient fp
ON fp.Patient_DW_Id = fvs.Patient_DW_Id
AND fp.CoID = fvs.CoID
AND fp.company_code = fvs.company_code 

INNER JOIN EDWCL_Views.Clinical_Registration reg
ON fvs.Patient_DW_Id = reg.Patient_DW_Id
AND fvs.CoID = reg.CoID
AND fvs.company_code = reg.company_code 

INNER JOIN qwu6617.Charles3379GI pop
ON fvs.Patient_DW_Id = pop.Patient_DW_Id
AND fvs.Company_Code = pop.Company_Code
AND fvs.Coid = pop.Coid

LEFT JOIN EDWCDM_VIEWS.Dim_Vital_Test dvt
ON dvt.Vital_Test_Sk = fvs.Vital_Test_Sk

WHERE fvs.Source_System_Original_Code IN (
'NUR10040',
'K33010024A',
'EFD0001A',
'NURVS010',
'NFLVS00021',
'NUR100201',
'N10004C',
'EFD.0001B',
'NURVS01',
'NU10001',
'EFD.0001',
'NURVS01B',
'NUR100041',
'NUR10004B',
'NU10001b',
'P.191007',
'NFLVS00022',
'NUR10004D',
'NUR100200',
'P.191005',
'NUR10004',
'N10004',
'NURVS11',
'NURVS01-P',
'NURVS01F',
'cppdiastolic',
'L35020052A',
'N10006',
'NFLVS50002',
'EFD.0002',
'NURVS02',
'NUR10006',
'NU10015',
'NUR100210',
'NFLVS00002',
'P.191015',
'NU.RT138A1',
'NURVS020',
'NFLVS00012',
'NUR10008B',
'TNU35115D',
'K33010006A',
'NUR3501',
'N350014',
'P.191045',
'L35010001A',
'NUR10009',
'NUR10008',
'N10008',
'EFD.003',
'NUR100220',
'NFLVS00003',
'NURVS03',
'P.191025',
'NU10035',
'K33010016A',
'RNU68095A',
'NUR10013',
'NUR100045',
'NUR350110F',
'NUR35003G',
'EFD.005',
'QEDM02858',
'FW350050',
'NU01Z100',
'mt1000015',
'NU35008',
'MWDVSSPO2',
'cppsystolic',
'K33010002A',
'K33010003A')
