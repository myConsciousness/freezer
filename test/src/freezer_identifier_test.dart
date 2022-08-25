// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'package:freezer/src/policy/freezer_identifier.dart';

// Package imports:
import 'package:test/test.dart';

void main() {
  group('.isRequired', () {
    test('with .!required identifier', () {
      final actual = isRequired('test.!required');

      expect(actual, isTrue);
    });

    test('without .!required identifier', () {
      final actual = isRequired('test.!name:something');

      expect(actual, isFalse);
    });

    test('complicated pattern', () {
      final actual = isRequired('test.!name:something.!required');

      expect(actual, isTrue);
    });
  });

  group('.hasAliasFieldName', () {
    test('with .!name: identifier', () {
      final actual = hasAliasFieldName('test.!name:something');

      expect(actual, isTrue);
    });

    test('without .!name: identifier', () {
      final actual = hasAliasFieldName('test.!required');

      expect(actual, isFalse);
    });

    test('complicated pattern', () {
      final actual = hasAliasFieldName('test.!name:something.!toDateTime');

      expect(actual, isTrue);
    });
  });

  group('.isDateTime', () {
    test('with .!toDateTime identifier', () {
      final actual = isDateTime('test.!toDateTime');

      expect(actual, isTrue);
    });

    test('without .!toDateTime identifier', () {
      final actual = isDateTime('test.!name:something');

      expect(actual, isFalse);
    });

    test('complicated pattern', () {
      final actual = isDateTime('test.!name:something.!toDateTime');

      expect(actual, isTrue);
    });
  });

  group('.resolveOriginalName', () {
    test('with .! identifier', () {
      final actual = resolveOriginalName('test.!name:tests');

      expect(actual, 'test');
    });

    test('without .! identifier', () {
      final actual = resolveOriginalName('test');

      expect(actual, 'test');
    });

    test('complicated pattern', () {
      final actual = resolveOriginalName('test.!as:tests.!name:tes');

      expect(actual, 'test');
    });
  });

  group('.resolveFileName', () {
    test('with .!as: identifier', () {
      final actual = resolveFileName('test.!as:tests');

      expect(actual, 'tests');
    });

    test('without .!as: identifier', () {
      final actual = resolveFileName('test.!name:tests');

      expect(actual, 'test');
    });

    test('complicated pattern', () {
      final actual = resolveFileName('test.!as:tests.!name:tes');

      expect(actual, 'tests');
    });
  });

  group('.resolveFieldName', () {
    test('with .!name: identifier', () {
      final actual = resolveFieldName('test.!name:tests');

      expect(actual, 'tests');
    });

    test('without .!name: identifier', () {
      final actual = resolveFieldName('test.!as:tests');

      expect(actual, 'test');
    });

    test('complicated pattern', () {
      final actual = resolveFieldName('test.!as:tests.!name:tes');

      expect(actual, 'tes');
    });
  });

  group('.isDartdoc', () {
    test('with dartdoc identifier for field', () {
      final actual = isDartdoc('\$test');

      expect(actual, isTrue);
    });

    test('with dartdoc identifier for class', () {
      final actual = isDartdoc('\$\$test');

      expect(actual, isTrue);
    });

    test('without dartdoc identifier', () {
      final actual = isDartdoc('test');

      expect(actual, isFalse);
    });
  });
}
