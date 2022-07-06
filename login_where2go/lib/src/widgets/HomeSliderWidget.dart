import 'package:carousel_slider/carousel_slider.dart';
import 'package:login_where2go/src/models/slider.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:login_where2go/src/models/slider.dart';

class HomeSliderWidget extends StatefulWidget {
  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {

  int _current = 0;
  SliderList _sliderList = new SliderList();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
//      fit: StackFit.expand,
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            height: 250,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: _sliderList.list.map((prefix0.Slider slide) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(slide.image), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).hintColor.withOpacity(0.2), offset: Offset(0, 4), blurRadius: 9)
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 25,
          right: 41,
//          width: config.App(context).appWidth(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: _sliderList.list.map((prefix0.Slider slide) {
              return Container(
                width: 15.0,
                height: 5.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  color: _current == _sliderList.list.indexOf(slide)
                      ? Theme.of(context).primaryColor
                      : Colors.grey[200],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
