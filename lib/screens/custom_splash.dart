import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart'; // Lottie-Paket importieren

class CustomSplash extends StatefulWidget {
  const CustomSplash({super.key});

  @override
  State<CustomSplash> createState() => _CustomSplashState();
}

class _CustomSplashState extends State<CustomSplash> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie Animation einbinden
            SizedBox(
              width: 150,
              height: 150,
              child: Lottie.asset(
                'assets/animation.json', // Pfad zu deiner Lottie-Datei
                repeat: false,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "ToDo App",
              style: TextStyle(
                color: Colors.teal,
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
