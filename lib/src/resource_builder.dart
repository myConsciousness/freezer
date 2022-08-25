// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'extension/string_buffer_extension.dart';
import 'model/dart_object.dart';
import 'model/enum_element.dart';
import 'model/freezed_parameter.dart';
import 'model/import_package.dart';

abstract class ResourceBuilder {
  factory ResourceBuilder.forFreezed(DartObject freezedObject) =>
      _FreezedResourceBuilder(freezedObject);

  factory ResourceBuilder.forEnum(DartObject enumObject) =>
      _EnumResourceBuilder(enumObject);

  String execute();
}

class _FreezedResourceBuilder implements ResourceBuilder {
  _FreezedResourceBuilder(this.freezedObject);

  /// The freezed object to be generated
  final DartObject freezedObject;

  @override
  String execute() {
    final fileName = freezedObject.fileName;
    final className = freezedObject.className;
    final elements = freezedObject.elements as List<FreezedParameter>;

    final constructorParameters = _resolveConstructorParameters(elements);

    return '''
// GENERATED CODE - DO NOT MODIFY BY HAND
${_resolveIgnoreErrorComment(elements)}

import 'package:freezed_annotation/freezed_annotation.dart';

${_resolveImportPackages(freezedObject.imports)}

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
''';
  }

  String _resolveIgnoreErrorComment(final List<FreezedParameter> parameters) {
    for (final parameter in parameters) {
      if (parameter.hasAnnotation) {
        return '// ignore_for_file: invalid_annotation_target';
      }
    }

    return '';
  }

  String _resolveClassDartDoc(final DartObject freezedObject) {
    if (freezedObject.hasDartDoc) {
      final buffer = StringBuffer();
      buffer.writeDartDoc(freezedObject.dartDoc);

      return buffer.toString();
    }

    return '';
  }

  String _resolveImportPackages(final List<Import> imports) {
    imports.sort(((a, b) => a.name.compareTo(b.name)));

    return imports.map((package) {
      if (package.hasPath) {
        if (package.path!.endsWith('/')) {
          return "import '${package.path}${package.name}.dart';";
        }

        return "import '${package.path}/${package.name}.dart';";
      }

      return "import '${package.name}.dart';";
    }).join();
  }

  String _resolveConstructorParameters(
    final List<FreezedParameter> parameters,
  ) =>
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

class _EnumResourceBuilder implements ResourceBuilder {
  _EnumResourceBuilder(this.enumObject);

  /// The enum object to be generated
  final DartObject enumObject;

  @override
  String execute() {
    final className = enumObject.className;
    final elements = enumObject.elements as List<EnumElement>;

    return '''
// GENERATED CODE - DO NOT MODIFY BY HAND

${_resolveImportPackages(elements.first)}

// **************************************************************************
// FreezerGenerator
// **************************************************************************

${_resolveClassDartDoc(enumObject)}
enum $className {
  ${_resolveEnumElements(className, elements)}
}
''';
  }

  String _resolveImportPackages(final EnumElement element) =>
      element.hasAnnotation
          ? "import 'package:freezed_annotation/freezed_annotation.dart';"
          : '';

  String _resolveClassDartDoc(final DartObject enumObject) {
    if (enumObject.hasDartDoc) {
      final buffer = StringBuffer();
      buffer.writeDartDoc(enumObject.dartDoc);

      return buffer.toString();
    }

    return '';
  }

  String _resolveEnumElements(
    final String className,
    final List<EnumElement> elements,
  ) {
    final buffer = StringBuffer();

    for (int i = 0; i < elements.length; i++) {
      final element = elements[i];

      if (element.hasDartDoc) {
        buffer.writeDartDoc(element.dartDoc);
        buffer.writeln();
      }

      if (element.hasAnnotation) {
        buffer.writeln(element.annotation);
      }

      buffer.write(element.name);

      if (element.hasValue) {
        buffer.write('(${_resolveEnumElementValue(element.value)})');
      }

      if (i == elements.length - 1) {
        if (element.hasValue) {
          buffer.writeln(';');
          buffer.writeln();

          buffer.writeln('/// The value of this enum element.');

          final fieldName = _resolveFieldName();

          buffer.writeln(
              'final ${element.value.runtimeType.toString()} $fieldName;');
          buffer.writeln();

          buffer.write('const $className(this.$fieldName);');
        } else {
          buffer.writeln(',');
        }
      } else {
        buffer.writeln(',');
      }
    }

    return buffer.toString();
  }

  String _resolveEnumElementValue(final dynamic value) {
    if (value is String) {
      return "'$value'";
    }

    return value.toString();
  }

  String _resolveFieldName() {
    if (enumObject.hasFieldName) {
      return enumObject.fieldName;
    }

    return 'value';
  }
}
