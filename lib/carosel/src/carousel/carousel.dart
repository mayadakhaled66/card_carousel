import 'package:card_carousel/carosel/src/carousel/slide_swipe.dart';
import 'package:card_carousel/carosel/src/services/renderer.dart';
import 'package:card_carousel/carosel/src/services/screen_ratio.dart';
import 'package:flutter/material.dart';

typedef OnCarouselTap = Function(int);

class Carousel extends StatefulWidget {
  ///The scroll Axis of Carousel
  final Axis axis;

  final int initialPage;

  dynamic updatePositionCallBack;

  /// call back function triggers when gesture tap is registered
  final OnCarouselTap onCarouselTap;

  /// This field is required.
  ///
  /// Defines the height of the Carousel
  final double height;

  /// Defines the width of the Carousel
  final double width;

  final List<Widget> children;

  ///  callBack function on page Change
  final onPageChange;

  /// Defines the Color of the active Indicator
  final Color activeIndicatorColor;

  ///defines type of indicator to carousel
  final dynamic indicatorType;

  final bool showArrow;

  ///defines the arrow colour
  final Color arrowColor;

  ///choice to show indicator
  final bool showIndicator;

  /// Defines the Color of the non-active Indicator
  final Color unActiveIndicatorColor;

  /// Paint the background of indicator with the color provided
  ///
  /// The default background color is Color(0xff121212)
  final Color indicatorBackgroundColor;

  /// Defines if the carousel should wrap once you reach the end or if your at the begining and go left if it should take you to the end
  ///
  /// The default behavior is to allow wrapping
  final bool allowWrap;

  /// Provide opacity to background of the indicator
  ///
  /// An opacity of 1.0 is fully opaque. An opacity of 0.0 is fully transparent
  /// (i.e., invisible).
  ///
  /// The default value of opacity is 0.5 nothing is initialised.
  ///

  final double indicatorBackgroundOpacity;
  dynamic updateIndicator;
  PageController controller;
  int currentPage = 0;

  GlobalKey key;

  Carousel(
      {this.key,
      @required this.height,
      @required this.width,
      this.axis,
      this.updatePositionCallBack,
      this.showArrow,
      this.arrowColor,
      this.onPageChange,
      this.showIndicator = true,
      this.indicatorType,
      this.indicatorBackgroundOpacity,
      this.unActiveIndicatorColor,
      this.indicatorBackgroundColor,
      this.activeIndicatorColor,
      this.allowWrap = true,
      this.initialPage,
      this.onCarouselTap,
      @required this.children})
      : assert(initialPage >= 0 && initialPage < children.length,
            "intialPage must be a int value between 0 and length of children"),
        super(key: key) {
    this.createState();
  }

  @override
  createState() {
    return _CarouselState();
  }
}

class _CarouselState extends State<Carousel> {
  int position = 0;
  double animatedFactor;
  double offset;
  final GlobalKey<RendererState> rendererKey1 = new GlobalKey();
  final GlobalKey<RendererState> rendererKey2 = new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    widget.updatePositionCallBack = updatePosition;
    super.initState();
  }

  @override
  dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  updatePosition(int index) {
    if (widget.controller.page.round() == widget.children.length - 1) {
      rendererKey2.currentState.updateRenderer(false);
    }
    if (widget.controller.page.round() == widget.children.length - 2) {
      rendererKey2.currentState.updateRenderer(false);
    }
    if (widget.controller.page.round() == 1) {
      rendererKey1.currentState.updateRenderer(false);
    }
    if (widget.controller.page.round() == 0) {
      rendererKey1.currentState.updateRenderer(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    offset = 0.5;
    Size size = MediaQuery.of(context).size;
    ScreenRatio.setScreenRatio(size: size);
    animatedFactor =
        widget.axis == Axis.horizontal ? widget.width : widget.height;
    widget.controller = new PageController(
      initialPage: widget.initialPage ?? 0,
      keepPage: true,
      viewportFraction: offset,
    );
    dynamic carousel = _getCarousel(widget);
    return Container(
        // color: Colors.grey,
        child: Stack(
      children: <Widget>[
        Center(
            child: GestureDetector(
          child: carousel,
          onTap: () {
            if (widget.onCarouselTap != null) {
              widget.onCarouselTap(widget.controller.page.round());
            }
          },
        )),
      ],
    ));
  }

  _getCarousel(Carousel widget) {
    return SlideSwipe(widget);
  }
}
