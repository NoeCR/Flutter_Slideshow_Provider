import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/slideshow.dart';

class SlideshowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _MySlideshow()),
          Expanded(child: _MySlideshow()),
        ],
      ),
    );
  }
}

class _MySlideshow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Slideshow(
      dotsUp: true,
      primaryColor: Colors.purple,
      secondaryColor: Colors.amber,
      primarySize: 15,
      secondarySize: 12,
      slides: [
        SvgPicture.asset('assets/img/slide-1.svg'),
        SvgPicture.asset('assets/img/slide-2.svg'),
        SvgPicture.asset('assets/img/slide-3.svg'),
        SvgPicture.asset('assets/img/slide-4.svg'),
        SvgPicture.asset('assets/img/slide-5.svg'),
      ],
    );
  }
}
