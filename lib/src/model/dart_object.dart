// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import '../extension/string_extension.dart';
import '../policy/freezer_identifier.dart' as identifier;
import 'dart_doc.dart';
import 'import_package.dart';
import 'object_type.dart';

class DartObject<E> {
  DartObject._({
    required this.type,
    required this.path,
    required this.fileName,
    required this.dartDoc,
    required this.className,
    required this.imports,
    required this.elements,
  });

  factory DartObject.resolveFrom(
    final ObjectType type,
    final String path,
    final String fileName,
    final String dartDoc,
    final List<Import> imports,
    final List<E> elements,
  ) {
    final aliasFileName = identifier.resolveFileName(fileName);

    return DartObject._(
      type: type,
      path: _resolveOutputPath(path),
      fileName: aliasFileName.toSnakeCase(),
      dartDoc: DartDoc.resolveFrom(dartDoc),
      className: aliasFileName.toUpperCamelCase(),
      imports: imports,
      elements: elements,
    );
  }

  final ObjectType type;

  final String path;

  final String fileName;

  final DartDoc dartDoc;

  final String className;

  final List<Import> imports;

  final List<E> elements;

  bool get hasDartDoc => dartDoc.lines.isNotEmpty;

  static String _resolveOutputPath(final String filePath) {
    return filePath
        .replaceFirst('/design', '/lib')
        .substring(0, filePath.lastIndexOf('/') - 3);
  }
}
