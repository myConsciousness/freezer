// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'package:dart_style/dart_style.dart';

import 'extension/string_buffer_extension.dart';
import 'model/freezed_object.dart';
import 'model/import_package.dart';
import 'model/parameter.dart';

abstract class FreezedResource {
  factory FreezedResource(FreezedObject freezedObject) =>
      _FreezedResource(freezedObject);

  String build();
}

class _FreezedResource implements FreezedResource {
  _FreezedResource(this.freezedObject);

  /// The freezed object to be generated
  final FreezedObject freezedObject;

  /// The formatter for the generated Dart code.
  final _dartFormatter = DartFormatter();

  @override
  String build() {
    final fileName = freezedObject.fileName;
    final className = freezedObject.className;

    final constructorParameters =
        _resolveConstructorParameters(freezedObject.parameters);

    return _dartFormatter.format(
      '''
// GENERATED CODE - DO NOT MODIFY BY HAND
${_resolveIgnoreErrorComment(freezedObject.parameters)}

import 'package:freezed_annotation/freezed_annotation.dart';

${_resolveImportPackages(freezedObject.importPackages)}

part '$fileName.freezed.dart';
part '$fileName.g.dart';

// **************************************************************************
// FreezerGenerator
// **************************************************************************

${_resolveClassDartDoc(freezedObject)}
@freezed
class $className with _\$$className {
  const factory $className({
    $constructorParameters
  }) = _$className;

  /// Returns [$className] based on [json].
  factory $className.fromJson(Map<String, Object?> json) =>
      _\$${className}FromJson(json);
}
''',
    );
  }

  String _resolveIgnoreErrorComment(final List<Parameter> parameters) {
    for (final parameter in parameters) {
      if (parameter.hasAnnotation) {
        return '// ignore_for_file: invalid_annotation_target';
      }
    }

    return '';
  }

  String _resolveClassDartDoc(final FreezedObject freezedObject) {
    if (freezedObject.hasDartDoc) {
      final buffer = StringBuffer();
      buffer.writeDartDoc(freezedObject.dartDoc);

      return buffer.toString();
    }

    return '';
  }

  String _resolveImportPackages(
    final List<ImportPackage> importPackages,
  ) =>
      importPackages.map((package) => "import '${package.name}.dart';").join();

  String _resolveConstructorParameters(final List<Parameter> parameters) =>
      parameters.map((parameter) {
        final buffer = StringBuffer();

        if (parameter.hasDartDoc) {
          buffer.writeDartDoc(parameter.dartDoc);
          buffer.writeln();
        }

        if (parameter.hasAnnotation) {
          buffer.write(parameter.annotation);
          buffer.write(' ');
        }

        if (parameter.isRequired) {
          buffer.write('required');
          buffer.write(' ');
        }

        buffer.write(parameter.type);

        if (parameter.hasTypeVariable) {
          buffer.write(parameter.typeVariable);
        }

        if (!parameter.isRequired) {
          //! Make it nullable
          buffer.write('?');
        }

        buffer.write(' ');
        buffer.write(parameter.name);
        buffer.write(',');

        return buffer.toString();
      }).join();
}
