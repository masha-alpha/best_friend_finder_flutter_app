import 'package:flutter/material.dart';

class CardProvider extends ChangeNotifier {
  List<String> _urlImages = [];
  bool _isDragging = false;
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  double _angle = 0;

  List<String> get urlImages => _urlImages;
  bool get isDragging => _isDragging;
  Offset get position => _position;
  void setScreenSize(Size screenSize) => _screenSize = screenSize;
  double get angle => _angle;

  CardProvider() {
    resetUsers();
  }

  void startPosition(DragStartDetails details) {
    _isDragging = true;

    notifyListeners();
  }

  void updatePosition(DragUpdateDetails details) {
    _position += details.delta;

    final x = position.dx;
    _angle = 45 * x / _screenSize.width;

    notifyListeners();
  }

  void endPosition() {
    _isDragging = false;
    resetPosition();
  }

  void resetPosition() {
    _isDragging = false;
    _position = Offset.zero;
    _angle = 0;

    notifyListeners();
  }

  void resetUsers() {
    _urlImages = <String>[
      'https://images.pexels.com/photos/11202097/pexels-photo-11202097.jpeg?auto=compress&cs=tinysrgb&w=600'
          'https://images.pexels.com/photos/9180623/pexels-photo-9180623.jpeg?auto=compress&cs=tinysrgb&w=600'
          'https://images.pexels.com/photos/5480696/pexels-photo-5480696.jpeg?auto=compress&cs=tinysrgb&w=600'
          'https://images.pexels.com/photos/11930775/pexels-photo-11930775.jpeg?auto=compress&cs=tinysrgb&w=600'
          'https://images.pexels.com/photos/4068072/pexels-photo-4068072.jpeg?auto=compress&cs=tinysrgb&w=600'
          'https://images.pexels.com/photos/11159403/pexels-photo-11159403.jpeg?auto=compress&cs=tinysrgb&w=600'
          'https://images.pexels.com/photos/7143282/pexels-photo-7143282.jpeg?auto=compress&cs=tinysrgb&w=600'
    ];
  }
}
