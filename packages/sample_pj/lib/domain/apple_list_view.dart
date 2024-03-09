import 'package:annotation_indexer_annotation/annotation_indexer_annotation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

final log = Logger("AppleListView");

@IndexTarget()
class AppleListView extends HookConsumerWidget {
  const AppleListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppleListViewHeader(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text('ボタン'),
        ),
      ),
    );
  }
}

class AppleListViewHeader extends ConsumerWidget
    implements PreferredSizeWidget {
  const AppleListViewHeader({Key? key}) : super(key: key);

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

class AppleListViewException implements Exception {
  late final String message;
  AppleListViewException(final String message) {
    this.message = "[AppleListViewException] $message";
  }
  @override
  String toString() {
    return message;
  }
}
