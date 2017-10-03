USE PDATA
/*
    Use this as a starter in order to create a new Customer query
    */
SELECT distinct
    [name] = C.NAME, 
    --[number] = C.CUSTID, 
    [accountReference] = c.CUSTID,
    [corporateId] = ISNULL(ISNULL(c.NormalizedOrgNo, C.vatno), C.Enterno),     
    [customerClass] = '1',
    [creditTerms] = '14',
    [currencyId] = CUR.ISOCODE,
	[sisteOrdreDato] = X.OrderDate,

    [status] = CASE WHEN C.CSTOP = 1 THEN 'CreditHold' 
					WHEN C.INACTIV = 1 THEN 'Inactive'
					ELSE 'Active' END,
    [creditVerification] = NULL,
    [creditLimit] = CASE WHEN C.CLIMIT > 0 THEN C.CLIMIT ELSE NULL END,
    [creditDaysPastDue] = NULL,

    [mainAddress.addressLine1] = CASE WHEN MAIN.STREET IS NOT NULL THEN MAIN.STREET ELSE INVO.STREET END, 
    [mainAddress.addressLine2] = NULL, 
    [mainAddress.addressLine3] = NULL,  
    [mainAddress.country] = ONIT.dbo.CountryThreeToTwo(MAINCTRY.ISO_CODE),
    [mainAddress.postalCode] = NULLIF(REPLACE(RTRIM(LTRIM(CASE WHEN MAIN.STREET IS NOT NULL THEN MAIN.ZIPCODE ELSE INVO.ZIPCODE END)), ' ', ''),''),
    [mainAddress.city] = CASE WHEN MAIN.STREET IS NOT NULL THEN MAIN.City ELSE INVO.CITY END,

    [deliveryAddress.addressLine1] = del.STREET, 
    [deliveryAddress.addressLine2] = null, 
    [deliveryAddress.addressLine3] = NULL, 
    [deliveryAddress.country] = ONIT.dbo.CountryThreeToTwo(DELCTRY.ISO_CODE),
    [deliveryAddress.postalCode] =  NULLIF(REPLACE(RTRIM(LTRIM(del.ZIPCODE)), ' ', ''), ''),
    [deliveryAddress.city] = RTRIM(LTRIM(del.CITY)),

    [invoiceAddress.addressLine1] = INVO.STREET, 
    [invoiceAddress.addressLine2] = null, 
    [invoiceAddress.addressLine3] = NULL, 
    [invoiceAddress.country] = ONIT.dbo.CountryThreeToTwo(INVOCTRY.ISO_CODE),
    [invoiceAddress.postalCode] = NULLIF(REPLACE(RTRIM(LTRIM(invo.ZIPCODE)), ' ', ''), ''),
	[invoiceAddress.city] = invo.CITY,

    [mainContact.name] = C.NAME,
    [mainContact.email] = Mail.Email,
    [mainContact.web] = c.WWW,
    [mainContact.phone1] = c.PHONE1,
    [mainContact.fax] = c.FAX1,

    [deliveryContact.name] = null,
    [deliveryContact.email] = NULL,
    [deliveryContact.phone1] = NULL,
    [deliveryContact.phone2] = NULL,
    [deliveryContact.fax] = NULL,

    [invoiceContact.name] = NULL,
    [invoiceContact.email] = NULL,
    [invoiceContact.phone1] = NULL,
    [invoiceContact.phone2] = NULL,
    [invoiceContact.fax] = NULL,

	[overrideWithClassValues] = 0,	
    [acceptAutoInvoices] = 1,
    [printInvoices] = 1,
    [sendInvoicesByEmail] = CASE WHEN Mail.Email IS NOT NULL THEN 1 ELSE 0 END,
    [printStatements] = 1,
    [sendStatementsByEmail] = CASE WHEN Mail.Email IS NOT NULL THEN 1 ELSE 0 END,
    [printMultiCurrencyStatements] = 1,
	[note] = C.MEMO,
	[vatZone] = '01'
FROM dbo.G_CONTAC C
OUTER APPLY (SELECT TOP 1 * FROM dbo.G_DELI DEL WHERE DEL.SOURCEID = C.CONTID AND DEL.ADRTYPE = 1 AND DEL.STANDARD = 1 AND LEN(DEL.STREET) > 0 ORDER BY DEl.ADDRESSID DESC)DEL
LEFT OUTER JOIN G_COUNTRY DELCTRY ON DELCTRY.COUNTRYID = DEL.DATA56
OUTER APPLY (SELECT TOP 1 * FROM dbo.G_DELI MAIN WHERE MAIN.SOURCEID = C.CONTID AND MAIN.ADRTYPE IN (1, 3) AND MAIN.STANDARD = 1 AND LEN(MAIN.STREET) > 0 ORDER BY MAIN.ADRTYPE DESC)MAIN
LEFT OUTER JOIN G_COUNTRY MAINCTRY ON MAINCTRY.COUNTRYID = MAIN.DATA56
OUTER APPLY (SELECT TOP 1 * FROM dbo.G_DELI INVO WHERE INVO.SOURCEID = C.CONTID AND INVO.ADRTYPE = 2 AND INVO.STANDARD = 1 AND LEN(INVO.STREET) > 0 ORDER BY INVO.ADDRESSID DESC)INVO
LEFT OUTER JOIN G_COUNTRY INVOCTRY ON INVOCTRY.COUNTRYID = INVO.DATA56
OUTER APPLY (SELECT CASE WHEN C.EMAIL LIKE '%@%.%' THEN C.EMAIL ELSE NULL END Email)Mail
OUTER APPLY (select TOP 1 ord.DATEORDER OrderDate from dbo.G_ORDER ord where ord.DATEORDER > '2015-01-01 00:00' and ord.CUSTID = c.CUSTID order by ord.DATEORDER desc)X
LEFT OUTER JOIN dbo.G_CURRENCY CUR ON CUR.CURRENCYID = C.CURRENCYID
where len(c.name) > 0 and c.CONT = 1 and x.OrderDate is not null and c.SelfEmployed = 0
