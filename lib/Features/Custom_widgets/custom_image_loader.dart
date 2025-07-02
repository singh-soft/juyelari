import 'dart:math' as math;
import 'package:flutter/material.dart';

class CustomImageLoader extends StatefulWidget {
  const CustomImageLoader({super.key});

  @override
  State<CustomImageLoader> createState() => _CustomImageLoaderState();
}

class _CustomImageLoaderState extends State<CustomImageLoader>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  final double radius = 40;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // Infinite loop
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildRotatingImage(String assetPath, double angleOffset) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final double angle = _controller.value * 2 * math.pi + angleOffset;
        final double x = radius * math.cos(angle);
        final double y = radius * math.sin(angle);
        return Positioned(
          left: 50 + x,
          top: 50 + y,
          child: Image.asset(assetPath, width: 30, height: 30),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        children: [
          _buildRotatingImage('assets/images/ringpic.png', 0),
          _buildRotatingImage('assets/images/thumbring.png', 2 * math.pi / 3),
          _buildRotatingImage('assets/images/diamondring.png', 4 * math.pi / 3),
            
          // Optional: Center logo or loader text
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Loading...',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}