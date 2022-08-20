// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Package imports:
import 'package:dart_style/dart_style.dart';

// Project imports:
import 'model/dart_object.dart';
import 'model/object_type.dart';
import 'resource_builder.dart';

class ResourceContext {
  ResourceContext(this.object);

  final DartObject object;

  final _dartFormatter = DartFormatter();

  String build() => _dartFormatter.format(
        _resourceBuilder.execute(),
      );

  ResourceBuilder get _resourceBuilder {
    switch (object.type) {
      case ObjectType.freezed:
        return ResourceBuilder.forFreezed(object);
      case ObjectType.enumeration:
        return ResourceBuilder.forEnum(object);
    }
  }
}
