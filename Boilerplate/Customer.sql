/*
    Use this as a starter in order to create a new Customer query
    */
SELECT 
    [name] = NULL, 
    [number] = NULL, 
    [accountReference] = NULL,
    [corporateId] = NULL, 
    [customerClass] = NULL,
    [currencyId] = NULL,

    [status] = NULL,
    [creditVerification] = NULL,
    [creditLimit] = NULL,
    [creditDaysPastDue] = NULL,

    [mainAddress.addressLine1] = NULL, 
    [mainAddress.addressLine2] = NULL, 
    [mainAddress.addressLine3] = NULL, 
    [mainAddress.country] = NULL,
    [mainAddress.postalCode] = NULL,

    [deliveryAddress.addressLine1] = NULL, 
    [deliveryAddress.addressLine2] = NULL, 
    [deliveryAddress.addressLine3] = NULL, 
    [deliveryAddress.country] = NULL,
    [deliveryAddress.postalCode] = NULL,

    [invoiceAddress.addressLine1] = NULL, 
    [invoiceAddress.addressLine2] = NULL, 
    [invoiceAddress.addressLine3] = NULL, 
    [invoiceAddress.country] = NULL,
    [invoiceAddress.postalCode] = NULL,

    [mainContact.name] = NULL,
    [mainContact.email] = NULL,
    [mainContact.web] = NULL,
    [mainContact.phone1] = NULL,
    [mainContact.fax] = NULL,
    
    [deliveryContact.name] = NULL,
    [deliveryContact.email] = NULL,
    [deliveryContact.phone1] = NULL,
    [deliveryContact.phone2] = NULL,
    [deliveryContact.fax] = NULL,

    [invoiceContact.name] = NULL,
    [invoiceContact.email] = NULL,
    [invoiceContact.phone1] = NULL,
    [invoiceContact.phone2] = NULL,
    [invoiceContact.fax] = NULL,

    [acceptAutoInvoices] = 0,
    [printInvoices] = 0

FROM dbo.TableName