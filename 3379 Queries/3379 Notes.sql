		--Nursing Notes

SELECT
        nr.Coid AS HospId
		,Substr(Cast(Cast(Trim(OTranslate(reg.Medical_Record_Num,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' ,'')) AS INTEGER) + 135792468 + Cast(nr.Coid AS INTEGER) + 1000000000000 AS CHAR(13)),2,12) AS PtID
		,Cast((reg.Patient_DW_ID (Format '999999999999999999')) + 135792468 + Cast(nr.Coid AS INTEGER)AS DECIMAL(18,0)) AS AdmtID
       ,Cast (nr.Nursing_Query_Occr_Date_Time AS DATE Format 'YYYY-MM-DD') - Cast (pop.Admission_Date AS DATE Format 'YYYY-MM-DD') AS Rel_Occur_Day
        ,nr.Nursing_Query_Occr_Date_Time(TIME) AS Occur_Time
		,nr.Nursing_Query_Id_Txt AS EMR_Q
        ,nr.Nursing_Result_Val_Txt AS EMR_A
		,nr.Source_System_Original_Code AS EMR_Source_Code
FROM EDWCDM_PC_Views.Fact_Nursing_Result nr

INNER JOIN qwu6617.Charles3379GI pop
ON nr.Patient_DW_Id = pop.Patient_DW_Id
AND nr.Company_Code = pop.Company_Code
AND nr.Coid = pop.Coid

INNER JOIN EDWCL_Views.Clinical_Registration reg
  ON nr.Patient_DW_Id = reg.Patient_DW_Id
AND nr.CoID = reg.CoID
AND nr.company_code = reg.company_code

WHERE EMR_Source_Code in(
'P.480408',
'EFDCV083L',
'F15410037A',
'N570O000AA',
'NU030019',
'NUROUT56Q',
'EFDCV073L',
'EFD.NE50',
'D78010058A',
'fwSUIC015',
'NU29448',
'P.480061A',
'NURST0512A',
'1TCH00276A',
'MTPTAMPA19',
'NU030016',
'S70010196A',
'OTACDA600',
'GNUR6COT06',
'QEDM01619',
'EFDOTDA618',
'NU29407A',
'div510003b',
'wfd480614',
'wfd510003b',
'wfd510003c',
'wfd510020',
'NU030014',
'EFDCV072L',
'NURST0511K',
'P.480163',
'hcaORL561',
'EFDCV087L',
'NUR35023C',
'L35020153A',
'NU130126A',
'P.480074C',
'F15310062A',
'EFDCV077L',
'P.121962',
'NURRTM103A',
'hcaPU00020',
'NU290014',
'L36320009A',
'EFDCV082L',
'L36320004A',
'QEDM3003',
'D78010099A',
'NT251040',
'L35020150A',
'D78010058B',
'D78010077A',
'N570O000EA',
'EFDCV081L',
'N570O000CA',
'F15410037B',
'L35010054A',
'EFDCV085L',
'N570O001PA',
'EFDCV076L',
'hcaORL562',
'tdNUT012b',
'J29010615A',
'L36020129A',
'N570O001AA',
'NU030018',
'NURCVCL57',
'N570O001CA',
'EFDCV086L',
'N350015',
'EFDCV075L',
'hcaORL560',
'EFDCV084L',
'wfd480613',
'N570O000PA',
'EFDCV080L',
'L35020052A',
'D78010068A',
'L36000090A',
'NFLRES0016',
'EFDCV079L',
'D78010079A',
'NUROUT25',
'L36410034A',
'L36020157A',
'EFDCV074L')

GROUP BY 1,2,3,4,5,6,7,8