import 'dart:io';
import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:path/path.dart' as path;
import 'package:dart_style/dart_style.dart';

final _formatter = DartFormatter();

class AnnotatedClassIndexer {
  void processLibraries(String libPath) async {
    final libDir = Directory(libPath);
    final output = File(path.join(libPath, 'route.dart'));
    output.writeAsStringSync(''); // 出力ファイルを空にする

    final pathList = libDir
        .listSync(recursive: true)
        .where((e) => e.path.endsWith('.list_view.dart') && e is File)
        .map((e) => e.absolute.path)
        .toList();

    final collection = AnalysisContextCollection(includedPaths: pathList);

    final StringBuffer buffer = StringBuffer();
    final StringBuffer importBuffer = StringBuffer();
    final StringBuffer goRouteBuffer = StringBuffer();
    final StringBuffer listViewPathClassBuffer = StringBuffer();
    final StringBuffer listViewPathListBuffer = StringBuffer();

    importBuffer.writeln('''
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// List View Routes
// **************************************************************************

''');

    importBuffer.writeln("import 'package:go_router/go_router.dart';");

    listViewPathClassBuffer.writeln("class ListViewPath {");
    listViewPathListBuffer.writeln("final List<Path> paths = [");
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
              importBuffer.writeln("import '${lib.identifier}';");

              listViewPathClassBuffer.writeln(
                  "static const Path ${child.name.toCamelCase()} = Path(\"${child.name}\");");

              goRouteBuffer.writeln('''
GoRoute(
  path: ListViewPath.${child.name.toCamelCase()}.route,
  builder: (context, state) => const ${child.name}(),
),
''');
              listViewPathListBuffer
                  .writeln('ListViewPath.${child.name.toCamelCase()},');
            }
          }
        }
      }
    }

    listViewPathClassBuffer.writeln("}");
    listViewPathListBuffer.writeln("];");

    buffer.writeln(importBuffer.toString());

    buffer.writeln("final List<RouteBase> routes= [");
    buffer.writeln(goRouteBuffer.toString());
    buffer.writeln("];");

    buffer.writeln(listViewPathClassBuffer.toString());
    buffer.writeln(listViewPathListBuffer.toString());

    buffer.writeln('''
class Path {
  final String name;

  const Path(this.name);

  String get route {
    return name.toKebabCase();
  }

  String get fullPath {
    return "/\${name.toKebabCase()}";
  }

  @override
  String toString() => name;
}

extension KebabCase on String {
  String toKebabCase() {
    final regExp = RegExp(r'(?<=[a-z])[A-Z]');
    return replaceAllMapped(
            regExp, (Match match) => '-\${match.group(0)!.toLowerCase()}')
        .toLowerCase();
  }
}

''');

    output.writeAsStringSync(_formatter.format(buffer.toString()));
  }
}

extension KebabCase on String {
  String toCamelCase() {
    return this[0].toLowerCase() + substring(1);
  }

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
