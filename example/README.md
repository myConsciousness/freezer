# Just Execute `dart run freezer:main`

## From

```json
{
  "shop": {
    "name.!required": "My Fancy Shop",
    "products.!as:product.!name:my_products": [
      {
        "name": "Chocolate",
        "price": 5.99
      },
      {
        "name": "Gummy",
        "price": 8.99
      }
    ],
    "closed": false,
    "$name": "This is a comment for name field.",
    "$products": "This is a comment for product field.",
    "$$products": "This is a comment for product object."
  }
}
```

## To

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'product.dart';

part 'shop.freezed.dart';
part 'shop.g.dart';

// **************************************************************************
// FreezerGenerator
// **************************************************************************

@freezed
class Shop with _$Shop {
  const factory Shop({
    /// This is a comment for name field.
    required String name,

    /// This is a comment for product field.
    @JsonKey(name: 'products') List<Product>? myProducts,
    bool? closed,
  }) = _Shop;

  /// Returns [Shop] based on [json].
  factory Shop.fromJson(Map<String, Object?> json) => _$ShopFromJson(json);
}
```

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

// **************************************************************************
// FreezerGenerator
// **************************************************************************

/// This is a comment for product object.
@freezed
class Product with _$Product {
  const factory Product({
    String? name,
    double? price,
  }) = _Product;

  /// Returns [Product] based on [json].
  factory Product.fromJson(Map<String, Object?> json) =>
      _$ProductFromJson(json);
}
```
