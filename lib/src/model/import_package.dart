// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import '../extension/string_extension.dart';
import '../policy/freezer_identifier.dart' as identifier;
import 'reference.dart';

class Import {
  const Import._(this.path, this.name);

  factory Import.fromCurrent(final String name) => Import._(
        null,
        identifier.resolveFileName(name).toSnakeCase(),
      );

  factory Import.fromExternal(final Reference reference) => Import._(
        reference.path,
        reference.name,
      );

  /// The path to the object
  final String? path;

  /// The package name
  final String name;

  bool get hasPath => path != null;

  /// Whether [path] references an external package
  bool get hasPackageReference => path?.startsWith('package:') ?? false;
}
