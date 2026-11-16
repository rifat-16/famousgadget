import 'package:flutter/material.dart';

/// Interactive heart favorite button with bouncy spring pop animation.
class HeartPopButton extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback onToggle;
  final double size;
  final Color activeColor;
  final Color inactiveColor;

  const HeartPopButton({
    super.key,
    required this.isFavorite,
    required this.onToggle,
    this.size = 24.0,
    this.activeColor = const Color(0xFFEF4444),
    this.inactiveColor = const Color(0xFF0B1220),
  });

  @override
  State<HeartPopButton> createState() => _HeartPopButtonState();
}

class _HeartPopButtonState extends State<HeartPopButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.35).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.35, end: 1.0).chain(CurveTween(curve: Curves.bounceOut)),
        weight: 60,
      ),
    ]).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant HeartPopButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFavorite != oldWidget.isFavorite && widget.isFavorite) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _controller.forward(from: 0.0);
        widget.onToggle();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Icon(
          widget.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          color: widget.isFavorite ? widget.activeColor : widget.inactiveColor,
          size: widget.size,
        ),
      ),
    );
  }
}
