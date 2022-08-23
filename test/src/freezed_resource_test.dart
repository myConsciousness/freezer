// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Package imports:
import 'package:dart_style/dart_style.dart';

// Project imports:
import 'package:freezer/src/model/dart_object.dart';
import 'package:freezer/src/model/freezed_parameter.dart';
import 'package:freezer/src/model/import_package.dart';
import 'package:freezer/src/model/object_type.dart';
import 'package:freezer/src/resource_builder.dart';
import 'package:test/test.dart';

void main() {
  final formatter = DartFormatter();

  group('.build', () {
    test('normal case', () {
      final object = DartObject.resolveFrom(
        ObjectType.freezed,
        'design/src',
        'test',
        '',
        [],
        [FreezedParameter.resolveFrom('', 'param', 1)],
      );

      final actual = formatter.format(
        ResourceBuilder.forFreezed(object).execute(),
      );

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
      final object = DartObject.resolveFrom(
        ObjectType.freezed,
        'design/src',
        'test',
        '',
        [Import.fromCurrent('params.!as:param')],
        [
          FreezedParameter.resolveFrom('', 'params.!as:param', [
            {'name': 'something'}
          ])
        ],
      );

      final actual = formatter.format(
        ResourceBuilder.forFreezed(object).execute(),
      );
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
      final object = DartObject.resolveFrom(
        ObjectType.freezed,
        'design/src',
        'test',
        '',
        [Import.fromCurrent('param')],
        [
          FreezedParameter.resolveFrom('', 'param', {'name': 'something'})
        ],
      );

      final actual = formatter.format(
        ResourceBuilder.forFreezed(object).execute(),
      );

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
      final object = DartObject.resolveFrom(
        ObjectType.freezed,
        'design/src',
        'test',
        '',
        [Import.fromCurrent('param.!name:my_param')],
        [
          FreezedParameter.resolveFrom(
            '',
            'param.!name:my_param',
            {'name': 'something'},
          )
        ],
      );

      final actual = formatter.format(
        ResourceBuilder.forFreezed(object).execute(),
      );

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
      final object = DartObject.resolveFrom(
        ObjectType.freezed,
        'design/src',
        'test',
        'Test description.',
        [Import.fromCurrent('param')],
        [
          FreezedParameter.resolveFrom(
            '',
            'param',
            {'name': 'something'},
          )
        ],
      );

      final actual = formatter.format(
        ResourceBuilder.forFreezed(object).execute(),
      );

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
      final object = DartObject.resolveFrom(
        ObjectType.freezed,
        'design/src',
        'test',
        '',
        [Import.fromCurrent('param')],
        [
          FreezedParameter.resolveFrom(
            'Test description.',
            'param',
            {'name': 'something'},
          )
        ],
      );

      final actual = formatter.format(
        ResourceBuilder.forFreezed(object).execute(),
      );

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
      final object = DartObject.resolveFrom(
        ObjectType.freezed,
        'design/src',
        'test',
        'Test description for class.',
        [Import.fromCurrent('param')],
        [
          FreezedParameter.resolveFrom(
            'Test description for field.',
            'param',
            {'name': 'something'},
          )
        ],
      );

      final actual = formatter.format(
        ResourceBuilder.forFreezed(object).execute(),
      );

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
      final object = DartObject.resolveFrom(
        ObjectType.freezed,
        'design/src',
        'test',
        '',
        [Import.fromCurrent('param.!required')],
        [
          FreezedParameter.resolveFrom(
            '',
            'param.!required',
            {'name': 'something'},
          )
        ],
      );

      final actual = formatter.format(
        ResourceBuilder.forFreezed(object).execute(),
      );

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
