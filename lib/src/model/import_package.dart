// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import '../extension/string_extension.dart';
import '../freezer_identifier.dart';

class ImportPackage {
  const ImportPackage._(this.name);

  factory ImportPackage.resolveFrom(final String name) => ImportPackage._(
        FreezerIdentifier.resolveAliasName(name).toSnakeCase(),
      );

  /// The package name
  final String name;
}
