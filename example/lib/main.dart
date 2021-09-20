import 'package:card_carousel/card_carousel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var cars = [
    // CardModel(
    //     title: 'Roadster',
    //     image: 'https://wallpaperaccess.com/full/1152734.jpg',
    //     description:
    //     'As an all-electric supercar'),
    // CardModel(
    //     title: 'Model S',
    //     image: 'https://wallpapershome.com/images/pages/pic_v/8763.jpeg',
    //     description:
    //     "Model S"),
    // CardModel(
    //     title: 'Model 3',
    //     image: 'https://wallpapershome.com/images/pages/ico_v/20707.jpg',
    //     description:
    //     "Model 3"),
    // CardModel(
    //     title: 'Model X',
    //     image:
    //     'https://images.hdqwalls.com/download/tesla-model-x-front-4k-5x-1080x1920.jpg',
    //     description:
    //     "Tesla’s"),
    // CardModel(
    //     title: 'Model Y',
    //     image:
    //     'https://www.autocar.co.uk/sites/autocar.co.uk/files/images/car-reviews/first-drives/legacy/model_y_front_34_blue.jpg',
    //     description:
    //     "Tesla All-Wheel"),
    // CardModel(
    //     title: 'Cyber Truck',
    //     image: 'https://img.wallpapersafari.com/phone/750/1334/65/24/BAlZne.jpg',
    //     description:
    //     "The powerful"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Carousel Package Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static List<CardItemDetail> itemList = [
    CardItemDetail(
        title: "Alarm", icon: Icons.access_alarms, color: Colors.teal),
    CardItemDetail(title: "Add", icon: Icons.add, color: Colors.redAccent),
    CardItemDetail(
        title: "Call", icon: Icons.add_call, color: Colors.lightGreen),
    CardItemDetail(title: "WiFi", icon: Icons.wifi, color: Colors.purple),
    CardItemDetail(
        title: "File", icon: Icons.attach_file, color: Colors.deepOrange),
    CardItemDetail(title: "Air Play", icon: Icons.airplay, color: Colors.amber),
    CardItemDetail(
        title: "File", icon: Icons.attach_file, color: Colors.black26),
    CardItemDetail(
        title: "Air Play", icon: Icons.airplay, color: Colors.lightGreenAccent),
    CardItemDetail(
        title: "File", icon: Icons.attach_file, color: Colors.limeAccent),
    CardItemDetail(title: "Air Play", icon: Icons.airplay, color: Colors.pink),
  ];

  refreshCallback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CardCarousel(
                itemList: itemList,
                type: carouselType.type1,
              ),
              CardCarousel(
                itemList: itemList,
                type: carouselType.type2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
