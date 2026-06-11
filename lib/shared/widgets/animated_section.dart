import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedSection extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final String visibilityKey;
  final Offset slideOffset;

  const AnimatedSection({
    super.key,
    required this.child,
    required this.visibilityKey,
    this.delay = Duration.zero,
    this.slideOffset = const Offset(0, 40),
  });

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.visibilityKey),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        opacity: _visible ? 1.0 : 0.0,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 600),
          offset: _visible ? Offset.zero : Offset(widget.slideOffset.dx / 100, widget.slideOffset.dy / 100),
          curve: Curves.easeOutCubic,
          child: widget.child,
        ),
      ),
    );
  }
}

/// Staggered animation wrapper using flutter_animate
class StaggeredFadeIn extends StatelessWidget {
  final List<Widget> children;
  final Duration staggerDelay;
  final Duration initialDelay;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool isRow;

  const StaggeredFadeIn({
    super.key,
    required this.children,
    this.staggerDelay = const Duration(milliseconds: 100),
    this.initialDelay = Duration.zero,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.isRow = false,
  });

  @override
  Widget build(BuildContext context) {
    final animatedChildren = children.asMap().entries.map((e) {
      final delay = initialDelay + staggerDelay * e.key;
      return e.value
          .animate()
          .fadeIn(duration: 600.ms, delay: delay)
          .slideY(begin: 0.3, end: 0, duration: 600.ms, delay: delay, curve: Curves.easeOutCubic);
    }).toList();

    if (isRow) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: animatedChildren,
      );
    }
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: animatedChildren,
    );
  }
}
