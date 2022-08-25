<p align="center">
  <a href="https://github.com/myConsciousness/freezer">
    <img alt="freezer" width="700px" src="https://user-images.githubusercontent.com/13072231/184524319-265ea7b1-5870-4213-acb8-e03eca676a0e.png">
  </a>
</p>

<p align="center">
  <b>The Most Powerful Way to Automatically Generate Model Objects from JSON Files ⚡</b>
</p>

---

[![GitHub Sponsor](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&color=ff69b4)](https://github.com/sponsors/myConsciousness)
[![GitHub Sponsor](https://img.shields.io/static/v1?label=Maintainer&message=myConsciousness&logo=GitHub&color=00acee)](https://github.com/myConsciousness)

[![pub package](https://img.shields.io/pub/v/freezer.svg?logo=dart&logoColor=00b9fc)](https://pub.dartlang.org/packages/freezer)
[![Dart SDK Version](https://badgen.net/pub/sdk-version/freezer)](https://pub.dev/packages/freezer/)
[![Test](https://github.com/myConsciousness/freezer/actions/workflows/test.yml/badge.svg)](https://github.com/myConsciousness/freezer/actions/workflows/test.yml)
[![Analyzer](https://github.com/myConsciousness/freezer/actions/workflows/analyzer.yml/badge.svg)](https://github.com/myConsciousness/freezer/actions/workflows/analyzer.yml)
[![codecov](https://codecov.io/gh/myConsciousness/freezer/branch/main/graph/badge.svg?token=J5GT1PF9Y3)](https://codecov.io/gh/myConsciousness/freezer)
[![Issues](https://img.shields.io/github/issues/myConsciousness/freezer?logo=github&logoColor=white)](https://github.com/myConsciousness/freezer/issues)
[![Pull Requests](https://img.shields.io/github/issues-pr/myConsciousness/freezer?logo=github&logoColor=white)](https://github.com/myConsciousness/freezer/pulls)
[![Stars](https://img.shields.io/github/stars/myConsciousness/freezer?logo=github&logoColor=white)](https://github.com/myConsciousness/freezer)
[![Contributors](https://img.shields.io/github/contributors/myConsciousness/freezer)](https://github.com/myConsciousness/freezer/graphs/contributors)
[![Code size](https://img.shields.io/github/languages/code-size/myConsciousness/freezer?logo=github&logoColor=white)](https://github.com/myConsciousness/freezer)
[![Last Commits](https://img.shields.io/github/last-commit/myConsciousness/freezer?logo=git&logoColor=white)](https://github.com/myConsciousness/freezer/commits/main)
[![License](https://img.shields.io/github/license/myConsciousness/freezer?logo=open-source-initiative&logoColor=green)](https://github.com/myConsciousness/freezer/blob/main/LICENSE)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](https://github.com/myConsciousness/freezer/blob/main/CODE_OF_CONDUCT.md)

---

<!-- TOC -->

- [1. Guide 🌎](#1-guide-)
  - [1.1. Features 💎](#11-features-)
    - [1.1.1. From](#111-from)
    - [1.1.2. To](#112-to)
  - [1.2. Getting Started 🏄](#12-getting-started-)
    - [1.2.1. Prerequisite](#121-prerequisite)
    - [1.2.2. Install Library](#122-install-library)
    - [1.2.3. Create a JSON File](#123-create-a-json-file)
    - [1.2.4. Execute Command](#124-execute-command)
  - [1.3. Reference for Identifiers](#13-reference-for-identifiers)
    - [1.3.1. Make Specific Fields Required](#131-make-specific-fields-required)
      - [1.3.1.1. From](#1311-from)
      - [1.3.1.2. To](#1312-to)
    - [1.3.2. Assign an Alias for Objects](#132-assign-an-alias-for-objects)
      - [1.3.2.1. From](#1321-from)
      - [1.3.2.2. To](#1322-to)
    - [1.3.3. Assign an Alias for Fields](#133-assign-an-alias-for-fields)
      - [1.3.3.1. From](#1331-from)
      - [1.3.3.2. To](#1332-to)
  - [1.4. Advanced Usage](#14-advanced-usage)
    - [1.4.1. Enum Generation and Mapping](#141-enum-generation-and-mapping)
    - [1.4.2. External Directory Reference](#142-external-directory-reference)
  - [1.5. Contribution 🏆](#15-contribution-)
  - [1.6. Support ❤️](#16-support-️)
  - [1.7. License 🔑](#17-license-)
  - [1.8. More Information 🧐](#18-more-information-)

<!-- /TOC -->

# 1. Guide 🌎

This library was built on the foundation of the [json_serializable](https://pub.dev/packages/json_serializable) and [freezed](https://pub.dev/packages/freezed) libraries.

This library provides the ability to automatically generate class objects supported by the [freezed](https://pub.dev/packages/freezed) library **directly from JSON files**.

Show some ❤️ and star the repo to support the project.

> **Note**</br>
> Many of the specifications in this library are still in development. Your contributions are very welcome!

## 1.1. Features 💎

- **Generate model objects on a JSON basis**.
- **Synchronize model design and implementation** on a JSON basis.
- **JSON from API can be converted directly into model objects**.
- **Aliases and other useful identifiers**.
- Supports **automatic Enum generation and mapping with model objects**.
- The automatically generated model objects are **based on the freezed library**.
- **Very easy to install**.
- etc...

And all you have to do is prepare a JSON file defining the structure of the model object to be generated and run the command `dart run freezer:main` in a terminal.

You can see the following example.

### 1.1.1. From

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
    "location": [-122.4194, 37.7749],
    "closed": false,
    "$name": "This is a comment for name field.",
    "$products": "This is a comment for product field.",
    "$$products": "This is a comment for product object."
  }
}
```

### 1.1.2. To

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
    List<double>? location,
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

And `.freezed.dart` and `.g.dart` files are automatically generated at the same time.</br>
**So, there is even no need to run `build_runner` yourself!**

## 1.2. Getting Started 🏄

### 1.2.1. Prerequisite

The codes automatically generated by this library depend on annotations from [json_serializable](https://pub.dev/packages/json_serializable) and [freezed](https://pub.dev/packages/freezed).

So, let's add the prerequisite libraries to `pubspec.yaml` as follows.

```yaml
dependencies:
  freezed_annotation: ^latest

dev_dependencies:
  json_serializable: ^latest
  freezed: ^latest
```

### 1.2.2. Install Library

Next, let's install the libraries to use the **freezer** functionality.

Simply add `freezer: ^latest` to your `pubspec.yaml`'s `dev_dependencies`.

Or you can add by command as follows.

**With Dart:**

```bash
dart pub add freezer
```

**With Flutter:**

```bash
flutter pub add freezer
```

### 1.2.3. Create a JSON File

**freezer** interprets JSON files as design information and automatically generates object classes supported by the [freezed](https://pub.dev/packages/freezed) library.

And you need to note following rules when you use the `freezer`.

1. **freezer** parses files with the `.freezer.json` extension.
2. **freezer** parses JSON files stored in the `.design` folder.

So, now let's create a JSON file with the following structure as a trial.

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
    "location": [-122.4194, 37.7749],
    "closed": false,
    "$name": "This is a comment for name field.",
    "$products": "This is a comment for product field.",
    "$$products": "This is a comment for product object."
  }
}
```

And then store this JSON file in the `.design` folder of the root of project.

```bash
.
├── analysis_options.yaml
├── design
│   └── sample
│       └── shop.freezer.json
├── lib
├── pubspec.lock
└── pubspec.yaml
```

### 1.2.4. Execute Command

Now let's execute the following command and see what happens!

```bash
dart run freezer:main
```

Then, this trial is successful if the following output is obtained.

```bash
Started process for 1 files

[INFO] Reading cached asset graph completed, took 28ms
[INFO] Checking for updates since last build completed, took 297ms
[INFO] Running build completed, took 4.0s
[INFO] Caching finalized dependency graph completed, took 19ms
[INFO] Succeeded after 4.1s with 0 outputs (3 actions)

┏━━ Generated dart files
┃  ┣━━ 🎉 /Users/user/freezer/lib/sample/product.dart
┃  ┣━━ 🎉 /Users/user/freezer/lib/sample/product.freezed.dart
┃  ┣━━ 🎉 /Users/user/freezer/lib/sample/product.g.dart
┃  ┣━━ 🎉 /Users/user/freezer/lib/sample/shop.dart
┃  ┣━━ 🎉 /Users/user/freezer/lib/sample/shop.freezed.dart
┃  ┗━━ 🎉 /Users/user/freezer/lib/sample/shop.g.dart
┗━━ 6 files in 5.5022 seconds
```

And you can see generated dart codes in the `.lib` folder like below.

```bash
.
├── analysis_options.yaml
├── design
│   └── sample
│       └── shop.freezer.json
├── lib
│   └── sample
│       ├── product.dart
│       ├── product.freezed.dart
│       ├── product.g.dart
│       ├── shop.dart
│       ├── shop.freezed.dart
│       └── shop.g.dart
├── pubspec.lock
└── pubspec.yaml
```

## 1.3. Reference for Identifiers

**freezer** provides **useful identifiers** for creating model objects from JSON files.

These identifiers can be used to automatically create classes and fields with names that differ from the field names defined in the JSON file without directly editing the model object source.

| Identifier       | Description                                                                                     | Example                                                      |
| ---------------- | ----------------------------------------------------------------------------------------------- | ------------------------------------------------------------ |
| **.!required**   | The field with this identifier shall be a required field.                                       | `name.!required`                                             |
| **.!as:**        | Assign an alias to a specific object defined in JSON.                                           | `product.!as:my_product`                                     |
| **.!name:**      | Assign an alias to a specific field in object defined in JSON.                                  | `product.!name:my_product`                                   |
| **.!toDateTime** | Treat this field as DateTime type.                                                              | `datetime.!toDateTime`                                       |
| **.!field:**     | Assign an alias to specific field in enum object with value. The default field name is `value`. | `product_type.!field:code`                                   |
| **$**            | A dartdoc can be created for a specific field by tying it to a field name defined in JSON.      | `"$field_name": "This is a comment for field."`              |
| **$$**           | A dartdoc can be created for a specific object by tying it to an object name defined in JSON.   | `"$$object_name": "This is a comment for a object (class)."` |

Also, you can combine multiple identifiers for specific fields and objects like below.

```json
{
  "shop": {
    "products.!as:product.!name:my_products": [
      {
        "name": "Chocolate",
        "price": 5.99
      }
    ]
  }
}
```

### 1.3.1. Make Specific Fields Required

With `!required` identifier, you can make specific fields required</br>
And fields without this identifier are output as nullable, such as `int?` and `String?`.

#### 1.3.1.1. From

```json
{
  "shop": {
    "name.!required": "My Fancy Shop"
  }
}
```

#### 1.3.1.2. To

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shop.freezed.dart';
part 'shop.g.dart';

@freezed
class Shop with _$Shop {
  const factory Shop({
    required String name,
  }) = _Shop;

  factory Shop.fromJson(Map<String, Object?> json) => _$ShopFromJson(json);
}
```

### 1.3.2. Assign an Alias for Objects

With `.!as:` identifier, you can assign an alias to a specific object defined in JSON.

This identifier is useful when you want to rename an object defined in JSON that has a list structure.</br>
The field names in JSON are often plural when the JSON object has a list structure, but it's more convenient to use the singular form when representing it as a class.

When this identifier is used, only the object name is assigned an alias, and the original name is used for the field name.
If you want to change the name of the fields, use in combination with the `!name:` identifier.

#### 1.3.2.1. From

```json
{
  "shop": {
    "products.!as:product": [
      {
        "name": "Chocolate",
        "price": 5.99
      }
    ]
  }
}
```

#### 1.3.2.2. To

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

import 'product.dart';

part 'shop.freezed.dart';
part 'shop.g.dart';

@freezed
class Shop with _$Shop {
  const factory Shop({
    List<Product>? products,
  }) = _Shop;

  factory Shop.fromJson(Map<String, Object?> json) => _$ShopFromJson(json);
}
```

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    String? name,
    double? price,
  }) = _Product;

  factory Product.fromJson(Map<String, Object?> json) =>
      _$ProductFromJson(json);
}
```

### 1.3.3. Assign an Alias for Fields

With `.!name:` identifier, you can assign an alias to a specific field in object defined in JSON.

When this identifier is used, only the field name is assigned an alias, and the original name of the object or file is used.
If you want to change the name of the object, use in combination with the `!as:` identifier.

#### 1.3.3.1. From

```json
{
  "shop": {
    "products.!as:product.!name:my_products": [
      {
        "name": "Chocolate",
        "price": 5.99
      }
    ]
  }
}
```

#### 1.3.3.2. To

```dart
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'product.dart';

part 'shop.freezed.dart';
part 'shop.g.dart';

@freezed
class Shop with _$Shop {
  const factory Shop({
    @JsonKey(name: 'products') List<Product>? myProducts,
  }) = _Shop;

  factory Shop.fromJson(Map<String, Object?> json) => _$ShopFromJson(json);
}
```

## 1.4. Advanced Usage

### 1.4.1. Enum Generation and Mapping

It would be very convenient if constants with certain regularities could be grouped together and held as an Enum.</br>
And fortunately, **freezer** supports automatic generation of Enums based on JSON files and automatic mapping to model objects.

**Don't worry, it's very easy!**

At first, in addition to the model object definition on JSON, one must add a hierarchy to represent Enum.

As shown in the following JSON file, the `"models"` object in the root should be the JSON object of the model object you are familiar with so far.
Then, define the enums to be generated in the root `"enums"` object like following.

```json
{
  "models": {
    "shop": {
      "name.!required": "My Fancy Shop",
      "products.!as:product": [
        {
          "name": "Chocolate",
          "price": 5.99,
          "product_type": "sweet",
          "country": "belgium"
        }
      ]
    }
  },
  "enums": {
    "product_type": [
      {
        "$": "It represents the sweet product.",
        "name": "sweet",
        "value": 0
      },
      {
        "$": "It represents the juice product.",
        "name": "juice",
        "value": 1
      }
    ],
    "country": ["germany", "belgium"],
    "$$country": "It represents the countries.",
  }
}
```

In the above example, the two Enums are defined. It's `product_type` and `country`. The principle of mapping a field in a model object to an Enum is very simple: simply match the name of the field in the model object with the name of the Enum.

`$` and `$$country` are fields representing dartdocs, respectively. `$` is a dartdoc for a specific element of Enum, and fields beginning with `$$` are dartdoc for a specific Enum object by name.

For example, the `product_type` field of the `"products"` object in the `"models"` object will automatically map to the `"product_type"` Enum in the `"enums"` object.

Then let's run the `dart run freezer:main` command using this example JSON! You can get following results.

```dart
import 'package:json_annotation/json_annotation.dart';

enum ProductType {
  /// It represents the sweet product.
  @JsonValue(0)
  sweet(0),

  /// It represents the juice product.
  @JsonValue(1)
  juice(1);

  /// The value of this enum element.
  final int value;

  const ProductType(this.value);
}
```

```dart
/// It represents the countries.
enum Country {
  germany,
  belgium,
}
```

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

import 'country.dart';
import 'product_type.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    String? name,
    double? price,
    ProductType? productType,
    Country? country,
  }) = _Product;

  factory Product.fromJson(Map<String, Object?> json) =>
      _$ProductFromJson(json);
}
```

### 1.4.2. External Directory Reference

For example, there may be situations where you want to generate common objects in an external directory and reuse the common objects generated in that external directory.

In such cases, `references` feature is very useful. By defining a `"references"` object in the root of the JSON file, you can refer to objects in external directories.

For example, consider the following structure.

```bash
.
├── design
│   └── sample
│       ├── common
│       │   └── common.freezer.json
│       └── shop.freezer.json
└── lib
```

And `common.freezer.json` has json structure like below.

```json
{
  "models": {
    "manager": {
      "id": 12345,
      "name": "Jason"
    }
  },
  "enums": {
    "country": ["germany", "belgium"]
  }
}
```

And `shop.freezer.json` has json structure like below.

```json
{
  "models": {
    "shop": {
      "name.!required": "My Fancy Shop",
      "products.!as:product.!name:my_products": [
        {
          "name": "Chocolate",
          "price": 5.99,
          "country": "belgium"
        }
      ],
      "manager": {
        "id": 12345,
        "name": "Jason"
      }
    }
  }
}
```

You can find common terms in the fields defined in `common.freezer.json` and in `shop.freezer.json`. Yes, it's `manager` object and `country` enum.

Then, you can link these objects between different files by using `"references"`. Let's add `"references"` in `shop.freezer.json` like below.

```json
{
  "models": {
    "shop": {
      "name.!required": "My Fancy Shop",
      "products.!as:product.!name:my_products": [
        {
          "name": "Chocolate",
          "price": 5.99,
          "country": "belgium"
        }
      ],
      "manager": {
        "id": 12345,
        "name": "Jason"
      }
    }
  },
  "references": {
    "manager": "./common",
    "country": "./common/"
  }
}
```

You can see outputs like below if you run `dart run freezer:main`.

```bash
.
├── design
│   └── sample
│       ├── common
│       │   └── common.freezer.json
│       └── shop.freezer.json
└── lib
    └── sample
        ├── common
        │   ├── country.dart
        │   ├── manager.dart
        │   ├── manager.freezed.dart
        │   └── manager.g.dart
        ├── product.dart
        ├── product.freezed.dart
        ├── product.g.dart
        ├── shop.dart
        ├── shop.freezed.dart
        └── shop.g.dart
```

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

import './common/manager.dart';
import 'product.dart';

part 'shop.freezed.dart';
part 'shop.g.dart';

@freezed
class Shop with _$Shop {
  const factory Shop({
    required String name,
    @JsonKey(name: 'products') List<Product>? myProducts,
    Manager? manager,
  }) = _Shop;

  factory Shop.fromJson(Map<String, Object?> json) => _$ShopFromJson(json);
}
```

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

import './common/country.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    String? name,
    double? price,
    String? productType,
    Country? country,
  }) = _Product;

  factory Product.fromJson(Map<String, Object?> json) =>
      _$ProductFromJson(json);
}
```

## 1.5. Contribution 🏆

If you would like to contribute to **freezer**, please create an [issue](https://github.com/myConsciousness/freezer/issues) or create a Pull Request.

There are many ways to contribute to the OSS. For example, the following subjects can be considered:

- There are request parameters or response fields that are not implemented.
- Documentation is outdated or incomplete.
- Have a better way or idea to achieve the functionality.
- etc...

You can see more details from resources below:

- [Contributor Covenant Code of Conduct](https://github.com/myConsciousness/freezer/blob/main/CODE_OF_CONDUCT.md)
- [Contribution Guidelines](https://github.com/myConsciousness/freezer/blob/main/CONTRIBUTING.md)
- [Style Guide](https://github.com/myConsciousness/freezer/blob/main/STYLEGUIDE.md)

Or you can create a [discussion](https://github.com/myConsciousness/freezer/discussions) if you like.

**Feel free to join this development, diverse opinions make software better!**

## 1.6. Support ❤️

The simplest way to show us your support is by **giving the project a star** at [GitHub](https://github.com/myConsciousness/freezer) and [Pub.dev](https://pub.dev/packages/freezer).

You can also support this project by **becoming a sponsor** on GitHub:

## 1.7. License 🔑

All resources of **freezer** is provided under the `BSD-3` license.

```license
Copyright 2022 Kato Shinya. All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided the conditions.
```

> **Note**</br>
> License notices in the source are strictly validated based on `.github/header-checker-lint.yml`. Please check [header-checker-lint.yml](https://github.com/myConsciousness/freezer/tree/main/.github/header-checker-lint.yml) for the permitted standards.

## 1.8. More Information 🧐

**freezer** was designed and implemented by **_Kato Shinya ([@myConsciousness](https://github.com/myConsciousness))_**.

- [Creator Profile](https://github.com/myConsciousness)
- [License](https://github.com/myConsciousness/freezer/blob/main/LICENSE)
- [API Document](https://pub.dev/documentation/freezer/latest/freezer/freezer-library.html)
- [Release Note](https://github.com/myConsciousness/freezer/releases)
- [Bug Report](https://github.com/myConsciousness/freezer/issues)
