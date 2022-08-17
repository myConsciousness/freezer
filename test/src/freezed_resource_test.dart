// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

import 'package:freezer/src/freezed_resource.dart';
import 'package:freezer/src/model/freezed_object.dart';
import 'package:freezer/src/model/import_package.dart';
import 'package:freezer/src/model/parameter.dart';
import 'package:test/test.dart';

void main() {
  group('.build', () {
    test('normal case', () {
      final object = FreezedObject.resolveFrom(
        'design/src',
        'test',
        '',
        [],
        [Parameter.resolveFrom('', 'param', 1)],
      );

      final actual = FreezedResource(object).build();

      expect(actual, '''
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

part 'test.freezed.dart';
part 'test.g.dart';

// **************************************************************************
// FreezerGenerator
// **************************************************************************

@freezed
class Test with _\$Test {
  const factory Test({
    int? param,
  }) = _Test;

  /// Returns [Test] based on [json].
  factory Test.fromJson(Map<String, Object?> json) => _\$TestFromJson(json);
}
''');
    });

    test('with List parameter and import', () {
      final object = FreezedObject.resolveFrom(
        'design/src',
        'test',
        '',
        [ImportPackage.resolveFrom('params.!as:param')],
        [
          Parameter.resolveFrom('', 'params.!as:param', [
            {'name': 'something'}
          ])
        ],
      );

      final actual = FreezedResource(object).build();

      expect(actual, '''
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'param.dart';

part 'test.freezed.dart';
part 'test.g.dart';

// **************************************************************************
// FreezerGenerator
// **************************************************************************

@freezed
class Test with _\$Test {
  const factory Test({
    List<Param>? params,
  }) = _Test;

  /// Returns [Test] based on [json].
  factory Test.fromJson(Map<String, Object?> json) => _\$TestFromJson(json);
}
''');
    });

    test('with Map parameter and import', () {
      final object = FreezedObject.resolveFrom(
        'design/src',
        'test',
        '',
        [ImportPackage.resolveFrom('param')],
        [
          Parameter.resolveFrom('', 'param', {'name': 'something'})
        ],
      );

      final actual = FreezedResource(object).build();

      expect(actual, '''
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'param.dart';

part 'test.freezed.dart';
part 'test.g.dart';

// **************************************************************************
// FreezerGenerator
// **************************************************************************

@freezed
class Test with _\$Test {
  const factory Test({
    Param? param,
  }) = _Test;

  /// Returns [Test] based on [json].
  factory Test.fromJson(Map<String, Object?> json) => _\$TestFromJson(json);
}
''');
    });

    test('with field alias', () {
      final object = FreezedObject.resolveFrom(
        'design/src',
        'test',
        '',
        [ImportPackage.resolveFrom('param.!name:my_param')],
        [
          Parameter.resolveFrom(
            '',
            'param.!name:my_param',
            {'name': 'something'},
          )
        ],
      );

      final actual = FreezedResource(object).build();

      expect(actual, '''
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'param.dart';

part 'test.freezed.dart';
part 'test.g.dart';

// **************************************************************************
// FreezerGenerator
// **************************************************************************

@freezed
class Test with _\$Test {
  const factory Test({
    @JsonKey(name: 'param') Param? myParam,
  }) = _Test;

  /// Returns [Test] based on [json].
  factory Test.fromJson(Map<String, Object?> json) => _\$TestFromJson(json);
}
''');
    });

    test('with dartdoc for class', () {
      final object = FreezedObject.resolveFrom(
        'design/src',
        'test',
        'Test description.',
        [ImportPackage.resolveFrom('param')],
        [
          Parameter.resolveFrom(
            '',
            'param',
            {'name': 'something'},
          )
        ],
      );

      final actual = FreezedResource(object).build();

      expect(actual, '''
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'param.dart';

part 'test.freezed.dart';
part 'test.g.dart';

// **************************************************************************
// FreezerGenerator
// **************************************************************************

/// Test description.
@freezed
class Test with _\$Test {
  const factory Test({
    Param? param,
  }) = _Test;

  /// Returns [Test] based on [json].
  factory Test.fromJson(Map<String, Object?> json) => _\$TestFromJson(json);
}
''');
    });

    test('with dartdoc for field', () {
      final object = FreezedObject.resolveFrom(
        'design/src',
        'test',
        '',
        [ImportPackage.resolveFrom('param')],
        [
          Parameter.resolveFrom(
            'Test description.',
            'param',
            {'name': 'something'},
          )
        ],
      );

      final actual = FreezedResource(object).build();

      expect(actual, '''
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'param.dart';

part 'test.freezed.dart';
part 'test.g.dart';

// **************************************************************************
// FreezerGenerator
// **************************************************************************

@freezed
class Test with _\$Test {
  const factory Test({
    /// Test description.
    Param? param,
  }) = _Test;

  /// Returns [Test] based on [json].
  factory Test.fromJson(Map<String, Object?> json) => _\$TestFromJson(json);
}
''');
    });

    test('with dartdoc for class and field', () {
      final object = FreezedObject.resolveFrom(
        'design/src',
        'test',
        'Test description for class.',
        [ImportPackage.resolveFrom('param')],
        [
          Parameter.resolveFrom(
            'Test description for field.',
            'param',
            {'name': 'something'},
          )
        ],
      );

      final actual = FreezedResource(object).build();

      expect(actual, '''
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'param.dart';

part 'test.freezed.dart';
part 'test.g.dart';

// **************************************************************************
// FreezerGenerator
// **************************************************************************

/// Test description for class.
@freezed
class Test with _\$Test {
  const factory Test({
    /// Test description for field.
    Param? param,
  }) = _Test;

  /// Returns [Test] based on [json].
  factory Test.fromJson(Map<String, Object?> json) => _\$TestFromJson(json);
}
''');
    });

    test('with required identifier', () {
      final object = FreezedObject.resolveFrom(
        'design/src',
        'test',
        '',
        [ImportPackage.resolveFrom('param.!required')],
        [
          Parameter.resolveFrom(
            '',
            'param.!required',
            {'name': 'something'},
          )
        ],
      );

      final actual = FreezedResource(object).build();

      expect(actual, '''
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:freezed_annotation/freezed_annotation.dart';

import 'param.dart';

part 'test.freezed.dart';
part 'test.g.dart';

// **************************************************************************
// FreezerGenerator
// **************************************************************************

@freezed
class Test with _\$Test {
  const factory Test({
    required Param param,
  }) = _Test;

  /// Returns [Test] based on [json].
  factory Test.fromJson(Map<String, Object?> json) => _\$TestFromJson(json);
}
''');
    });
  });
}
