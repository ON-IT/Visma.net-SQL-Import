/*
    Use this as a starter for an import from Visma Business.
    Remember that Visma Business-installations are like snow flakes, so consult with your client and/or their
    significant Visma Business consultant in order to get this as right as possible.

    There are no such thing as two identical Visma Business installations.    
    */
SELECT 
    [name] = a.Nm, 
    [number] = a.SupNo, 
    [accountReference] = a.SupNo,
    [corporateId] = a.BsNo, 
    [vatRegistrationId] = a.BsNo, 
    [customerClass] = '1',
    [currencyId] = ISNULL(Cur.ISO, 'NOK'),

    [status] = 'Active',
    
    [mainAddress.addressLine1] = a.ad1, 
    [mainAddress.addressLine2] = a.ad2, 
    [mainAddress.addressLine3] = a.ad3, 
    [mainAddress.country] = a.Ctry,
    [mainAddress.postalCode] = a.PNo,

	[mainContact.name] = a.Nm,
    [mainContact.email] = Mail.MailAd,
    [mainContact.web] = NULL,
    [mainContact.phone1] = a.Phone,
    [mainContact.fax] = NULL,

	-- You might want to set these based on the information the Visma Business consultant gives you.
	--[supplierAddress.addressLine1] = NULL, 
	--[supplierAddress.addressLine2] = NULL, 
	--[supplierAddress.addressLine3] = NULL, 
	--[supplierAddress.country] = NULL, 
	--[supplierAddress.postalCode] = NULL, 

	--[remitAddress.addressLine1] = NULL, 
	--[remitAddress.addressLine2] = NULL, 
	--[remitAddress.addressLine3] = NULL, 
	--[remitAddress.country]  = NULL, 
	--[remitAddress.postalCode] = NULL, 

    [acceptAutoInvoices] = 1,
    [printInvoices] = 0,
    [sendInvoicesByEmail] = 0,
    [printStatements] = 1,
    [sendStatementsByEmail] = 0,
    [printMultiCurrencyStatements] = 0

FROM dbo.Actor A
LEFT OUTER JOIN dbo.cur cur on cur.CurNo = A.Cur
-- Make sure the e-mail address is valid, and remove those who are not.
OUTER APPLY (SELECT CASE WHEN A.MailAd LIKE '%@%.%' THEN A.MailAd ELSE NULL END MailAd)Mail
WHERE A.SupNo > 0