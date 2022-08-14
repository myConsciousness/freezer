// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'exception/freezer_exception.dart';
import 'model/freezed_object.dart';
import 'model/import_package.dart';
import 'model/parameter.dart';

class FreezedObjectParser {
  const FreezedObjectParser(
    this.filePath,
    this.root,
  );

  /// The path of design file
  final String filePath;

  /// The root of model designs
  final Map<String, dynamic> root;

  List<FreezedObject> execute() {
    final freezedObjects = <FreezedObject>[];

    for (final String fieldName in root.keys) {
      if (fieldName.isEmpty) {
        throw FreezerException('Class name is required.');
      }

      _analyzeFreezedObjectsRecursively(
        filePath,
        fieldName,
        root[fieldName],
        freezedObjects,
      );
    }

    return freezedObjects;
  }

  void _analyzeFreezedObjectsRecursively(
    final String filePath,
    final String fileName,
    final dynamic fields,
    final List<FreezedObject> freezedObjects,
  ) {
    final importPackages = <ImportPackage>[];
    final parameters = <Parameter>[];

    for (final String fieldName in fields.keys) {
      if (fieldName.isEmpty) {
        throw FreezerException('Field name is required.');
      }

      final fieldValue = fields[fieldName];

      final parameter = Parameter.resolveFrom(fieldName, fieldValue);
      parameters.add(parameter);

      if (parameter.isNested) {
        //! If this object has nested,
        //! import of dependent child objects must be added.
        importPackages.add(ImportPackage.resolveFrom(fieldName));

        _analyzeFreezedObjectsRecursively(
          filePath,
          fieldName,
          fieldValue is List ? fieldValue.first : fieldValue,
          freezedObjects,
        );
      }
    }

    freezedObjects.add(
      FreezedObject.resolveFrom(
        filePath,
        fileName,
        importPackages,
        parameters,
      ),
    );
  }
}
