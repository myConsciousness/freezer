// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

class Field {
  final String name;
  final String type;
  final String? typeVariable;

  const Field(this.name, this.type, [this.typeVariable]);

  @override
  String toString() {
    return '$name: $type';
  }
}
