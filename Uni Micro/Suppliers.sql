/*
    This is not a working query. It is a work in progress.
*/

SELECT [name] = Nm.Name, 
	   [corporateId] = deb.MVANr, 
	   [customerClass] = ISNULL(deb.valutakode, 'NOK'),
	   [currencyId] = deb.Valutakode,

       [status] = 'Active',
	   
	   [mainAddress.addressLine1] = delad.Address, 
	   [mainAddress.addressLine2] = delad.Address2, 
	   [mainAddress.addressLine3] = NULL, 
	   [mainAddress.country] = delad.Country_code,
	   [mainAddress.postalCode] = delad.Postal_code,

	   [deliveryAddress.addressLine1] = delad.Address, 
	   [deliveryAddress.addressLine2] = delad.Address2, 
	   [deliveryAddress.addressLine3] = NULL, 
	   [deliveryAddress.country] = delad.Country_code,
	   [deliveryAddress.postalCode] = delad.Postal_code,

	   [invoiceAddress.addressLine1] = InvoAd.Address, 
	   [invoiceAddress.addressLine2] = InvoAd.Address2, 
	   [invoiceAddress.addressLine3] = NULL, 
	   [invoiceAddress.country] = invoad.Country_code,
	   [invoiceAddress.postalCode] = InvoAd.Postal_code,

	   [mainContact.name] = NULL,
	   [mainContact.email] = email.mailadr,
	   [mainContact.web] = deb.Web,
	   [mainContact.phone1] = phone1.Phone,
	   [mainContact.phone2] = phone1.Phone,
	   [mainContact.fax] = fax.Phone,
	   
	   [acceptAutoInvoices] = 0,
	   [printInvoices] = 0

FROM dbo.KREDITOR Deb
inner join dbo.c_Name Nm on Nm.ID = deb.NameID
left outer join dbo.c_Address DelAd on DelAd.NameLink = Deb.NameID AND DelAd.delivery = -1
left outer join dbo.c_Address InvoAd on InvoAd.NameLink = Deb.NameID AND InvoAd.mail = -1
left outer join dbo.c_Phone Phone1 on Phone1.NameLink = Deb.NameID AND phone1.phonetype = 150101
left outer join dbo.c_Phone Phone2 on Phone2.NameLink = Deb.NameID AND phone2.phonetype = 150102
left outer join dbo.c_Phone Fax on Fax.NameLink = Deb.NameID AND fax.phonetype = 150103
left outer join dbo.c_email Email on Email.namelink = deb.NameID AND Email.standard = -1 and Email.mailadr like '%@%.%'