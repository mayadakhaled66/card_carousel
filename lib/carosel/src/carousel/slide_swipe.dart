import 'package:flutter/material.dart';

import 'carousel.dart';

class SlideSwipe extends StatefulWidget {
  final Carousel props;

  SlideSwipe(this.props);

  @override
  _SlideSwipeState createState() => _SlideSwipeState();
}

class _SlideSwipeState extends State<SlideSwipe> {
  int currentPage;

  bool initial;

  initiate(index) {
    try {
      currentPage = widget.props.controller.initialPage.round();
    } catch (e) {
      print("exception here => $e");
    }
    double value;
    if (index == currentPage - 1 && initial) value = 1.0;
    if (index == currentPage && initial) value = 0.0;
    if (index == currentPage + 1 && initial) {
      value = 1.0;
      initial = false;
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    currentPage = 0;
    initial = true;
    int count = widget.props.children.length;
    Widget carouserBuilder = Stack(
      children: [
        PageView.builder(
            scrollDirection: widget.props.axis,
            controller: widget.props.controller,
            // allowImplicitScrolling: true,
            itemCount: widget.props.children.length,
            onPageChanged: (i) {
              if (widget.props.updatePositionCallBack != null) {
                widget.props.updatePositionCallBack(i);
              }
              if (widget.props.onPageChange != null) {
                setState(() {
                  widget.props.onPageChange(i);
                });
              }
              currentPage = i;
            },
            allowImplicitScrolling: true,
            itemBuilder: (context, index) =>
                builder(index, widget.props.controller))
      ],
    ); //% props.children.length
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          // color: Colors.lightGreenAccent,
          height: widget.props.height,
          width: widget.props.width,
          child: widget.props.axis == Axis.horizontal
              ? carouserBuilder
              : Container(
                  child: carouserBuilder,
                ),
        ),
      ],
    );
  }

  builder(int index, PageController controller1) {
    return AnimatedBuilder(
      animation: controller1,
      builder: (context, child) {
        double value = controller1.position.haveDimensions
            ? initial
                ? initiate(index) ?? controller1.page - index
                : controller1.page - index
            : 1.0;
        value = (1 - (value.abs() * .2)).clamp(0.0, 1.0);
        return Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              // aspectRatio: value/2,
              right: -100,
              // bottom: -120,
              left: -100,
              // right: -16,
              child: Container(
                height: (widget.props.height -
                        (widget.props.axis == Axis.vertical
                            ? widget.props.height / 5
                            : 0.0)) *
                    (widget.props.axis == Axis.vertical ? 1.0 : value),
                width: widget.props.width * value,
                child: widget.props.children[index],
                alignment: Alignment.center,
              ),
            ),
          ],
        );
      },
    );
  }
}
