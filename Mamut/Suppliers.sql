SELECT 
    [name] = c.name,
    --[number] = a.SupNo, 
    [accountReference] = c.VENDID,
    [corporateId] = ISNULL(ISNULL(c.NormalizedOrgNo, C.vatno), C.Enterno),     
    [vatRegistrationId] = ISNULL(ISNULL(c.NormalizedOrgNo, C.vatno), C.Enterno),     
    
    [currencyId] = ISNULL(CUR.ISOCODE, 'NOK'),
	
    [status] = 'Active',
    
    [mainAddress.addressLine1] = CASE WHEN MAIN.STREET IS NOT NULL THEN MAIN.STREET ELSE INVO.STREET END, 
    [mainAddress.addressLine2] = NULL, 
    [mainAddress.addressLine3] = NULL,  
    [mainAddress.country] = ONIT.dbo.CountryThreeToTwo(MAINCTRY.ISO_CODE),
    [mainAddress.postalCode] = NULLIF(REPLACE(RTRIM(LTRIM(CASE WHEN MAIN.STREET IS NOT NULL THEN MAIN.ZIPCODE ELSE INVO.ZIPCODE END)), ' ', ''),''),
    [mainAddress.city] = CASE WHEN MAIN.STREET IS NOT NULL THEN MAIN.City ELSE INVO.CITY END,

	[mainContact.name] = c.name,
    [mainContact.email] = Mail.Email,
    [mainContact.web] = c.WEBSITEID,
    [mainContact.phone1] = c.PHONE1,
    [mainContact.fax] = c.FAX1,

	-- You might want to set these based on the information the Visma Business consultant gives you.
	[supplierAddress.addressLine1] = del.STREET, 
	[supplierAddress.addressLine2] = NULL, 
	[supplierAddress.addressLine3] = NULL, 
	[supplierAddress.country] = onit.dbo.CountryThreeToTwo(DELCTRY.ISO_CODE), 
	[supplierAddress.postalCode] = del.ZIPCODE, 

	[remitAddress.addressLine1] = invo.STREET, 
	[remitAddress.addressLine2] = NULL, 
	[remitAddress.addressLine3] = NULL, 
	[remitAddress.country]  = onit.dbo.CountryThreeToTwo(INVOCTRY.ISO_CODE),  
	[remitAddress.postalCode] = invo.ZIPCODE, 

    [acceptAutoInvoices] = 1,
    [printInvoices] = 0,
    [sendInvoicesByEmail] = 0,
    [printStatements] = 1,
    [sendStatementsByEmail] = 0,
    [printMultiCurrencyStatements] = 0,
    [vatZone] = '10',
    [supplierClass] = '1'

FROM PDATA..G_CONTAC C
OUTER APPLY (SELECT TOP 1 * FROM dbo.G_DELI MAIN WHERE MAIN.SOURCEID = C.CONTID AND MAIN.ADRTYPE IN (1, 3) AND MAIN.STANDARD = 1 AND LEN(MAIN.STREET) > 0 ORDER BY MAIN.ADRTYPE DESC)MAIN
LEFT OUTER JOIN G_COUNTRY MAINCTRY ON MAINCTRY.COUNTRYID = MAIN.DATA56

OUTER APPLY (SELECT TOP 1 * FROM dbo.G_DELI INVO WHERE INVO.SOURCEID = C.CONTID AND INVO.ADRTYPE = 2 AND INVO.STANDARD = 1 AND LEN(INVO.STREET) > 0 ORDER BY INVO.ADDRESSID DESC)INVO
LEFT OUTER JOIN G_COUNTRY INVOCTRY ON INVOCTRY.COUNTRYID = INVO.DATA56

OUTER APPLY (SELECT TOP 1 * FROM dbo.G_DELI DEL WHERE DEL.SOURCEID = C.CONTID AND DEL.ADRTYPE = 1 AND DEL.STANDARD = 1 AND LEN(DEL.STREET) > 0 ORDER BY DEl.ADDRESSID DESC)DEL
LEFT OUTER JOIN G_COUNTRY DELCTRY ON DELCTRY.COUNTRYID = DEL.DATA56

OUTER APPLY (SELECT CASE WHEN C.EMAIL LIKE '%@%.%' THEN C.EMAIL ELSE NULL END Email)Mail
OUTER APPLY (select TOP 1 ord.DATEORDER OrderDate from dbo.G_ORDER ord where ord.DATEORDER > '2015-01-01 00:00' and ord.CUSTID = c.CUSTID order by ord.DATEORDER desc)X
LEFT OUTER JOIN dbo.G_CURRENCY CUR ON CUR.CURRENCYID = C.CURRENCYID
WHERE C.VEND = 1 and x.OrderDate is not null and c.SelfEmployed = 0
