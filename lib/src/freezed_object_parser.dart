// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'exception/freezer_exception.dart';
import 'model/dart_object.dart';
import 'model/freezed_parameter.dart';
import 'model/import_package.dart';
import 'model/object_type.dart';
import 'model/reference.dart';
import 'policy/freezer_identifier.dart' as identifier;

class FreezedObjectParser {
  const FreezedObjectParser(
    this.filePath,
    this.root,
    this.enumObjects,
    this.references,
  );

  /// The path of design file
  final String filePath;

  /// The root of model designs
  final Map<String, dynamic> root;

  /// The mapped Enum objects
  final List<DartObject> enumObjects;

  /// The references for external objects
  final List<Reference> references;

  List<DartObject> execute() {
    final objects = <DartObject>[];

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
    if (_isReference(fileName)) {
      //! Referenced object is resolved in external directory.
      return [];
    }

    final imports = <Import>[];
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

      _resolveElements(fields, fieldName, imports, parameters, objects);
    }

    return objects
      ..add(DartObject.resolveFrom(
        ObjectType.freezed,
        filePath,
        fileName,
        classDartDoc,
        imports,
        parameters,
      ));
  }

  void _resolveElements(
    final dynamic fields,
    final String fieldName,
    final List<Import> imports,
    final List<FreezedParameter> parameters,
    final List<DartObject> objects,
  ) {
    if (_isEnum(fieldName)) {
      _resolveEnumElements(fields, fieldName, imports, parameters);
      return;
    }

    _resolveFreezedElements(fields, fieldName, imports, parameters, objects);
  }

  void _resolveEnumElements(
    final dynamic fields,
    final String fieldName,
    final List<Import> imports,
    final List<FreezedParameter> parameters,
  ) {
    parameters.add(FreezedParameter.resolveFrom(
      fields['\$${identifier.resolveOriginalName(fieldName)}'] ?? '',
      fieldName,
      null,
    ));

    final reference = _getReference(fieldName);

    imports.add(
      reference != null
          ? Import.fromExternal(reference)
          : Import.fromCurrent(fieldName),
    );
  }

  void _resolveFreezedElements(
    final dynamic fields,
    final String fieldName,
    final List<Import> imports,
    final List<FreezedParameter> parameters,
    final List<DartObject> objects,
  ) {
    final fieldValue = fields[fieldName];

    final parameter = FreezedParameter.resolveFrom(
      fields['\$${identifier.resolveOriginalName(fieldName)}'] ?? '',
      fieldName,
      fieldValue,
    );

    parameters.add(parameter);

    if (parameter.isNested) {
      final reference = _getReference(fieldName);

      imports.add(
        reference != null
            ? Import.fromExternal(reference)
            : Import.fromCurrent(fieldName),
      );

      final nestedObjects = _analyzeFreezedObjectsRecursively(
        filePath: filePath,
        fileName: fieldName,
        classDartDoc:
            fields['\$\$${identifier.resolveOriginalName(fieldName)}'] ?? '',
        fields: fieldValue is List ? fieldValue.first : fieldValue,
      );

      if (nestedObjects.isNotEmpty) {
        objects.addAll(nestedObjects);
      }
    }
  }

  bool _isEnum(final String fieldName) {
    final fileName = identifier.resolveFileName(fieldName);

    for (final enumObject in enumObjects) {
      if (fileName == enumObject.fileName) {
        return true;
      }
    }

    return false;
  }

  bool _isReference(final String fieldName) {
    final fileName = identifier.resolveFileName(fieldName);

    for (final reference in references) {
      if (fileName == reference.name) {
        return true;
      }
    }

    return false;
  }

  Reference? _getReference(final String fieldName) {
    final fileName = identifier.resolveFileName(fieldName);

    for (final reference in references) {
      if (fileName == reference.name) {
        return reference;
      }
    }

    return null;
  }
}
