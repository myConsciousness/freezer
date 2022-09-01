// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

bool isRequired(final String token) => token.contains('.!required');

bool hasAliasFieldName(final String token) {
  return token.contains('.!name:') || token.contains('_');
}

bool hasAliasEnumFieldName(final String token) => token.contains('.!field:');

bool isDateTime(final String token) => token.contains('.!toDateTime');

String resolveOriginalName(final String token) {
  if (token.contains('.!')) {
    return token.split('.!')[0];
  }

  return token;
}

String resolveFileName(final String token) => _resolveName('as', token);

String resolveFieldName(final String token) => _resolveName('name', token);

String resolveEnumFieldName(final String token) => _resolveName('field', token);

bool isDartdoc(final String token) => token.startsWith('\$');

String _resolveName(final String identifier, final String token) {
  if (token.contains('.!$identifier:')) {
    final elements = token.split('.!');

    for (final element in elements) {
      if (element.startsWith('$identifier:')) {
        final start = element.indexOf('$identifier:') + '$identifier:'.length;

        return element.substring(start);
      }
    }
  }

  return resolveOriginalName(token);
}
