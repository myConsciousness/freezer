// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import '../model/dart_doc.dart';

extension StringBufferExtension on StringBuffer {
  void writeDartDoc(final DartDoc dartDoc) {
    final lines = dartDoc.lines;

    for (int i = 0; i < lines.length; i++) {
      if (i == lines.length - 1) {
        write('/// ${lines[i]}');
        break;
      }

      writeln('/// ${lines[i]}');
    }
  }
}
