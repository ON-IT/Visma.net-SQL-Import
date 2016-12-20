SELECT 
	[name] = Nm.Name, 
	[corporateId] = KRED.MVANr, 
	[vatRegistrationId] = KRED.MVANr, 
	[supplierClass] = '1',
	[currencyId] = ISNULL(KRED.valutakode, 'NOK'),

	[status] = 'Active',

	[maainAddress.addressLine1] = delad.Address, 
	[mainAddress.addressLine2] = delad.Address2, 
	[mainAddress.addressLine3] = NULL, 
	[mainAddress.country] = delad.Country_code,
	[mainAddress.postalCode] = delad.Postal_code,

	[supplierAddress.addressLine1] = delad.Address, 
	[supplierAddress.addressLine2] = delad.Address2, 
	[supplierAddress.addressLine3] = NULL, 
	[supplierAddress.country] = delad.Country_code,
	[supplierAddress.postalCode] = delad.Postal_code,

	[remitAddress.addressLine1] = InvoAd.Address, 
	[remitAddress.addressLine2] = InvoAd.Address2, 
	[remitAddress.addressLine3] = NULL, 
	[remitAddress.country] = invoad.Country_code,
	[remitAddress.postalCode] = InvoAd.Postal_code,

	[mainContact.name] = NULL,
	[mainContact.email] = email.mailadr,
	[mainContact.web] = KRED.Web,
	[mainContact.phone1] = phone1.Phone,
	[mainContact.phone2] = phone1.Phone,
	[mainContact.fax] = fax.Phone,

	[paymentLeadTime] = KRED.Kredittdager,

	[acceptAutoInvoices] = 0,
	[printInvoices] = 0

FROM dbo.KREDITOR KRED
inner join dbo.c_Name Nm on Nm.ID = KRED.NameID
left outer join dbo.c_Address DelAd on DelAd.NameLink = KRED.NameID AND DelAd.delivery = -1
left outer join dbo.c_Address InvoAd on InvoAd.NameLink = KRED.NameID AND InvoAd.mail = -1
left outer join dbo.c_Phone Phone1 on Phone1.NameLink = KRED.NameID AND phone1.phonetype = 150101
left outer join dbo.c_Phone Phone2 on Phone2.NameLink = KRED.NameID AND phone2.phonetype = 150102
left outer join dbo.c_Phone Fax on Fax.NameLink = KRED.NameID AND fax.phonetype = 150103
left outer join dbo.c_email Email on Email.namelink = KRED.NameID AND Email.standard = -1 and Email.mailadr like '%@%.%'

-- select * from c_addrlink