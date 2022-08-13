// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'freezed_resource.dart';

class FreezedFile {
  FreezedFile(final String filePath, final String fileName)
      : _file = File('$filePath/$fileName.dart');

  /// The freezed file.
  final File _file;

  /// The formatter for the generated Dart code.
  final _dartFormatter = DartFormatter();

  void write(final FreezedResource resource) => _file.writeAsStringSync(
        _dartFormatter.format(resource.build()),
      );
}
