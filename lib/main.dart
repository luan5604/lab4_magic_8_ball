import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const Magic8BallApp());
}

class Magic8BallApp extends StatelessWidget {
  const Magic8BallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Magic 8 Ball'),
          backgroundColor: Colors.greenAccent,
        ),
        backgroundColor: Colors.blueAccent,
        body: const Magic8Ball(),
      ),
    );
  }
}

class Magic8Ball extends StatefulWidget {
  const Magic8Ball({super.key});

  @override
  _Magic8BallState createState() => _Magic8BallState();
}

class _Magic8BallState extends State<Magic8Ball> with SingleTickerProviderStateMixin {
  int ballNumber = 1;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..addListener(() {
      setState(() {}); // Cập nhật UI khi animation thay đổi
    });

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void changeBallImage() {
    setState(() {
      ballNumber = Random().nextInt(5) + 1;
    });
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: changeBallImage,
            child: SizedBox(
              width: 350,
              height: 350,
            child: ScaleTransition(
              scale: _animation,
              child: Image.asset('assets/ball$ballNumber.png'),
            ),
           ),
          ),
          const SizedBox(height: 90),
          ElevatedButton(
            onPressed: changeBallImage,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              textStyle: const TextStyle(fontSize: 30),
            ),
            child: const Text('Hỏi Magic 8 Ball'),
          ),
        ],
      ),
    );
  }
}
