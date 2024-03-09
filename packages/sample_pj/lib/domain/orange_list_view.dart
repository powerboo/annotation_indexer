import 'package:annotation_indexer_annotation/annotation_indexer_annotation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

final log = Logger("OrangeListView");

@IndexTarget()
class OrangeListView extends HookConsumerWidget {
  const OrangeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const OrangeListViewHeader(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('ボタン'),
        ),
      ),
    );
  }
}

class OrangeListViewHeader extends ConsumerWidget
    implements PreferredSizeWidget {
  const OrangeListViewHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.orange,
      shadowColor: Colors.transparent,
      title: const Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class OrangeListViewException implements Exception {
  late final String message;
  OrangeListViewException(final String message) {
    this.message = "[OrangeListViewException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
