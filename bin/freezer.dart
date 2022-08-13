// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:freezer/src/build_runner.dart';
import 'package:freezer/src/extension/string_extension.dart';

import 'package:freezer/src/files.dart';
import 'package:freezer/src/field.dart';
import 'package:freezer/src/exception/freezer_exception.dart';

import 'package:freezer/src/freezed_file.dart';
import 'package:freezer/src/freezed_resource.dart';

Future<void> main(List<String> args) async {
  final stopwatch = Stopwatch();
  stopwatch.start();

  final designFiles = findDesignFiles(Directory.current.path);

  if (designFiles.isEmpty) {
    throw FreezerException('No design files to be freezed found.');
  }

  stdout.write('Reading ${designFiles.length} freezer files');

  for (final filePath in designFiles.keys) {
    _buildFreezedResources(
      filePath,
      jsonDecode(designFiles[filePath]!.readAsStringSync()),
    );
  }

  // Generate .freezed.dart and .g.dart files.
  await BuildRunner().run();

  stopwatch.stop();

  stdout.write(
      '✔ Generated ${designFiles.length} files in ${stopwatch.elapsed.inSeconds}.${stopwatch.elapsedMilliseconds} seconds\n');
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

  FreezedFile(_getOutputPath(filePath), fileName).write(
    FreezedResource(imports, fileName, parsedFields),
  );
}

String _getOutputPath(final String filePath) {
  final basePath =
      filePath.substring(0, filePath.indexOf('/design/') + '/design/'.length);

  return basePath.replaceFirst('design', 'lib');
}
