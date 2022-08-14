// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import '../extension/string_extension.dart';
import '../freezer_identifier.dart';

class Parameter {
  const Parameter._({
    required this.isRequired,
    required this.name,
    required this.type,
    required bool nested,
    this.typeVariable,
    this.annotation,
  }) : _nested = nested;

  factory Parameter.resolveFrom(final String key, final dynamic value) {
    final alias = FreezerIdentifier.resolveAliasName(key);
    final annotation = _getJsonKeyAnnotation(key);

    if (value is List) {
      return Parameter._(
        isRequired: _isRequired(key),
        name: alias.toCamelCase(),
        type: 'List',
        typeVariable: '<${alias.toUpperCamelCase()}>',
        nested: true,
        annotation: annotation,
      );
    } else if (value is Map) {
      return Parameter._(
        isRequired: _isRequired(key),
        name: alias.toCamelCase(),
        type: alias.toUpperCamelCase(),
        nested: true,
        annotation: annotation,
      );
    }

    //! For standard types
    return Parameter._(
      isRequired: _isRequired(key),
      name: alias.toCamelCase(),
      type: value.runtimeType.toString(),
      nested: false,
      annotation: annotation,
    );
  }

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

  static bool _isRequired(final String token) => token.contains('.!required');

  static String _getJsonKeyAnnotation(final String key) {
    if (key.contains('.!as:')) {
      return "@JsonKey(name: '${FreezerIdentifier.resolveOriginalName(key)}')";
    }

    return '';
  }
}
