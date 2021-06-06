import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../models/slider_model.dart';

class SlideShowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new SliderModel(),
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                child: _Slides(),
              ),
              _Dots(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageController = new PageController();

  @override
  void initState() {
    pageController.addListener(() {
      print('Current page ${pageController.page}');
      Provider.of<SliderModel>(context, listen: false).currentPage = pageController.page!;
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageController,
        children: [
          _Slide('assets/img/slide-1.svg'),
          _Slide('assets/img/slide-2.svg'),
          _Slide('assets/img/slide-3.svg'),
          _Slide('assets/img/slide-4.svg'),
          _Slide('assets/img/slide-5.svg'),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String sgv;

  const _Slide(this.sgv);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: SvgPicture.asset(sgv),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Dot(0),
          _Dot(1),
          _Dot(2),
          _Dot(3),
          _Dot(4),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    final pageViewIndex = Provider.of<SliderModel>(context).currentPage;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: 12,
      height: 12,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: (pageViewIndex >= index - 0.5 && pageViewIndex < index + 0.5) ? Colors.black : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}
