// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import '../extension/string_extension.dart';
import '../policy/freezer_identifier.dart' as identifier;
import 'dart_doc.dart';

class FreezedParameter {
  const FreezedParameter._({
    required this.dartDoc,
    required this.isRequired,
    required this.name,
    required this.type,
    required bool nested,
    this.typeVariable,
    this.annotation,
  }) : _nested = nested;

  factory FreezedParameter.resolveFrom(
    final String dartDoc,
    final String key,
    final dynamic value,
  ) {
    final fileName = identifier.resolveFileName(key);
    final fieldName = identifier.resolveFieldName(key);
    final annotation = _getJsonKeyAnnotation(key);

    //! For Enum types.
    if (value == null) {
      return FreezedParameter._(
        dartDoc: DartDoc.resolveFrom(dartDoc),
        isRequired: identifier.isRequired(key),
        name: fieldName.toCamelCase(),
        type: fileName.toUpperCamelCase(),
        nested: false,
        annotation: annotation,
      );
    }

    if (_isCollection(value)) {
      final nested = _isNested(value);

      return FreezedParameter._(
        dartDoc: DartDoc.resolveFrom(dartDoc),
        isRequired: identifier.isRequired(key),
        name: fieldName.toCamelCase(),
        type: _isList(value) ? 'List' : fileName.toUpperCamelCase(),
        typeVariable: _isList(value) && nested
            ? '<${fileName.toUpperCamelCase()}>'
            : _isList(value)
                ? '<${value.first.runtimeType.toString()}>'
                : '',
        nested: nested,
        annotation: annotation,
      );
    }

    //! For standard types
    return FreezedParameter._(
      dartDoc: DartDoc.resolveFrom(dartDoc),
      isRequired: identifier.isRequired(key),
      name: fieldName.toCamelCase(),
      type: identifier.isDateTime(key)
          ? 'DateTime'
          : value.runtimeType.toString(),
      nested: false,
      annotation: annotation,
    );
  }

  /// The dartdoc for this field
  final DartDoc dartDoc;

  /// The flag represents this element is required or not
  final bool isRequired;

  /// The name
  final String name;

  /// The type
  final String type;

  /// The type variable
  final String? typeVariable;

  /// The annotation
  final String? annotation;

  final bool _nested;

  bool get hasTypeVariable => typeVariable != null;

  bool get hasAnnotation => annotation != null;

  bool get isNested => _nested;

  bool get hasDartDoc => dartDoc.lines.isNotEmpty;

  static String? _getJsonKeyAnnotation(final String key) {
    if (identifier.hasAliasFieldName(key)) {
      return "@JsonKey(name: '${identifier.resolveOriginalName(key)}')";
    }

    return null;
  }

  static bool _isCollection(final dynamic value) =>
      value is List || value is Map;

  static bool _isList(final dynamic value) => value is List;

  static bool _isNested(final dynamic collection) {
    if (collection is Map) {
      return true;
    }

    if (collection is List) {
      return collection[0] is Map<String, dynamic>;
    }

    return false;
  }
}
