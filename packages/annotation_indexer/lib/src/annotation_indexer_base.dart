import 'dart:io';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:path/path.dart' as path;

class AnnotatedClassIndexer {
  void processLibraries(String libPath) async {
    final libDir = Directory(libPath);
    final output = File(path.join(libPath, 'annotations.txt'));
    output.writeAsStringSync(''); // 出力ファイルを空にする

    final pathList = libDir
        .listSync(recursive: true)
        .where((e) => e.path.endsWith('.dart') && e is File)
        .map((e) => e.absolute.path)
        .toList();

    final collection = AnalysisContextCollection(includedPaths: pathList);

    for (final path in pathList) {
      final context = collection.contextFor(path);
      final result = await context.currentSession.getResolvedUnit(path);
      if (result is! ResolvedUnitResult) {
        continue;
      }

      final lib = result.libraryElement;

      for (final unit in result.libraryElement.units) {
        for (final child in unit.children) {
          if (child is! ClassElement) {
            continue;
          }
          for (final annotation in child.metadata) {
            if (annotation.element?.displayName == "IndexTarget") {
              print(lib.identifier);
              print(child.name);
              print(child.name.toKebabCase());
            }
          }
        }
      }
    }
  }
}

extension KebabCase on String {
  String toKebabCase() {
    final regExp = RegExp(r'(?<=[a-z])[A-Z]');
    return replaceAllMapped(
            regExp, (Match match) => '-${match.group(0)!.toLowerCase()}')
        .toLowerCase();
  }

  String toSnakeCase() {
    final regExp = RegExp(r'(?<=[a-z])[A-Z]');
    return replaceAllMapped(
            regExp, (Match match) => '_${match.group(0)!.toLowerCase()}')
        .toLowerCase();
  }
}
