import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Slideshow extends StatelessWidget {
  final List<Widget> slides;
  final bool dotsUp;
  final Color primaryColor;
  final Color secondaryColor;
  final double primarySize;
  final double secondarySize;

  Slideshow({
    required this.slides,
    this.dotsUp = false,
    this.primaryColor = Colors.black,
    this.secondaryColor = Colors.grey,
    this.primarySize = 12,
    this.secondarySize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _SlideshowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (context) {
              Provider.of<_SlideshowModel>(context).primaryColor = this.primaryColor;
              Provider.of<_SlideshowModel>(context).secondaryColor = this.secondaryColor;
              Provider.of<_SlideshowModel>(context).primarySize = this.primarySize;
              Provider.of<_SlideshowModel>(context).secondarySize = this.secondarySize;

              return _BuildSlideshow(dotsUp: dotsUp, slides: slides);
            },
          ),
        ),
      ),
    );
  }
}

class _BuildSlideshow extends StatelessWidget {
  const _BuildSlideshow({
    required this.dotsUp,
    required this.slides,
  });

  final bool dotsUp;
  final List<Widget> slides;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (this.dotsUp)
          _Dots(
            sliderCount: this.slides.length,
          ),
        Expanded(child: _Slides(this.slides)),
        if (!this.dotsUp)
          _Dots(
            sliderCount: this.slides.length,
          )
      ],
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  _Slides(this.slides);

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageController = new PageController();

  @override
  void initState() {
    pageController.addListener(() {
      Provider.of<_SlideshowModel>(context, listen: false).currentPage = pageController.page!;
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
        children: this.widget.slides.map((slide) => _Slide(slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;

  const _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: this.slide,
    );
  }
}

class _Dots extends StatelessWidget {
  final int sliderCount;

  const _Dots({required this.sliderCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // children: [for (var i = 0; i < this.sliderCount; i++) _Dot(i)],
        children: List.generate(sliderCount, (index) => _Dot(index)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    final slideshowModel = Provider.of<_SlideshowModel>(context);
    final isCurrent = (slideshowModel.currentPage >= index - 0.5 && slideshowModel.currentPage < index + 0.5);

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: isCurrent ? slideshowModel.primarySize : slideshowModel.secondarySize,
      height: isCurrent ? slideshowModel.primarySize : slideshowModel.secondarySize,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: isCurrent ? slideshowModel.primaryColor : slideshowModel.secondaryColor,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _SlideshowModel with ChangeNotifier {
  double _currentPage = 0;
  Color _primaryColor = Colors.amber;
  Color _secondaryColor = Colors.purple;
  double _primarySize = 12;
  double _secondarySize = 12;

  double get currentPage => this._currentPage;
  Color get primaryColor => this._primaryColor;
  Color get secondaryColor => this._secondaryColor;
  double get primarySize => this._primarySize;
  double get secondarySize => this._secondarySize;

  set currentPage(double currentPage) {
    this._currentPage = currentPage;
    notifyListeners();
  }

  set primaryColor(Color primaryColor) {
    this._primaryColor = primaryColor;
  }

  set secondaryColor(Color secondaryColor) {
    this._secondaryColor = secondaryColor;
  }

  set primarySize(double primarySize) {
    this._primarySize = primarySize;
  }

  set secondarySize(double secondarySize) {
    this._secondarySize = secondarySize;
  }
}
