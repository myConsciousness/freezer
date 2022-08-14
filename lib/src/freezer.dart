// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

import 'dart:convert';
import 'dart:io';

import 'build_runner.dart';
import 'exception/freezer_exception.dart';
import 'file_utils.dart' as file;
import 'freezed_file.dart';
import 'freezed_object_parser.dart';

class Freezer {
  final _generatedFileNames = <String>[];

  Future<void> run() async {
    final stopwatch = Stopwatch();
    stopwatch.start();

    final designFiles = file.findDesignFiles(Directory.current.path);

    if (designFiles.isEmpty) {
      throw FreezerException('No design files to be freezed found.');
    }

    stdout.write('Started process for ${designFiles.length} files\n\n');

    for (final filePath in designFiles.keys) {
      _createFreezedResources(
        filePath,
        jsonDecode(designFiles[filePath]!.readAsStringSync()),
      );
    }

    // Generate .freezed.dart and .g.dart files.
    await BuildRunner().run();

    stopwatch.stop();

    _printResult(stopwatch);
  }

  void _createFreezedResources(
    final String filePath,
    final dynamic root,
  ) {
    final freezedObjects = FreezedObjectParser(
      filePath,
      root['models'] ?? root,
    ).execute();

    for (final freezedObject in freezedObjects) {
      FreezedFile.create(
        freezedObject.path,
        freezedObject.fileName,
      ).write(freezedObject);

      _generatedFileNames
        ..add('${freezedObject.path}/${freezedObject.fileName}.dart')
        ..add('${freezedObject.path}/${freezedObject.fileName}.freezed.dart')
        ..add('${freezedObject.path}/${freezedObject.fileName}.g.dart');
    }
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
