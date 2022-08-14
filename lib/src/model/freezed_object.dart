// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

import '../extension/string_extension.dart';
import '../freezer_identifier.dart';
import 'import_package.dart';
import 'parameter.dart';

class FreezedObject {
  const FreezedObject._(
    this.path,
    this.fileName,
    this.className,
    this.importPackages,
    this.parameters,
  );

  factory FreezedObject.resolveFrom(
    final String path,
    final String fileName,
    final List<ImportPackage> importPackages,
    final List<Parameter> parameters,
  ) {
    final alias = FreezerIdentifier.resolveAliasName(fileName);

    return FreezedObject._(
      _getOutputPath(path),
      alias.toSnakeCase(),
      alias.toUpperCamelCase(),
      importPackages,
      parameters,
    );
  }

  /// The path of the file.
  final String path;

  /// The file name
  final String fileName;

  /// The class name
  final String className;

  /// The import packages
  final List<ImportPackage> importPackages;

  /// The constructor parameters
  final List<Parameter> parameters;

  static String _getOutputPath(final String filePath) {
    return filePath
        .replaceFirst('/design', '/lib')
        .substring(0, filePath.lastIndexOf('/') - 3);
  }
}
