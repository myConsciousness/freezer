// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'package:freezer/src/freezed_object_parser.dart';

// Package imports:
import 'package:test/test.dart';

void main() {
  group('.execute', () {
    test('normal case', () {
      final actual = FreezedObjectParser(
        'somewhere/design/src/',
        {
          "shop": {
            "name.!required": "My Fancy Shop",
            "products.!as:product.!name:my_products": [
              {"name": "Chocolate", "price": 5.99},
              {"name": "Gummy", "price": 8.99}
            ],
            "closed": false,
            "\$name": "This is a comment for name field.",
            "\$products": "This is a comment for product field.",
            "\$\$products": "This is a comment for product object."
          },
        },
        [],
      ).execute();

      expect(actual.length, 2);

      final shop = actual[1];
      expect(shop.path, 'somewhere/lib/src');
      expect(shop.fileName, 'shop');
      expect(shop.dartDoc.lines.isEmpty, isTrue);
      expect(shop.className, 'Shop');

      expect(shop.importPackages.length, 1);
      expect(shop.importPackages[0].name, 'product');

      expect(shop.elements.length, 3);
      expect(shop.elements[0].hasDartDoc, isTrue);
      expect(shop.elements[0].dartDoc.lines[0],
          'This is a comment for name field.');
      expect(shop.elements[0].isRequired, isTrue);
      expect(shop.elements[0].name, 'name');
      expect(shop.elements[0].type, 'String');
      expect(shop.elements[0].hasTypeVariable, isFalse);
      expect(shop.elements[0].typeVariable, isNull);
      expect(shop.elements[0].hasAnnotation, isFalse);
      expect(shop.elements[0].annotation, isNull);
      expect(shop.elements[0].isNested, isFalse);

      expect(shop.elements[1].name, 'myProducts');
      expect(shop.elements[1].type, 'List');
      expect(shop.elements[1].hasTypeVariable, isTrue);
      expect(shop.elements[1].typeVariable, '<Product>');
      expect(shop.elements[1].isNested, isTrue);
      expect(shop.elements[1].hasAnnotation, isTrue);
      expect(shop.elements[1].annotation, "@JsonKey(name: 'products')");
    });

    test('with not nested list', () {
      final actual = FreezedObjectParser(
        'somewhere/design/src/',
        {
          "shop": {
            "name.!required": "My Fancy Shop",
            "products.!as:product.!name:my_products": [
              {"name": "Chocolate", "price": 5.99},
              {"name": "Gummy", "price": 8.99}
            ],
            "location": [-122.4194, 37.7749],
            "closed": false,
          }
        },
        [],
      ).execute();

      expect(actual.length, 2);

      final shop = actual[1];
      expect(shop.elements.length, 4);
      expect(shop.elements[1].name, 'myProducts');
      expect(shop.elements[1].type, 'List');
      expect(shop.elements[1].hasTypeVariable, isTrue);
      expect(shop.elements[1].typeVariable, '<Product>');
      expect(shop.elements[1].isNested, isTrue);
      expect(shop.elements[1].hasAnnotation, isTrue);
      expect(shop.elements[1].annotation, "@JsonKey(name: 'products')");
      expect(shop.elements[2].name, 'location');
      expect(shop.elements[2].type, 'List');
      expect(shop.elements[2].hasTypeVariable, isTrue);
      expect(shop.elements[2].typeVariable, '<double>');
      expect(shop.elements[2].isNested, isFalse);
    });
  });
}
