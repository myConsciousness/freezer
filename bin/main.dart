// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:async';

// Project imports:
import 'package:freezer/src/freezer.dart';

Future<void> main(List<String> args) async => await Freezer().execute();
