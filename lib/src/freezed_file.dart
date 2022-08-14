// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:io';

// Package imports:
import 'package:dart_style/dart_style.dart';

// Project imports:
import 'freezed_resource.dart';
import 'model/freezed_object.dart';

class FreezedFile {
  FreezedFile.create(final String filePath, final String fileName)
      : _file = File('$filePath/$fileName.dart');

  /// The freezed object file.
  final File _file;

  /// The formatter for the generated Dart code.
  final _dartFormatter = DartFormatter();

  void write(final FreezedObject object) => _file.writeAsStringSync(
        _dartFormatter.format(
          FreezedResource(object).build(),
        ),
      );
}
