// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

extension StringExtension on String {
  String toSnakeCase() => replaceAllMapped(
      RegExp(r'([A-Z])'), (match) => '_${match.group(0)!.toLowerCase()}');

  String toCamelCase() {
    final words = split('_');
    final camelCase = StringBuffer();
    camelCase.write(words.removeAt(0));

    for (final word in words) {
      camelCase.write(word[0].toUpperCase());
      camelCase.write(word.substring(1));
    }

    return camelCase.toString();
  }

  String toUpperCamelCase() {
    final words = split('_');
    final upperCamelCase = StringBuffer();

    for (final word in words) {
      upperCamelCase.write(word[0].toUpperCase());
      upperCamelCase.write(word.substring(1));
    }

    return upperCamelCase.toString();
  }
}
