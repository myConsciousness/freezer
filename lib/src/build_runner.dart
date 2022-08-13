// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'dart:io';

import 'package:build_runner/src/build_script_generate/bootstrap.dart';
import 'package:io/io.dart';

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
        ExitCode.tempFail.code) {}
  }
}
