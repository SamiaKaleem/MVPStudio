--Display a list of all property names and their property id’s for Owner Id: 1426.
SELECT p.Name as PropertyName,p.Id as PropertyID 
FROM [dbo].[Property] p
INNER JOIN [dbo].[OwnerProperty] op ON op.PropertyId = p.Id
WHERE op.OwnerId = 1426


--Display the current home value for each property in question a). 
SELECT p.Id as PropertyId, p.Name,phv.Value 
FROM [dbo].[Property] p
INNER JOIN [dbo].[OwnerProperty] op ON op.PropertyId = p.Id
INNER JOIN [dbo].[PropertyHomeValue] phv on phv.PropertyId = p.Id
WHERE op.OwnerId = 1426 and phv.IsActive = 1
ORDER BY p.Id


--For each property in question a), return the following:                                                                      
--Using rental payment amount, rental payment frequency, tenant start date and tenant end date to write a query that returns the sum of all payments from start date to end date. 
--Display the yield. 

SELECT tp.Id as TenantId,tp.PropertyId,tp.PaymentAmount,tp.PaymentFrequencyId, pf.yield as Yield,
IIF(tp.PaymentFrequencyId=3,tp.PaymentAmount*(DATEDIFF(month,tp.StartDate,tp.EndDate)+1), --if frequency is monthly
IIF(tp.PaymentFrequencyId=2,tp.PaymentAmount*(DATEDIFF(week,tp.StartDate,tp.EndDate)/2),  --if frequency is fortnightly
tp.PaymentAmount*DATEDIFF(week,tp.StartDate,tp.EndDate))) as SumOfPayments				  -- if frequency is weekly
FROM [dbo].[TenantProperty] tp
INNER JOIN [dbo].[PropertyFinance] pf ON pf.PropertyId = tp.PropertyId
WHERE tp.PropertyId in 
		(SELECT p.Id 
		FROM [dbo].[Property] p
		INNER JOIN [dbo].[OwnerProperty] op ON op.PropertyId = p.Id
				WHERE op.OwnerId = 1426)
ORDER BY tp.PropertyId



--Display all the jobs available in the marketplace (jobs that owners have advertised for service suppliers).
SELECT * 
FROM [dbo].[Job] j
WHERE j.JobStatusId = '1' AND j.JobStartDate is null		-- displaying all open jobs



--Display all property names, current tenants first and last names and rental payments per week/ fortnight/month for the properties in question a). 

SELECT p.Name as PropertyName, pn.FirstName, pn.LastName, tp.PaymentAmount, tpf.Name as PaymentFrequency
FROM [dbo].[TenantProperty] tp
INNER JOIN [dbo].[Person] pn ON tp.TenantId = pn.Id 
INNER JOIN [dbo].[TenantPaymentFrequencies] tpf ON tpf.Id = tp.PaymentFrequencyId
INNER JOIN [dbo].[Property] p ON tp.PropertyId = p.Id
INNER JOIN [dbo].[OwnerProperty] op ON op.PropertyId = p.Id
WHERE op.OwnerId = 1426


						









