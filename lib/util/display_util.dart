import 'package:flutter/material.dart';

class DisPlayUtil {
  /// 获取屏幕宽度
  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  ///界面切换动画
  static SlideTransition createTransition(
      Animation<double> animation, Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }
}
