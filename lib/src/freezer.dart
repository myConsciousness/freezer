// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:convert';
import 'dart:io';

// Project imports:
import 'build_runner.dart';
import 'dart_file.dart';
import 'enum_object_parser.dart';
import 'exception/freezer_exception.dart';
import 'freezed_object_parser.dart';
import 'model/dart_object.dart';
import 'model/object_type.dart';
import 'model/reference.dart';

class Freezer {
  final _generatedFileNames = <String>[];

  Future<void> execute() async {
    final stopwatch = Stopwatch();
    stopwatch.start();

    final designFiles = _findDesignFiles(Directory.current.path);

    if (designFiles.isEmpty) {
      throw FreezerException('No design files to be freezed found.');
    }

    stdout.write('Started process for ${designFiles.length} files\n\n');

    final enumObjects = <DartObject>[];
    for (final filePath in designFiles.keys) {
      final root = jsonDecode(
        designFiles[filePath]!.readAsStringSync(),
      );

      enumObjects.addAll(
        _parseEnumObjects(filePath, root),
      );

      _outputDartObjects(
        _parseFreezedObjects(filePath, root, enumObjects),
      );
    }

    // Generate .freezed.dart and .g.dart files.
    await BuildRunner().run();

    stopwatch.stop();

    _printResult(stopwatch);
  }

  List<DartObject> _parseEnumObjects(
    final String filePath,
    final dynamic root,
  ) {
    if (!root.containsKey('enums')) {
      return [];
    }

    final objects = EnumObjectParser(
      filePath,
      root['enums'],
    ).execute();

    return objects;
  }

  List<DartObject> _parseFreezedObjects(
    final String filePath,
    final dynamic root,
    final List<DartObject> enumObjects,
  ) {
    final freezedObjects = FreezedObjectParser(
      filePath,
      root['models'] ?? root,
      enumObjects,
      _parseReferences(root),
    ).execute();

    if (enumObjects.isNotEmpty) {
      freezedObjects.addAll(enumObjects);
    }

    return freezedObjects;
  }

  List<Reference> _parseReferences(final dynamic root) {
    if (!root.containsKey('references')) {
      return [];
    }

    final referenceMap = root['references'] as Map<String, dynamic>;
    final references = <Reference>[];

    for (final name in referenceMap.keys) {
      references.add(
        Reference(name, referenceMap[name]),
      );
    }

    return references;
  }

  void _outputDartObjects(final List<DartObject> objects) {
    for (final object in objects) {
      if (!Directory(object.path).existsSync()) {
        Directory(object.path).createSync(recursive: true);
      }

      DartFile.create(
        object.path,
        object.fileName,
      ).write(object);

      _generatedFileNames.add('${object.path}/${object.fileName}.dart');

      if (object.type == ObjectType.freezed) {
        _generatedFileNames
          ..add('${object.path}/${object.fileName}.freezed.dart')
          ..add('${object.path}/${object.fileName}.g.dart');
      }
    }
  }

  void _printResult(final Stopwatch stopwatch) {
    stdout.write('\n');
    stdout.write('┏━━ Generated dart files\n');

    for (int i = 0; i < _generatedFileNames.length; i++) {
      if (i == _generatedFileNames.length - 1) {
        stdout.write('┃  ┗━━ 🎉 ${_generatedFileNames[i]}\n');
        break;
      }

      stdout.write('┃  ┣━━ 🎉 ${_generatedFileNames[i]}\n');
    }

    stdout.write('┗━━ ${_generatedFileNames.length} files in '
        '${stopwatch.elapsed.inSeconds}.${stopwatch.elapsedMilliseconds} '
        'seconds\n\n');
  }

  Map<String, File> _findDesignFiles(String currentPath) {
    final contents = [
      ..._readDirectory(currentPath, 'design'),
    ];

    final designFiles = <String, File>{};
    for (final content in contents) {
      if (content is File && content.path.endsWith('.freezer.json')) {
        designFiles[content.path] = content;
      }
    }

    return designFiles;
  }

  List<FileSystemEntity> _readDirectory(String currentPath, String name) {
    if (Directory('$currentPath/$name').existsSync()) {
      return Directory('$currentPath/$name').listSync(recursive: true);
    }

    return [];
  }
}
