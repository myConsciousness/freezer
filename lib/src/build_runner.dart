// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// ignore_for_file: implementation_imports

// Dart imports:
import 'dart:io';

// Package imports:
import 'package:build_runner/src/build_script_generate/bootstrap.dart';

abstract class BuildRunner {
  factory BuildRunner() => _BuildRunner();

  Future<void> run();
}

class _BuildRunner implements BuildRunner {
  const _BuildRunner();

  @override
  Future<void> run() async {
    while ((exitCode = await generateAndRun(
          ['build'],
        )) ==
        75) {}
  }
}
