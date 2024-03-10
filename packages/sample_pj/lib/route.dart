// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// List View Routes
// **************************************************************************

import 'package:go_router/go_router.dart';
import 'package:sample_pj/domain/pine.list_view.dart';
import 'package:sample_pj/domain/apple.list_view.dart';
import 'package:sample_pj/domain/orange.list_view.dart';

final List<RouteBase> routes = [
  GoRoute(
    path: ListViewPath.pineListView.route,
    builder: (context, state) => const PineListView(),
  ),
  GoRoute(
    path: ListViewPath.appleListView.route,
    builder: (context, state) => const AppleListView(),
  ),
  GoRoute(
    path: ListViewPath.orangeListView.route,
    builder: (context, state) => const OrangeListView(),
  ),
];

class ListViewPath {
  static const Path pineListView = Path("PineListView");
  static const Path appleListView = Path("AppleListView");
  static const Path orangeListView = Path("OrangeListView");
}

final List<Path> paths = [
  ListViewPath.pineListView,
  ListViewPath.appleListView,
  ListViewPath.orangeListView,
];

class Path {
  final String name;

  const Path(this.name);

  String get route {
    return name.toKebabCase();
  }

  String get fullPath {
    return "/${name.toKebabCase()}";
  }

  @override
  String toString() => name;
}

extension KebabCase on String {
  String toKebabCase() {
    final regExp = RegExp(r'(?<=[a-z])[A-Z]');
    return replaceAllMapped(
            regExp, (Match match) => '-${match.group(0)!.toLowerCase()}')
        .toLowerCase();
  }
}
