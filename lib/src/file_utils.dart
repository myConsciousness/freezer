// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

import 'dart:io';

Map<String, File> findDesignFiles(String currentPath) {
  final contents = [
    ..._readDirectory(currentPath, 'design'),
  ];

  final designFiles = <String, File>{};
  for (final content in contents) {
    if (content is File && content.path.endsWith('.freezer.json')) {
      designFiles[content.path] = content;
    }
  }

  return designFiles;
}

List<FileSystemEntity> _readDirectory(String currentPath, String name) {
  if (Directory('$currentPath/$name').existsSync()) {
    return Directory('$currentPath/$name').listSync(recursive: true);
  }

  return [];
}
