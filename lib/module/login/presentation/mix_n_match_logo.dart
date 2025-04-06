import 'package:flutter/material.dart';

class MixNMatchLogo extends StatefulWidget {
  const MixNMatchLogo({super.key});

  @override
  State<MixNMatchLogo> createState() => _MixNMatchLogoState();
}

class _MixNMatchLogoState extends State<MixNMatchLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticInOut,
  ));

  @override
  void initState() {
    super.initState();
    _controller.forward().then((_) {
    _controller.reverse(); 
  });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: const Image(image: AssetImage('assets/mixnmatch.png'))),
    );
  }
}
