// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

class FreezerIdentifier {
  static String resolveOriginalName(final String token) {
    if (token.contains('.!')) {
      return token.split('.!')[0];
    }

    return token;
  }

  static String resolveAliasName(final String token) {
    if (token.contains('.!as:')) {
      final elements = token.split('.!');

      for (final element in elements) {
        if (element.startsWith('as:')) {
          final start = element.indexOf('as:') + 'as:'.length;

          return element.substring(start);
        }
      }
    }

    return resolveOriginalName(token);
  }
}
