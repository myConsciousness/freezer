// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

class DartDoc {
  const DartDoc._(this.lines);

  factory DartDoc.resolveFrom(final String token) => DartDoc._(
        token.isNotEmpty ? token.split('\n') : [],
      );

  /// The lines
  final List<String> lines;
}
