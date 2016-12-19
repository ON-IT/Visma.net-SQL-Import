/*
    Default query for Customers from Visma Global. 
    Remember to change [SCHEMA] to the correct schema for the database.

    Copyright ON IT AS 2016
*/
SELECT 
    [name] = Cust.Name, 
    [number] = Cust.CustomerNo, 
    [accountReference] = Cust.CustomerNo,
    [corporateId] = Cust.CompanyNo, 
    [customerClass] = NULL,
    [currencyId] = ISNULL(Currency.CurrencyCode,'NOK'),

    [status] = 'Active',
    [creditVerification] = NULL,
    [creditLimit] = Cust.CreditLimit,
    [creditDaysPastDue] = NULL,

    [mainAddress.addressLine1] = Cust.Address1, 
    [mainAddress.addressLine2] = Cust.Address2, 
    [mainAddress.addressLine3] = Cust.Address3, 
    [mainAddress.country] = Country.Alfa2Code,
    [mainAddress.postalCode] = Cust.PostCode,

    [deliveryAddress.addressLine1] = DelAd.DeliveryAddress1, 
    [deliveryAddress.addressLine2] = DelAd.DeliveryAddress2, 
    [deliveryAddress.addressLine3] = DelAd.DeliveryAddress3, 
    [deliveryAddress.country] = DelAdCountry.Alfa2Code,
    [deliveryAddress.postalCode] = DelAd.DeliveryPostCode,

    [invoiceAddress.addressLine1] = InvoAd.InvoiceAdress1, 
    [invoiceAddress.addressLine2] = InvoAd.InvoiceAdress2, 
    [invoiceAddress.addressLine3] = InvoAd.InvoiceAdress3, 
    [invoiceAddress.country] = InvoAdCountry.Alfa2Code,
    [invoiceAddress.postalCode] = InvoAd.InvoiceAdressPostCode,

    [mainContact.name] = Cust.Name,
    [mainContact.email] = Cust.EmailAddress,
    [mainContact.web] = Cust.WWWAddress,
    [mainContact.phone1] = Cust.Telephone,
    [mainContact.fax] = Cust.Telefax,

    [deliveryContact.name] = DelCont.Name,
    [deliveryContact.email] = DelCont.EmailAddress,
    [deliveryContact.phone1] = DelCont.DirectTelephone,
    [deliveryContact.phone2] = DelCont.MobileTelephone,
    [deliveryContact.fax] = DelCont.Telefax,

    [invoiceContact.name] = DelCont.Name,
    [invoiceContact.email] = DelCont.EmailAddress,
    [invoiceContact.phone1] = DelCont.DirectTelephone,
    [invoiceContact.phone2] = DelCont.MobileTelephone,
    [invoiceContact.fax] = DelCont.Telefax,

    [acceptAutoInvoices] = 1,
    [printInvoices] = 0,
    [sendInvoicesByEmail] = 0,
    [printStatements] = 1,
    [sendStatementsByEmail] = 0,
    [printMultiCurrencyStatements] = 0

FROM [SCHEMA].Customer Cust
LEFT OUTER JOIN [SCHEMA].Country ON Country.CountryNo = Cust.CountryNo
LEFT OUTER JOIN [SCHEMA].Contact DelCont on DelCont.ContactNo = Cust.ContactNoDelivery
LEFT OUTER JOIN [SCHEMA].CustomerDeliveryAddresses DelAd on DelAd.DeliveryAddressNo = Cust.DeliveryAddressNo
LEFT OUTER JOIN [SCHEMA].Country DelAdCountry ON DelAdCountry.CountryNo = DelAd.DeliveryCountryNo
LEFT OUTER JOIN [SCHEMA].CustomerInvoiceAdresses InvoAd on InvoAd.InvoiceAdressNo = Cust.InvoiceAdressNo
LEFT OUTER JOIN [SCHEMA].Country InvoAdCountry ON InvoAdCountry.CountryNo = InvoAd.InvoiceadressCountryNo
LEFT OUTER JOIN [SCHEMA].CurrencyTable Currency on Currency.CurrencyNo = Cust.CurrencyNo