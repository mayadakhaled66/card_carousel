library card_carousel;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_multi_carousel/carousel.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:horizontal_card_pager/card_item.dart';
import 'package:horizontal_card_pager/horizontal_card_pager.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';
import 'carosel/src/carousel/carousel.dart';
import 'carouselTest.dart';

enum carouselType { type1, type2 }

class CustomCardCarousel {
  // CustomCardCarousel(this.itemList);

// useStackPackageEdit(){
//   double textScaleFactor = 1.0;
//   final List<Widget> _positionedCards = itemList.asMap().entries.map(
//         (MapEntry<int, Widget> item) {
//       double position = -initialOffset;
//       if (_pageValue < item.key) {
//         position += (_pageValue - item.key) *
//             10 *
//             textScaleFactor;
//       }
//       double scale = 1.0;
//       if (item.key - _pageValue < 0) {
//         final double factor = 1 + (item.key - _pageValue);
//         scale = 0.95 + (factor * 0.1 / 2);
//       }
//       return Positioned.fill(
//         top: -position + (20.0 * item.key),
//         child: Align(
//           alignment: Alignment.topCenter,
//           child: Wrap(
//             children: <Widget>[
//               Transform.scale(
//                 scale: scale,
//                 child: item.value,
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   ).toList();
//   return    PageView.builder(
//       scrollDirection: Axis.vertical,
//       // controller: widget._pageController,
//       itemCount: itemList.length,
//       // onPageChanged: widget._onPageChanged,
//       itemBuilder: (BuildContext context, int index) {
//         return Stack(
//             overflow: Overflow.visible,
//             alignment: Alignment.center,
//             fit: StackFit.expand,
//             children: _positionedCards);
//       }
//
//   );
// }
}

class CardCarousel extends StatefulWidget {
  List<CardItemDetail> itemList = [];
  carouselType type;

  CardCarousel({Key key, this.itemList, this.type}) : super(key: key);

  @override
  _CardCarouselState createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  int currentExample1 = 1, currentExample2 = 0;
  double initialOffset = 40.0;
  bool initial;
  PageController pageController;

  @override
  Widget build(BuildContext context) {
    if (widget.type == carouselType.type1) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: showCustomCardCarousel1(),
      );
    } else if (widget.type == carouselType.type2) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: showCustomCardCarousel2(),
      );
    } else
      return Container();
  }

  Widget showCustomCardCarousel1() {
    // return HorizontalCard(
    //   onPageChanged: (page) => print("page : $page"),
    //   onSelectedItem: (page) => print("selected : $page"),
    //   initialPage: 0,
    //   items: itemList,
    // );
    // return Container(
    //   padding: EdgeInsets.only(top: 200),
    //   child: CarouselSlider.builder(
    //     options: CarouselOptions(
    //       viewportFraction: 0.7,
    //       initialPage: current,
    //       onPageChanged: (index, ca) {
    //         current = index;
    //         setStatCallBack();
    //       },
    //     ),
    //     itemCount: itemList.length,
    //     itemBuilder: (ctx, index, idx) {
    //       return Transform.scale(
    //         scale: index == current ? 1 : 0.8,
    //         child: Container(
    //           height: 400,
    //           width: 400,
    //           color: Colors.red,
    //           child: Center(
    //             child: Text(
    //               "$index",
    //               style: TextStyle(fontSize: 30),
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
    // return  StackedCardCarousel(
    //   items: itemList,spaceBetweenItems: 200,
    // );
    initial = true;
    pageController = PageController(viewportFraction: 0.5);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Carousel(
              height: 250.0,
              width: MediaQuery.of(context).size.width,
              initialPage: currentExample1,
              allowWrap: false,
              showIndicator: false,
              onCarouselTap: (i) {
                print("onTap $i");
              },
              onPageChange: (index) {
                setState(() {
                  currentExample1 = index;
                });
              },
              updatePositionCallBack: (index) {
                setState(() {
                  currentExample1 = index;
                });
              },
              axis: Axis.horizontal,
              showArrow: false,
              children: widget.itemList.map((data) {
                // ((i + 1) / 7)
                return AnimatedBuilder(
                  animation: pageController,
                  builder: (context, child) {
                    double value = 1.0;
                    value = initial
                        ? initiate(currentExample1) ??
                            pageController.page - currentExample1
                        : pageController.page - currentExample1;
                    value = (1 - (value.abs() * .2)).clamp(0.0, 1.0);
                    return Container(
                      height: (400 -
                              (Axis.horizontal == Axis.vertical
                                  ? 400 / 5
                                  : 0.0)) *
                          (Axis.horizontal == Axis.vertical ? 1.0 : value),
                      width: 400 * value,
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.grey,
                        color: data.color,
                        child: Icon(
                          data.icon,
                          size: 40,
                        ),
                      ),
                    );
                  },
                );
              }).toList()),
          buildTitleWidget(currentExample1)
        ],
      ),
    );
  }

  buildTitleWidget(int index) {
    if (widget.itemList.isNotEmpty && index != null)
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "${widget.itemList[index].title}",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 17),
        ),
      );
    else
      SizedBox();
  }

  Widget showCustomCardCarousel2() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // width: MediaQuery.of(context).size.width/1.5,
            child: CarouselSlider(
              options: CarouselOptions(
                // height: MediaQuery.of(context).size.height * .35,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                enlargeCenterPage: true,
                aspectRatio: 7 / 3,
                viewportFraction: .22,
                reverse: false,
                initialPage: currentExample2,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, change) {
                  setState(() {
                    currentExample2 = index;
                  });
                },
              ),
              // itemCount: itemList.length,
              items: widget.itemList.map((data) {
                return Container(
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: data.color),
                  width: MediaQuery.of(context).size.width * 3,
                  child: Card(
                    elevation: 10,
                    shadowColor: Colors.grey,
                    child: Container(
                      // width: MediaQuery.of(context).size.width * 3,
                      // height: MediaQuery.of(context).size.height,
                      // height: 80,
                      // width: 100,
                      // width:itemList.indexOf(data) == current
                      //     ? MediaQuery.of(context).size.width / 2
                      //     : MediaQuery.of(context).size.width / 4,
                      // margin: EdgeInsets.symmetric(
                      //   horizontal: 20.0, /*vertical: 10.0 */
                      // ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: data.color),
                      child: Icon(
                        data.icon,
                        size: 30,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          buildTitleWidget(currentExample2),
        ],
      ),
    );
  }

  initiate(index) {
    double value;
    if (index == currentExample1 - 1 && initial) value = 1.0;
    if (index == currentExample1 && initial) value = 0.0;
    if (index == currentExample1 + 1 && initial) {
      value = 1.0;
      initial = false;
    }
    return value;
  }
}

// class FancyCard extends StatelessWidget {
//   const FancyCard({Key key, this.icon, this.title, this.color})
//       : super(key: key);
//
//   final IconData icon;
//   final String title;
//   final Color color;
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4.0,
//       child: Column(
//         children: <Widget>[
//           Container(
//             width: 250,
//             height: 250,
//             child: Icon(icon),
//             color: color,
//           ),
//           Text(
//             title,
//             style: Theme.of(context).textTheme.headline5,
//           ),
//           OutlineButton(
//             child: const Text("Learn more"),
//             onPressed: () => print("Button was tapped"),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CardItemDetail {
  String title;
  Color color;
  IconData icon;

  CardItemDetail({this.title, this.color, this.icon});
}
//, @required List items
// HorizontalCardPager(
//   onPageChanged: (page) => print("page : $page"),
//   onSelectedItem: (page) => print("selected : $page"),
//   initialPage: 0,
//   items: items,
// ),
// return Swiper(
//   itemBuilder: (BuildContext context, int index) {
//     return Image.network(
//       "http://via.placeholder.com/288x188",
//       fit: BoxFit.fitWidth,
//       width: 20,
//       height: 50,
//     );
//   },
//   itemCount: 10,
//   viewportFraction: 0.8,
//   scale: 0.9,
//   layout: SwiperLayout.DEFAULT,
//   containerHeight: 150,
//   containerWidth: 100,
//   // customLayoutOption: CustomLayoutOption(startIndex: 0, stateCount: 2),
//   itemHeight: 150,
//   itemWidth: 100,
//   loop: true,
//   // outer: true,
//
// );

// return Swiper(
//     layout: SwiperLayout.DEFAULT,
//     // customLayoutOption: CustomLayoutOption(startIndex: -1, stateCount: 3)
//     //     .addScale([
//     //   .9, 1, 0.9
//     //   // -45.0/180,
//     //   // 0.0,
//     //   // 45.0/180
//     // ], Alignment.center).addTranslate([
//     //   Offset(-30.0, -40.0),
//     //   Offset(0.0, 0.0),
//     //   Offset(30.0, -40.0)
//     // ]),
//     itemWidth: 250.0,
//     itemHeight: 200.0,
//     scale: 0.9,
//     itemBuilder: (BuildContext context, int index) {
//       return HorizontalCardPager(
//         onPageChanged: (page) => print("page : $page"),
//         onSelectedItem: (page) => print("selected : $page"),initialPage: index,
//         // initialPage: 0,
//         items: items,
//       );
//       //  new Container(
//       //   child :Icon(itemList[index].icon),
//       //   color: itemList[index].color,
//       // );
//     },
//     autoplay: true,
//     itemCount: itemList.length);
// final controller = new PageController(initialPage: 999);
// return PageView.builder(
//   controller: controller,
//   itemBuilder: (context, index) {
//     return Container(
//       child: Icon(itemList[index%5].icon),
//       color: itemList[index%5].color,
//       width: (itemList.length - (index))*100.0,
//       height: 100,
//     );
//   },
// );
//   ListWheelScrollView(
//   children: itemList.map((element) =>
//   Container(
//           child :Icon(element.icon),
//           color: element.color,
//         )
//   ).toList(),
//   itemExtent: 100,
//   offAxisFraction: 2,
//   useMagnifier: true,
// );
