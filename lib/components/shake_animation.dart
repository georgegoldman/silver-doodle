import 'package:flutter/material.dart';

/// A widget that applies a shaking animation to its child.
///
/// The [ShakeAnimation] widget wraps its child with an animation that
/// continuously shifts the child's position horizontally back and forth,
/// creating a shaking effect.
class ShakeAnimation extends StatefulWidget {
  /// The child widget to which the shaking animation is applied.
  final Widget child;

  /// Creates a [ShakeAnimation] widget.
  ///
  /// The [child] parameter is required and specifies the widget to animate.
  const ShakeAnimation({Key? key, required this.child}) : super(key: key);

  @override
  State<ShakeAnimation> createState() => _ShakeAnimationState();
}

class _ShakeAnimationState extends State<ShakeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true); // Repeats the animation back and forth
    // Define the animation
    _animation = Tween<Offset>(
      begin: const Offset(-0.05, 0.0), // Start position
      end: const Offset(0.05, 0.0), // End position
    ).animate(_controller);
  }

  @override
  void dispose() {
    // Dispose the animation controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Apply the slide transition animation to the child widget
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}
