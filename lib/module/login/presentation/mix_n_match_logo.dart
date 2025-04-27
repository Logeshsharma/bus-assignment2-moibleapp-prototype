import 'package:flutter/material.dart';

/* 

 File: [mix_n_match_logo.dart]
 1. This file has [MixNMatchLogo] - (Widget or component used in Login screen)
 2. The logo is an asset file - assets/mixnmatch.png
 3. Which is render in the UI with a basic animation using _logoAnimationController.

  
 Dependencies:
 - [https://docs.flutter.dev/ui/animations/tutorial]

*/

class MixNMatchLogo extends StatefulWidget {
  const MixNMatchLogo({super.key});

  @override
  State<MixNMatchLogo> createState() => _MixNMatchLogoState();
}

class _MixNMatchLogoState extends State<MixNMatchLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _logoAnimationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _logoAnimationController,
    curve: Curves.elasticInOut,
  ));

  @override
  void initState() {
    super.initState();
    _logoAnimationController.forward().then((_) {
      _logoAnimationController.reverse();
    });
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
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
