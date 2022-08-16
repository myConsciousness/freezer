# Just Execute `dart run freezer:main`

## From

```json
{
  "shop": {
    "name.!required": "My Fancy Shop",
    "product.!as:products": [
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
    "$product": "This is a comment for product field.",
    "$$product": "This is a comment for product object."
  }
}
```

## To

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'products.dart';

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
    @JsonKey(name: 'product') List<Products>? products,
    bool? closed,
  }) = _Shop;

  /// Returns [Shop] based on [json].
  factory Shop.fromJson(Map<String, Object?> json) => _$ShopFromJson(json);
}
```

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'products.freezed.dart';
part 'products.g.dart';

// **************************************************************************
// FreezerGenerator
// **************************************************************************

/// This is a comment for product object.
@freezed
class Products with _$Products {
  const factory Products({
    String? name,
    double? price,
  }) = _Products;

  /// Returns [Products] based on [json].
  factory Products.fromJson(Map<String, Object?> json) =>
      _$ProductsFromJson(json);
}
```
