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
  - [1.1. Motivation 💎](#11-motivation-)
  - [1.2. From](#12-from)
  - [1.3. To](#13-to)
  - [1.4. Getting Started 🏄](#14-getting-started-)
    - [1.4.1. Prerequisite](#141-prerequisite)
    - [1.4.2. Install Library](#142-install-library)
    - [1.4.3. Create a JSON File](#143-create-a-json-file)
    - [1.4.4. Execute Command](#144-execute-command)
  - [1.5. Contribution 🏆](#15-contribution-)
  - [1.6. Support ❤️](#16-support-️)
  - [1.7. License 🔑](#17-license-)
  - [1.8. More Information 🧐](#18-more-information-)

<!-- /TOC -->

# 1. Guide 🌎

This library was built on the foundation of the [json_serializable](https://pub.dev/packages/json_serializable) and [freezed](https://pub.dev/packages/freezed) libraries.

This library provides the ability to automatically generate class objects supported by the [freezed](https://pub.dev/packages/freezed) library **directly from JSON files**.

The goal of this library is to **maximize developer productivity by automatically generating implementations from design** data.

Show some ❤️ and star the repo to support the project.

> **Note**</br>
> Many of the specifications in this library are still in development. Your contributions are very welcome!

## 1.1. Motivation 💎

- Realize JSON-based model design.
- Realize automatic generation of model objects from design.
- Synchronize the design and implementation of model objects.
- Expand the possibilities of the freezed library even more.
- etc...

And all you have to do is prepare a JSON file defining the structure of the model object to be generated and run the command `dart run freezer:main` in a terminal.

You can see the following example.

## 1.2. From

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

## 1.3. To

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

And `.freezed.dart` and `.g.dart` files are automatically generated at the same time.</br>
**So, there is even no need to run `build_runner` yourself!**

## 1.4. Getting Started 🏄

### 1.4.1. Prerequisite

The codes automatically generated by this library depend on annotations from [freezed](https://pub.dev/packages/freezed).

So, let's add the prerequisite libraries to `pubspec.yaml` as follows.

```yaml
dependencies:
  freezed_annotation: ^latest
```

### 1.4.2. Install Library

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

### 1.4.3. Create a JSON File

**freezer** interprets JSON files as design information and automatically generates object classes supported by the [freezed](https://pub.dev/packages/freezed) library.

And you need to note following rules when you use the `freezer`.

1. **freezer** parses files with the `.freezer.json` extension.
2. **freezer** parses JSON files stored in the `.design` folder.

So, now let's create a JSON file with the following structure as a trial.

```json
{
  "shop": {
    "name.!required": "My Fancy Shop",
    "product.!as:products": [
      {
        "name": "Chocolate",
        "price": 5.99,
        "product_type": 1
      },
      {
        "name": "Gummy",
        "price": 8.99
      }
    ],
    "closed": false
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

### 1.4.4. Execute Command

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
┃  ┣━━ 🎉 /Users/user/freezer/lib/sample/products.dart
┃  ┣━━ 🎉 /Users/user/freezer/lib/sample/products.freezed.dart
┃  ┣━━ 🎉 /Users/user/freezer/lib/sample/products.g.dart
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
│       ├── products.dart
│       ├── products.freezed.dart
│       ├── products.g.dart
│       ├── shop.dart
│       ├── shop.freezed.dart
│       └── shop.g.dart
├── pubspec.lock
└── pubspec.yaml
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
