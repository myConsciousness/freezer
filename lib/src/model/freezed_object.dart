// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import '../extension/string_extension.dart';
import '../freezer_identifier.dart' as identifier;
import 'dart_doc.dart';
import 'import_package.dart';
import 'parameter.dart';

class FreezedObject {
  const FreezedObject._({
    required this.path,
    required this.fileName,
    required this.dartDoc,
    required this.className,
    required this.importPackages,
    required this.parameters,
  });

  factory FreezedObject.resolveFrom(
    final String path,
    final String fileName,
    final String dartDoc,
    final List<ImportPackage> importPackages,
    final List<Parameter> parameters,
  ) {
    final aliasFileName = identifier.resolveFileName(fileName);

    return FreezedObject._(
      path: _getOutputPath(path),
      fileName: aliasFileName.toSnakeCase(),
      dartDoc: DartDoc.resolveFrom(dartDoc),
      className: aliasFileName.toUpperCamelCase(),
      importPackages: importPackages,
      parameters: parameters,
    );
  }

  /// The path of the file.
  final String path;

  /// The file name
  final String fileName;

  /// The dart document
  final DartDoc dartDoc;

  /// The class name
  final String className;

  /// The import packages
  final List<ImportPackage> importPackages;

  /// The constructor parameters
  final List<Parameter> parameters;

  bool get hasDartDoc => dartDoc.lines.isNotEmpty;

  static String _getOutputPath(final String filePath) {
    return filePath
        .replaceFirst('/design', '/lib')
        .substring(0, filePath.lastIndexOf('/') - 3);
  }
}
