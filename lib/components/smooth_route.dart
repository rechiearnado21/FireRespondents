import 'package:flutter/widgets.dart';

class SmoothRoute {
  final BuildContext context;
  final Widget child;
  const SmoothRoute({required this.context, required this.child});
  void route() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation, secondaryAnimation) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }
}
