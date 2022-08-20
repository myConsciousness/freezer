// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'dart_doc.dart';

class EnumElement {
  const EnumElement._({
    required this.dartDoc,
    required this.name,
    required this.value,
  });

  factory EnumElement.resolveFrom(
    final String dartDoc,
    final String name,
    final dynamic value,
  ) =>
      EnumElement._(
        dartDoc: DartDoc.resolveFrom(dartDoc),
        name: name,
        value: value,
      );

  /// The dart document
  final DartDoc dartDoc;

  /// The element name
  final String name;

  /// The element value
  final dynamic value;

  bool get hasDartDoc => dartDoc.lines.isNotEmpty;

  bool get hasValue => value != null;
}
