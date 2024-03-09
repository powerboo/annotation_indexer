// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// List View Routes
// **************************************************************************

import 'package:go_router/go_router.dart';
import 'package:sample_pj/domain/pine_list_view.dart';
import 'package:sample_pj/domain/apple_list_view.dart';
import 'package:sample_pj/domain/orange_list_view.dart';

final List<RouteBase> routes = [
  GoRoute(
    path: ListViewPath.pineListView,
    builder: (context, state) => const PineListView(),
  ),
  GoRoute(
    path: ListViewPath.appleListView,
    builder: (context, state) => const AppleListView(),
  ),
  GoRoute(
    path: ListViewPath.orangeListView,
    builder: (context, state) => const OrangeListView(),
  ),
];

class ListViewPath {
  static const pineListView = "/pine-list-view";
  static const appleListView = "/apple-list-view";
  static const orangeListView = "/orange-list-view";
}
