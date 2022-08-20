// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'exception/freezer_exception.dart';
import 'model/dart_object.dart';
import 'model/freezed_parameter.dart';
import 'model/import_package.dart';
import 'model/object_type.dart';
import 'policy/freezer_identifier.dart' as identifier;

class FreezedObjectParser {
  const FreezedObjectParser(
    this.filePath,
    this.root,
    this.mappedEnumObjects,
  );

  /// The path of design file
  final String filePath;

  /// The root of model designs
  final Map<String, dynamic> root;

  final List<DartObject> mappedEnumObjects;

  List<DartObject> execute() {
    final objects = <DartObject>[];

    if (mappedEnumObjects.isNotEmpty) {
      objects.addAll(mappedEnumObjects);
    }

    for (final String fieldName in root.keys) {
      if (identifier.isDartdoc(fieldName)) {
        //! Ignore dartdoc field.
        continue;
      }

      if (fieldName.isEmpty) {
        throw FreezerException('Class name is required.');
      }

      objects.addAll(
        _analyzeFreezedObjectsRecursively(
          filePath: filePath,
          fileName: fieldName,
          classDartDoc: root['\$\$$fieldName'] ?? '',
          fields: root[fieldName],
        ),
      );
    }

    return objects;
  }

  List<DartObject> _analyzeFreezedObjectsRecursively({
    required String filePath,
    required String fileName,
    required String classDartDoc,
    required dynamic fields,
  }) {
    final importPackages = <ImportPackage>[];
    final parameters = <FreezedParameter>[];

    final objects = <DartObject>[];

    for (final String fieldName in fields.keys) {
      if (identifier.isDartdoc(fieldName)) {
        //! Ignore dartdoc field.
        continue;
      }

      if (fieldName.isEmpty) {
        throw FreezerException('Field name is required.');
      }

      if (_isMappedAsEnum(identifier.resolveFileName(fieldName))) {
        final parameter = FreezedParameter.resolveFrom(
          fields['\$${identifier.resolveOriginalName(fieldName)}'] ?? '',
          fieldName,
          null,
        );

        parameters.add(parameter);
        importPackages.add(ImportPackage.resolveFrom(fieldName));
      } else {
        final fieldValue = fields[fieldName];

        final parameter = FreezedParameter.resolveFrom(
          fields['\$${identifier.resolveOriginalName(fieldName)}'] ?? '',
          fieldName,
          fieldValue,
        );

        parameters.add(parameter);

        if (parameter.isNested) {
          //! If this object has nested,
          //! import of dependent child objects must be added.
          importPackages.add(ImportPackage.resolveFrom(fieldName));

          objects.addAll(_analyzeFreezedObjectsRecursively(
            filePath: filePath,
            fileName: fieldName,
            classDartDoc:
                fields['\$\$${identifier.resolveOriginalName(fieldName)}'] ??
                    '',
            fields: fieldValue is List ? fieldValue.first : fieldValue,
          ));
        }
      }
    }

    objects.add(DartObject.resolveFrom(
      ObjectType.freezed,
      filePath,
      fileName,
      classDartDoc,
      importPackages,
      parameters,
    ));

    return objects;
  }

  bool _isMappedAsEnum(final String fieldName) {
    for (final enumObject in mappedEnumObjects) {
      if (fieldName == enumObject.fileName) {
        return true;
      }
    }

    return false;
  }
}
