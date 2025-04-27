import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showUsernamePasswordDialog(String title, String description) {
  Get.dialog(AnimatedDialog(
    title: title,
    description: description,
  ));
}

class AnimatedDialog extends StatefulWidget {
  final String title;
  final String description;
  const AnimatedDialog({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  State<AnimatedDialog> createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
            begin: const Offset(0.0, 0.0), end: const Offset(0.0, 0.1))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransition(
        position: _offsetAnimation,
        child: FadeTransition(
          opacity: _controller.drive(Tween(begin: 0.0, end: 1.0)),
          child: CupertinoAlertDialog(
            title: Text(widget.title),
            content: Text(widget.description),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
