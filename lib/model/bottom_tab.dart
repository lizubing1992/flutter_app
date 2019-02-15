import 'package:flutter/material.dart';

class BottomTab {
  final Text title;
  final Icon icon;

  const BottomTab({this.title, this.icon});
}

/// Tab类别
enum TabCategory { news, category, meizi, favorite }

List<BottomTab> bottomTabs = [
  const BottomTab(title: const Text('最新'), icon: const Icon(Icons.fiber_new)),
  const BottomTab(title: const Text('分类'), icon: const Icon(Icons.view_module)),
  const BottomTab(
      title: const Text('妹子'), icon: const Icon(Icons.filter_vintage)),
  const BottomTab(title: const Text('收藏'), icon: const Icon(Icons.favorite)),
];
