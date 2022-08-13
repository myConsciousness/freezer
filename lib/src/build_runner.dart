// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'package:build_runner/src/build_script_generate/bootstrap.dart';
import 'package:io/io.dart';
import 'dart:io';

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
