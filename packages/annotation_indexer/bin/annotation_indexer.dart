import 'dart:io';

import 'package:annotation_indexer/annotation_indexer.dart';

void main(List<String> _) {
  final directory = Directory('lib');

  if (!directory.existsSync()) {
    print('$directory は存在しません');
    exit(1);
  }

  final indexer = AnnotatedClassIndexer();
  indexer.processLibraries(directory.absolute.path);
}
