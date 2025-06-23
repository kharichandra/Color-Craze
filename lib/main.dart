import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

void main() => runApp(ColorCrazeApp());

class ColorCrazeApp extends StatelessWidget {
  const ColorCrazeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Craze',
      debugShowCheckedModeBanner: false,
      home: ColorScreen(),
    );
  }
}

class ColorScreen extends StatefulWidget {
  const ColorScreen({super.key});

  @override
  State<ColorScreen> createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  Color _currentColor = Colors.white;
  String _hexCode = "#FFFFFF";
  final RandomColor _randomColor = RandomColor();

  final List<String> _funTexts = [
    "Whoa!",
    "Boom!",
    "Nice!",
    "Yay!",
    "Zing!",
    "Splash!",
  ];
  int _textIndex = 0;

  void _changeColor() {
    final color = _randomColor.randomColor(
      colorBrightness: ColorBrightness.light,
    );

    setState(() {
      _currentColor = color;
      _hexCode = "#${color.value.toRadixString(16).substring(2).toUpperCase()}";
      _textIndex = (_textIndex + 1) % _funTexts.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeColor,
      child: Scaffold(
        backgroundColor: _currentColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                key: ValueKey<int>(_textIndex), // 👈 This forces re-animation
                animatedTexts: [
                  FlickerAnimatedText(
                    _funTexts[_textIndex],
                    textStyle: TextStyle(
                      fontSize: 48.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
                totalRepeatCount: 1,
                pause: Duration(milliseconds: 500),
              ),
              SizedBox(height: 20),
              Text('Current Color:', style: TextStyle(fontSize: 20)),
              Text(
                _hexCode,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Text(
                'Tap anywhere to change color!',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
