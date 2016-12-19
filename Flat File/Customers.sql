SELECT
       [name] = Cust.Kundenavn, 	   
	   [accountReference] = Cust.accountRef,
	   [corporateId] = Cust.Organisasjonsnr,
	   [vatRegistrationId] = cust.mvaregnr,
	   [customerClass] = case when land != 'NO' then '2' else '1' end,
	   [currencyId] = ISNULL(Cust.Valuta,'NOK'),

       [status] = 'Active',
	   [creditVerification] = NULL,
	   [creditDaysPastDue] = NULL,

	   [mainAddress.addressLine1] = Cust.Adresselinje1, 
	   [mainAddress.addressLine2] = Cust.Adresselinje2, 
	   [mainAddress.addressLine3] = Cust.Adresselinje3, 
	   [mainAddress.country] = Cust.land,
	   [mainAddress.postalCode] = Cust.Postnr,
	   [mainAddress.city] = Cust.Sted,

	   [deliveryAddress.addressLine1] = Cust.Adresselinje1, 
	   [deliveryAddress.addressLine2] = Cust.Adresselinje2, 
	   [deliveryAddress.addressLine3] = Cust.Adresselinje3, 
	   [deliveryAddress.country] = Cust.land,
	   [deliveryAddress.postalCode] = Cust.Postnr,
	   [deliveryAddress.city] = Cust.sted,

	   [invoiceAddress.addressLine1] = Cust.Adresselinje1, 
	   [invoiceAddress.addressLine2] = Cust.Adresselinje2, 
	   [invoiceAddress.addressLine3] = Cust.Adresselinje3, 
	   [invoiceAddress.country] = Cust.land,
	   [invoiceAddress.postalCode] = Cust.postnr,

	   [mainContact.name] = ISNULL(cust.Kontaktperson, cust.Kundenavn),
	   [mainContact.email] = Cust.[E-post],
	   [mainContact.web] = Cust.web,
	   [mainContact.phone1] = Cust.Telefon1,
	   [mainContact.phone2] = Cust.Telefon2,
	   [mainContact.fax] = Cust.Faks,

	   [deliveryContact.name] = ISNULL(cust.Kontaktperson, cust.Kundenavn),
	   [deliveryContact.email] = Cust.[E-post],
	   [deliveryContact.web] = Cust.web,
	   [deliveryContact.phone1] = Cust.Telefon1,
	   [deliveryContact.phone2] = Cust.Telefon2,
	   [deliveryContact.fax] = Cust.Faks,

	   [invoiceContact.name] = ISNULL(cust.Kontaktperson, cust.Kundenavn),
	   [invoiceContact.email] = Cust.[E-post],
	   [invoiceContact.web] = Cust.web,
	   [invoiceContact.phone1] = Cust.Telefon1,
	   [invoiceContact.phone2] = Cust.Telefon2,
	   [invoiceContact.fax] = Cust.Faks,

	   [acceptAutoInvoices] = 1,
	   [printStatements] = 1,
	   [printInvoices] = 0	   

FROM dbo.Customers Cust
order by Kundenavn asc