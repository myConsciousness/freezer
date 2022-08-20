// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:io';

// Project imports:
import 'model/dart_object.dart';
import 'resource_context.dart';

class DartFile {
  DartFile.create(final String filePath, final String fileName)
      : _file = File('$filePath/$fileName.dart');

  /// The freezed object file.
  final File _file;

  void write(final DartObject object) => _file.writeAsStringSync(
        ResourceContext(object).build(),
      );
}
