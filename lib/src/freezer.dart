// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

import 'dart:convert';
import 'dart:io';

import 'build_runner.dart';
import 'exception/freezer_exception.dart';
import 'extension/string_extension.dart';
import 'field.dart';
import 'files.dart';
import 'freezed_file.dart';
import 'freezed_resource.dart';

class Freezer {
  final _generatedFileNames = <String>[];

  Future<void> run() async {
    final stopwatch = Stopwatch();
    stopwatch.start();

    final designFiles = findDesignFiles(Directory.current.path);

    if (designFiles.isEmpty) {
      throw FreezerException('No design files to be freezed found.');
    }

    stdout.write('Started process for ${designFiles.length} files\n\n');

    for (final filePath in designFiles.keys) {
      _buildFreezedResources(
        filePath,
        jsonDecode(designFiles[filePath]!.readAsStringSync()),
      );
    }

    // Generate .freezed.dart and .g.dart files.
    await BuildRunner().run();

    stopwatch.stop();

    _printResult(stopwatch);
  }

  void _buildFreezedResources(
    final String filePath,
    final dynamic root,
  ) {
    for (final String fieldName in root.keys) {
      if (fieldName.isEmpty) {
        throw FreezerException('Class name is required.');
      }

      _buildFreezedResourceRecursively(
        filePath,
        fieldName,
        root[fieldName],
      );
    }
  }

  void _buildFreezedResourceRecursively(
    final String filePath,
    final String fileName,
    final dynamic fields,
  ) {
    final parsedFields = <Field>[];
    final imports = <String>[];

    for (final String fieldName in fields.keys) {
      if (fieldName.isEmpty) {
        throw FreezerException('Field name is required.');
      }

      final fieldValue = fields[fieldName];

      if (fieldValue is List || fieldValue is Map) {
        _buildFreezedResourceRecursively(
          filePath,
          fieldName,
          //! In the case of a List, the object structure
          //! at the top is interpreted.
          fieldValue is List ? fieldValue.first : fieldValue,
        );
      }

      if (fieldValue is List || fieldValue is Map) {
        imports.add(fieldName);

        parsedFields.add(
          Field(
            fieldName,
            fieldValue is List
                ? 'List<${fieldName.toUpperCamelCase()}>'
                : fieldName.toUpperCamelCase(),
          ),
        );
      } else {
        parsedFields.add(
          Field(fieldName, fieldValue.runtimeType.toString()),
        );
      }
    }

    final outputDirectory = _getOutputPath(filePath);

    FreezedFile(outputDirectory, fileName).write(
      FreezedResource(imports, fileName, parsedFields),
    );

    _generatedFileNames
      ..add('$outputDirectory/$fileName.dart')
      ..add('$outputDirectory/$fileName.freezed.dart')
      ..add('$outputDirectory/$fileName.g.dart');
  }

  String _getOutputPath(final String filePath) {
    final basePath =
        filePath.substring(0, filePath.indexOf('/design/') + '/design/'.length);

    return basePath.replaceFirst('design', 'lib');
  }

  void _printResult(final Stopwatch stopwatch) {
    stdout.write('\n');
    stdout.write('┏━━ Generated dart files\n');

    for (final name in _generatedFileNames) {
      stdout.write('┣ ✔ $name\n');
    }

    stdout.write('┗━━ ${_generatedFileNames.length} files in '
        '${stopwatch.elapsed.inSeconds}.${stopwatch.elapsedMilliseconds} '
        'seconds\n\n');
  }
}
