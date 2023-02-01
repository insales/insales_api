
## 0.2.0
* Added: support 429 response code
* Removed unnecessary files from the gem
* Fix `Order#to_xml` `order_lines_attributes`
* Fix `updated_since` time format
* Added `CustomStatus`
* Added `Marketplace`

## 0.1.3 (August 31, 2016)
* `WithUpdatedSince` raises `ActiveResource::ResourceNotFound` on 404
* `Category` and `Collection` now support `WithUpdatedSince`
* Added `Currency`
* Added `PriceKind`
* Added `StockCurrency`

## 0.1.1 (September 30, 2015)
* `App#auth_token` and`Password.create` support optional user_email/user_name/user_id
* Added `Characteristic`
* Added `User`
* Added `Notification`

## 0.1.0 (May 06, 2015)

* Helpers
* Added `ProductFieldValue`
* Controller auth mixins
* `Account` inherits `AR::Singleton` (this breaks `::current` & `#update` methods)
* Added `wait_retry` method
* Added `Property` resource
* Added `ProductField` resource
* Added `ClientGroup` resource

## 0.0.14 (not released to rubygems)

* Added `Image` resource
* Fixed `Variant.group_update`
* Added `DiscountCode` resource
* Added `Product.count` method
* Added `Order.paid?` method
* Added `ApplicationCharge` resource

## 0.0.13 (August 23, 2013)

* `ActiveResource::Singleton` backport.
* Fix for multiple `InsalesApi::App` child-classes in a single app.
