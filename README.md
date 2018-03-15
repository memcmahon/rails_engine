# Rails Engine #

### An API exploration implemented by Ellen Cornelius and Megan McMahon ###

## Setup ##

1. Install the application at the command prompt:

```
$ git clone https://github.com/memcmahon/rails_engine.git
$ cd rails_engine
$ bundle install
```

2. Setup the database:

```
$ rails db:create db:migrate
```

3. Import data

```
$ rake import
```

You're now set to use the App!

## Starting Up and Using the APIs ##

Before sending any API requests, start your server:

```
$ rails server
```

Pay attention to the port that is opened when you start your server, most likely, it will be port 3000 as illustrated below; but, it may be slightly different on your machine.

```
* Listening on tcp://0.0.0.0:3000
```

After identifying your port, open your internet browser of choice, or Postman (more information about postman [here](https://www.getpostman.com/docs/v6/))

You can send any of the requests below to ```localhost::3000``` or whatever port is opened when you start your local server.

## Available Requests ##

## Merchants ##
### Record Endpoints ###
```
GET /api/v1/merchants
```
```
GET /api/v1/merchants/:id
```
```
GET /api/v1/transactions/random
```
```
GET /api/v1/merchants/find?id=x

* where x is a merchant id
```
```
GET /api/v1/merchants/find?name=x

* where x is a merchant name
```
```
GET /api/v1/merchants/find?created_at=x

* where x is a date formatted as yyyy-mm-dd
```
```
GET /api/v1/merchants/find?updated_at=x

* where x is a date formatted as yyyy-mm-dd
```
```
GET /api/v1/merchants/find_all?id=x

* where x is a merchant id
```
```
GET /api/v1/merchants/find_all?name=x

* where x is a merchant name
```
```
GET /api/v1/merchants/find_all?created_at=x

* where x is a date formatted as yyyy-mm-dd
```
```
GET /api/v1/merchants/find_all?updated_at=x

* where x is a date formatted as yyyy-mm-dd
```

### Relationship Endpoints ###
```
GET /api/v1/merchants/:id/items
```
```
GET /api/v1/merchants/:id/invoices
```

### Business Intelligence Endpoints ###

```
GET /api/v1/merchants/most_revenue?quantity=x

* where x is the number of merchantsyou would like returned
```
```
GET /api/v1/merchants/most_items?quantity=x

* where x is the number of merchants you would like returned
```
```
GET /api/v1/merchants/revenue?date=x

* where x is a date formatted as yyyy-mm-dd
```
```
GET /api/v1/merchants/:id/revenue
```
```
GET /api/v1/merchants/:id/revenue?date=x

* where x is a date formatted as yyyy-mm-dd
```
```
GET /api/v1/merchants/:id/favorite_customer
```
```
GET /api/v1/merchants/:id/customers_with_pending_invoices
```

## Transactions ##
### Record Endpoints ###
```
GET /api/v1/transactions
```
```
GET /api/v1/transactions/:id
```
```
GET /api/v1/transactions/random
```
```
GET /api/v1/transactions/find?id=x

* where x is a transaction id
```
```
GET /api/v1/transactions/find?result=x

* where x is either success or failed
```
```
GET /api/v1/transactions/find?credit_card_number=x

* where x is a credit card number
```
```
GET /api/v1/transactions/find?created_at=x

* where x is date formatted as yyyy-mm-dd
```
```
GET /api/v1/transactions/find?updated_at=x

* where x is date formatted as yyyy-mm-dd
```
```
GET /api/v1/transactions/find_all?id=x

* where x is a transaction id
```
```
GET /api/v1/transactions/find_all?result=x

* where x is either success or failed
```
```
GET /api/v1/transactions/find_all?credit_card_number=x

* where x is a credit card number
```
```
GET /api/v1/transactions/find_all?created_at=x

* where x is date formatted as yyyy-mm-dd
```
```
GET /api/v1/transactions/find_all?updated_at=x

* where x is date formatted as yyyy-mm-dd
```

### Relationship Endpoints ###
```
GET /api/v1/transactions/:id/invoice
```

## Customers ##
### Record Endpoints ###
```
GET /api/v1/customers
```
```
GET /api/v1/customers/:id
```
```
GET /api/v1/customers/random
```
```
GET /api/v1/customers/find?id=x

* where x is a customer id
```
```
GET /api/v1/customers/find?first_name=x

* where x is a customer first name
```
```
GET /api/v1/customers/find?last_name=x

* where x is a customer last_name
```
```
GET /api/v1/customers/find?created_at=x

* where x is a date formatted yyyy-mm-dd
```
```
GET /api/v1/customers/find?updated_at=x

* where x is a date formatted yyyy-mm-dd
```
```
GET /api/v1/customers/find_all?id=x

* where x is a customer id
```
```
GET /api/v1/customers/find_all?first_name=x

* where x is a customer first name
```
```
GET /api/v1/customers/find_all?last_name=x

* where x is a customer last_name
```
```
GET /api/v1/customers/find_all?created_at=x

* where x is a date formatted yyyy-mm-dd
```
```
GET /api/v1/customers/find_all?updated_at=x

* where x is a date formatted yyyy-mm-dd
```

### Relationship Endpoints ###
```
GET /api/v1/customers/:id/invoices
```
```
GET /api/v1/customers/:id/transactions
```

### Business Intelligence Endpoints ###
```
GET /api/v1/customers/:id/favorite_merchant
```

## Invoices ##
### Record Endpoints ###
```
GET /api/v1/invoices
```
```
GET /api/v1/invoices/:id
```
```
GET /api/v1/invoices/random
```
```
GET /api/v1/invoices/find?id=x

* where x is an invoice id
```
```
GET /api/v1/invoices/find?customer_id=x

* where x is a customer id
```
```
GET /api/v1/invoices/find?merchant_id=x

* where x is a merchant id
```
```
GET /api/v1/invoices/find?status=x

* where x is an invoice status
```
```
GET /api/v1/invoices/find?created_at=x

* where x is a date formatted yyyy-mm-dd
```
```
GET /api/v1/invoices/find?updated_at=x

* where x is a date formatted yyyy-mm-dd
```
```
GET /api/v1/invoices/find_all?id=x

* where x is an invoice id
```
```
GET /api/v1/invoices/find_all?customer_id=x

* where x is a customer id
```
```
GET /api/v1/invoices/find_all?merchant_id=x

* where x is a merchant id
```
```
GET /api/v1/invoices/find_all?status=x

* where x is an invoice status
```
```
GET /api/v1/invoices/find_all?created_at=x

* where x is a date formatted yyyy-mm-dd
```
```
GET /api/v1/invoices/find_all?updated_at=x

* where x is a date formatted yyyy-mm-dd
```

### Relationship Endpoints ###
```
GET /api/v1/invoices/:id/transactions
```
```
GET /api/v1/invoices/:id/invoice_items
```
```
GET /api/v1/invoices/:id/items
```
```
GET /api/v1/invoices/:id/customer
```
```
GET /api/v1/invoices/:id/merchant
```

## Items ##
### Record Endpoints ###
```
GET /api/v1/items
```
```
GET /api/v1/items/:id
```
```
GET /api/v1/items/random
```
```
GET /api/v1/items/find?id=x

* where x is an item id
```
```
GET /api/v1/items/find?name=x

* where x is an item name
```
```
GET /api/v1/items/find?description=x

* where x is an item description
```
```
GET /api/v1/items/find?unit_price=x

* where x is a price in 00.00 format
```
```
GET /api/v1/items/find?merchant_id=x

* where x is a merchant id
```
```
GET /api/v1/items/find?created_at=x

* where x is a date formatted yyyy-mm-dd
```
```
GET /api/v1/items/find?updated_at=x

* where x is a date formatted yyyy-mm-dd
```
```
GET /api/v1/items/find_all?id=x

* where x is an item id
```
```
GET /api/v1/items/find_all?name=x

* where x is an item name
```
```
GET /api/v1/items/find_all?description=x

* where x is an item description
```
```
GET /api/v1/items/find_all?unit_price=x

* where x is a price in 00.00 format
```
```
GET /api/v1/items/find_all?merchant_id=x

* where x is a merchant id
```
```
GET /api/v1/items/find_all?created_at=x

* where x is a date formatted yyyy-mm-dd
```
```
GET /api/v1/items/find_all?updated_at=x

* where x is a date formatted yyyy-mm-dd
```

### Relationship Endpoints ###
```
GET /api/v1/items/:id/invoice_items
```
```
GET /api/v1/items/:id/merchant
```
### Business Intelligence Endpoints ###
```
GET /api/v1/items/most_revenue?quantity=x

* where x is the number of items to return
```
```
GET /api/v1/items/most_items?quantity=x

* where x is the number of items to return
```
```
GET /api/v1/items/:id/best_day
```

## Invoice Items ##
### Record Endpoints ###
```
GET /api/v1/invoice_items
```
```
GET /api/v1/invoice_items/:id
```
```
GET /api/v1/invoice_items/random
```
```
GET /api/v1/invoice_items/find?id=x

* where x is an invoice item id
```
```
GET /api/v1/invoice_items/find?invoice_id=x

* where x is an invoice_id
```
```
GET /api/v1/invoices_items/find?item_id=x

* where x is an item id
```
```
GET /api/v1/invoice_item/find?unit_price=x

* where x is a price in 00.00 format
```
```
GET /api/v1/invoice_items/find?quantity=x

* where x is a quantity of items
```
```
GET /api/v1/invoice_items/find?created_at=x

* where x is a date formatted yyyy-mm-dd
```
```
GET /api/v1/invoice_items/find?updated_at=x

* where x is a date formatted yyyy-mm-dd
```
```
GET /api/v1/invoice_items/find_all?id=x

* where x is an invoice item id
```
```
GET /api/v1/invoice_items/find_all?invoice_id=x

* where x is an invoice_id
```
```
GET /api/v1/invoices_items/find_all?item_id=x

* where x is an item id
```
```
GET /api/v1/invoice_item/find_all?unit_price=x

* where x is a price in 00.00 format
```
```
GET /api/v1/invoice_items/find_all?quantity=x

* where x is a quantity of items
```
```
GET /api/v1/invoice_items/find_all?created_at=x

* where x is a date formatted yyyy-mm-dd
```
```
GET /api/v1/invoice_items/find_all?updated_at=x

* where x is a date formatted yyyy-mm-dd
```

### Relationship Endpoints ###
```
GET /api/v1/invoice_items/:id/invoice
```
```
GET /api/v1/invoice_items/:id/item
```

## Testing ##

There is a full test suite available within the application.  To run this test suite, you will need to do the following:
```
$ rails db:test:prepare
$ rspec
```
