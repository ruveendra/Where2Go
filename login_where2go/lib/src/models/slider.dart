

import 'package:login_where2go/src/models/common.dart';

class Slider {
  String image;
  String button;
  String description;

  Slider({this.image, this.button, this.description});
}

class SliderList {
  List<Slider> _list;

  List<Slider> get list => _list;

  SliderList() {
    _list = sliderItems;
  }
}
