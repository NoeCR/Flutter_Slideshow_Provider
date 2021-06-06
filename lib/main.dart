import 'package:flutter/material.dart';
import 'package:slideshow/src/pages/slideshow_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slideshow App',
      home: SlideshowPage(),
    );
  }
}
