import 'dart:async';
import 'package:flutter/material.dart';
import 'package:teaching_assistant/components/colors.dart';
import 'homepage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation; // Animation for the downward motion
  late Animation<Color?>
      _colorAnimation; // Animation for background color change

  @override
  void initState() {
    super.initState();

    // Initialize the controller with a duration of 2.5 seconds
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Total duration for fade and slide
      vsync: this,
    );

    // Fade animation - from invisible (0.0) to visible (1.0)
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    // Slide animation - moves slightly upward
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero, // Starts at its original position
      end: const Offset(0.0, -0.3), // Moves slightly upward
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Color animation - changes background from white to your desired color
    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: AppColors.primaryColor, // Change this to your desired end color
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the animation
    _controller.forward();

    // After 2 seconds, trigger the navigation to the homepage
    Timer(const Duration(seconds: 2), () {
      _controller.reverse(); // Reverse the downward motion slightly

      // Navigate to the HomePage with the Hero transition after the reverse is complete
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2), // Increased duration
          pageBuilder: (_, __, ___) => HomePage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Always dispose the controller when done
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _colorAnimation.value, // Set background color
          body: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation, // Adds the upward motion
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'images/ai_logo.png',
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
