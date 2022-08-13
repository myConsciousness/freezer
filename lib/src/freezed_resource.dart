// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

import 'extension/string_extension.dart';

import 'field.dart';

abstract class FreezedResource {
  factory FreezedResource(
    List<String> imports,
    String fileName,
    List<Field> fields,
  ) =>
      _FreezedResource(
        imports,
        fileName,
        fields,
      );

  String build();
}

class _FreezedResource implements FreezedResource {
  const _FreezedResource(
    this.imports,
    this.fileName,
    this.fields,
  );

  final List<String> imports;
  final String fileName;
  final List<Field> fields;

  @override
  String build() {
    final className = fileName.toUpperCamelCase();

    return '''
import 'package:freezed_annotation/freezed_annotation.dart';

${_buildImportPackages(imports)}

part '$fileName.freezed.dart';
part '$fileName.g.dart';

@freezed
class $className with _\$$className {
  const factory $className({
    ${_buildConstructorParameters(fields)}}
  ) = _$className;

  factory $className.fromJson(Map<String, Object?> json) =>
      _\$${className}FromJson(json);
}
''';
  }

  String _buildImportPackages(
    final List<String> imports,
  ) =>
      imports.map((fileName) => "import '$fileName.dart';").join();

  String _buildConstructorParameters(final List<Field> fields) => fields
      .map((e) => '${_getParameterType(e)} ${_getParameterName(e)},')
      .join();

  String _getParameterType(final Field field) {
    if (!field.name.contains('.!required')) {
      return '${field.type}?';
    }

    return 'required ${field.type}';
  }

  String _getParameterName(final Field field) {
    if (!field.name.contains('.!')) {
      return field.name.toCamelCase();
    }

    return field.name.substring(0, field.name.indexOf('.!')).toCamelCase();
  }
}
