import 'package:moviehub/blocs/base/base.dart';

class HomeEvent extends BaseEvent {}

class HomeGetDataEvent extends HomeEvent {
  final int type;

  HomeGetDataEvent(this.type);
}

