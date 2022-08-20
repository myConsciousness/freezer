// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'exception/freezer_exception.dart';
import 'model/dart_object.dart';
import 'model/enum_element.dart';
import 'model/object_type.dart';
import 'policy/freezer_identifier.dart' as identifier;

class EnumObjectParser {
  const EnumObjectParser(
    this.filePath,
    this.root,
  );

  /// The path of design file
  final String filePath;

  /// The root of enum designs
  final Map<String, dynamic> root;

  List<DartObject> execute() {
    final objects = <DartObject>[];

    for (final fileName in root.keys) {
      if (identifier.isDartdoc(fileName)) {
        //! Ignore dartdoc field.
        continue;
      }

      final value = root[fileName];

      final elements = <EnumElement>[];
      for (final element in value) {
        if (element is Map) {
          elements.add(
            EnumElement.resolveFrom(
              element['\$'],
              element['name'],
              element['value'],
            ),
          );
        } else if (element is String) {
          elements.add(
            EnumElement.resolveFrom('', element, null),
          );
        } else {
          throw FreezerException(
            'Invalid enum structure is detected in "$fileName".',
          );
        }
      }

      objects.add(
        DartObject.resolveFrom(
          ObjectType.enumeration,
          filePath,
          fileName,
          root['\$\$$fileName'] ?? '',
          [],
          elements,
        ),
      );
    }

    return objects;
  }
}
