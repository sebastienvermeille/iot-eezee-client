import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedProgressBarWidget extends StatefulWidget {
  final int duration;

  const AnimatedProgressBarWidget({super.key, required this.duration});

  @override
  State<AnimatedProgressBarWidget> createState() =>
      _AnimatedProgressBarWidgetState();
}

class _AnimatedProgressBarWidgetState extends State<AnimatedProgressBarWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: Duration(seconds: widget.duration),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
              value: controller.value,
              semanticsLabel: 'Linear progress indicator',
    );
  }
}
