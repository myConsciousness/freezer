// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

class FreezerException implements Exception {
  /// The error message
  final String message;

  const FreezerException(this.message);

  @override
  String toString() => 'FreezerException: $message';
}
